--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/30
-- Time: 11:49
-- To change this template use File | Settings | File Templates.
-- ConnectManger 连接管理器
local ConnectManger = class("ConnectManger")

-- heartbeat间隔
local HEART_BEAT_INTERVAL = 60

-- zlib解压缩
local zlib = require("zlib")
local ByteArray = utils.ByteArray

--------------------------------
-- 构造函数
-- @function [parent=#ConnectManger] ctor
function ConnectManger:ctor(compress)
    self.socket = nil -- 当前Socket
    self.host = nil -- 连接的主机
    self.port = nil -- 连接的端口号

    -- 主动请求回调
    self.requestCallback = {}
    self.requestId = 1

    -- 推送回调
    self.pushCallback = {}

    -- 连接状态回调
    self.connCallback = {}

    -- 计时
    self._lastTime = os.time()

    -- buff缓冲区
    self._buff = ByteArray.new(ByteArray.ENDIAN_BIG)

    -- 是否启用压缩
    self.compress = compress or false

    emgr:addEventListener(EventDefine.APP_STATE_CHANGE, handler(self, self.onAppStateChange))
    
    log:info("init cmgr succ")
end

--------------------------------
-- 创建连接
-- @function [parent=#ConnectManger] open
function ConnectManger:open(host, port)
    if self.socket then
        if self.socket.isConnected then
            -- 关闭以前连接
            self.socket:close()
        end
        self.socket:disconnect()
        self.socket = nil
        self.host = nil
        self.port = nil
    end

    -- 建立新的连接
    local socket = net.SocketTCP.new()
    socket:setName("Tcp")
    socket:setTickTime(0)
    socket:setConnectTimeoutTickTime(0.5)
    socket:setReconnTime(6)
    socket:setConnFailTime(1)

    socket:addEventListener(net.SocketTCP.EVENT_DATA, handler(self, self.reciveDate))
    socket:addEventListener(net.SocketTCP.EVENT_CLOSE, handler(self, self.tcpClose))
    socket:addEventListener(net.SocketTCP.EVENT_CLOSED, handler(self, self.tcpClosed))
    socket:addEventListener(net.SocketTCP.EVENT_CONNECTED, handler(self, self.tcpConnected))
    socket:addEventListener(net.SocketTCP.EVENT_CONNECT_FAILURE, handler(self, self.tcpConnectedFail))
    socket:connect(host, port)
    
    self.socket = socket
    self.host = host
    self.port = port
    self.networkName = nativeBridge.getNetworkName()
end

--------------------------------
-- 发送请求
-- @function [parent=#ConnectManger] send
function ConnectManger:send(action, callback, ...)
    if not self.socket.isConnected then
        log:info("网络未连接")
        return
    end

    local args = string.format(action.args, ...)
    local pack = ByteArray.new(ByteArray.ENDIAN_BIG)

    -- 写包长
    local dataLen = 32 + 4 + string.len(args)
    pack:writeInt(dataLen)
    
    -- 写command，补齐32位
    pack:writeString(action.command)
    for i=string.len(action.command) + 1, 32 do 
        pack:writeByte(0)
    end
    -- 写RequestId
    pack:writeInt(self.requestId)
    
    -- 写包体
    pack:writeString(args)
    
    -- 发送请求
    self.socket:send(pack:getPack())
    
    -- 注册回调
    if callback then
        self.requestCallback[self.requestId] = callback
    end
    
    -- requestId递增
    self.requestId = self.requestId + 1
    -- log:info("send data %s %s", action.command, #args)
end

--------------------------------
-- 添加推送callback
-- @function [parent=#ConnectManger] addPushCallback
function ConnectManger:addPushCallback(command, callback)
    if self.pushCallback[command] == nil then
        self.pushCallback[command] = {}
    end

    table.insert(self.pushCallback[command], callback)
end

--------------------------------
-- 添加连接事件回调
-- @function [parent=#ConnectManger] addConnCallback
function ConnectManger:addConnCallback(callback)
    table.insert(self.connCallback, callback)
end

--------------------------------
-- 移除连接事件回调
-- @function [parent=#ConnectManger] removeConnCallback
function ConnectManger:removeConnCallback(callback)
    for index, value in pairs(self.connCallback) do
        if value == callback then
            table.remove(self.connCallback, index)
        end
    end
end

--------------------------------
-- 移除推送callback
-- @function [parent=#ConnectManger] addPushCallback
function ConnectManger:removePushCallback(command, callback)
    local callbacks = self.pushCallback[command]
    if nil == callbacks then
        return
    end

    for index, _callback in pairs(callbacks) do
        if _callback == callback then
            table.remove(callbacks, index)
            break
        end
    end
end

--------------------------------
-- 关闭连接
-- @function [parent=#ConnectManger] close
function ConnectManger:close()
    self.socket:close()
end

--------------------------------
-- 判断网络是否连接
-- @function [parent=#ConnectManger] isConnected
function ConnectManger:isConnected() 
    if not self.socket then
        return false
    end
    return self.socket.isConnected
end

--------------------------------
-- 关闭连接
-- @function [parent=#ConnectManger] tcpClose
function ConnectManger:tcpClose(event)
    log:info("tcp closed")
    local event = {type="close", status="begin"}
    for _, callback in pairs(self.connCallback) do
        callback(event)
    end
end

--------------------------------
-- 关闭连接成功
-- @function [parent=#ConnectManger] tcpClose
function ConnectManger:tcpClosed(event)
    log:info("tcp closed")
    local event = {type="close", status="succ"}
    for _, callback in pairs(self.connCallback) do
        callback(event)
    end
end

--------------------------------
-- 创建连接
-- @function [parent=#ConnectManger] tcpClose
function ConnectManger:tcpConnected(event)
    log:info("tcp connect succ")
    local event = {type="conn", status="succ"}
    for _, callback in pairs(self.connCallback) do
        callback(event)
    end
end

--------------------------------
-- 创建连接
-- @function [parent=#ConnectManger] tcpClose
function ConnectManger:tcpConnectedFail(event)
    log:info("tcp connect fail")
    local event = {type="conn", status="fail"}
    for _, callback in pairs(self.connCallback) do
        callback(event)
    end
end

--------------------------------
-- 处理AppState改变
-- @function [parent=#ConnectManger] onAppStateChange
function ConnectManger:onAppStateChange(event)
    if event == "enterForeground" then
        -- 后台切回前台，重新建立连接
        if self:isConnected() then
            self:close()
            self:open(self.host, self.port)
        end
    else
        local networkName = nativeBridge.getNetworkName()
        if networkName ~= self.networkName then
            -- 网络发生变化重连
            if self:isConnected() then
                self:close()
                self:open(self.host, self.port)
            end
        end
    end
end

--------------------------------
-- 创建连接
-- @function [parent=#ConnectManger] tcpData 接受到TCP数据
function ConnectManger:reciveDate(event)
    -- log:info("recive data")
    -- 心跳
    local currTime = os.time()
    if currTime - self._lastTime > HEART_BEAT_INTERVAL then
        --self:heartbeat()
        self._lastTime = currTime
    end

    -- 接受数据
    self._buff:writeBuf(event.data)
    self._buff:setPos(1)

    -- 解析包
    while self._buff:getAvailable() <= self._buff:getLen() do
        -- 长度不够
        if self._buff:getLen() < 4 then
            break
        end

        -- 解码包
        self:decode()

        -- 缓冲区读取结束
        if self._buff:getAvailable() == 0 then
            break
        end
    end

    -- 粘包处理
    if self._buff:getAvailable() > 0 then
        local new_buff = ByteArray.new(ByteArray.ENDIAN_BIG)
        new_buff:writeBuf(self._buff:readBuf(self._buff:getAvailable()))
        self._buff = new_buff
    else
        self._buff = ByteArray.new(ByteArray.ENDIAN_BIG)
    end
end

--------------------------------
-- 解码包
-- @function [parent=#ConnectManger] decode 解码
function ConnectManger:decode()
    if self._buff:getAvailable() < 4 then
        return
    end
    
    local len = self._buff:readInt() -- 总长度
    if self._buff:getAvailable() < len then
        self._buff:setPos(self._buff:getPos() - 4)
        return
    end

    -- 读取command
    local command = self._buff:readString(32)
    local requestId = self._buff:readInt()
    local content = self._buff:readBuf(len - 36)

    -- 解压缩
    if self.compress then
        content,a,b,c = zlib.inflate()(content)
    end

    -- 打印日志
    command = trim(command)
    -- log:info("recv command:%s, requestId:%d", command, requestId)
    -- log:info("recv content:%s", content)
    -- 转换为json
    local response = json.decode(content)
    
    -- push推送
    if requestId == 0 then
        local callbacks = self.pushCallback[command]
        if nil ~= callbacks then
            for _, callback in pairs(callbacks) do
                callback(response)
            end
        end
        return
    end
    
    -- 调用回调
    if response.state == 1 then
        local callback = self.requestCallback[requestId]
        if callback then
            callback(response)
            self.requestCallback[requestId] = nil
        end
    else
        self.requestCallback[requestId] = nil
        local msg = response.data.msg
        if msg then
            Tips.showSceneTips(msg, 1, Tips.ERROR_COLOR)
        end
    end
end

return ConnectManger

