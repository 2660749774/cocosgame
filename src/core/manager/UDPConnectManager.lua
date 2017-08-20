--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/30
-- Time: 11:49
-- To change this template use File | Settings | File Templates.
-- UDPConnectManager 连接管理器
local UDPConnectManager = class("UDPConnectManager")

-- heartbeat间隔
local HEART_BEAT_INTERVAL = 60

-- zlib解压缩
local zlib = require("zlib")
local ByteArray = utils.ByteArray

--------------------------------
-- 构造函数
-- @function [parent=#UDPConnectManager] ctor
function UDPConnectManager:ctor(compress)
    self.socket = nil -- 当前Socket
    self.host = nil -- 连接的主机
    self.port = nil -- 连接的端口号

    -- 请求回调
    self.requestCallback = {}

    -- 推送回调
    self.pushCallback = {}
    self.requestId = 1

    -- 连接状态回调
    self.connCallback = {}

    -- buff缓冲区
    self._buff = ByteArray.new(ByteArray.ENDIAN_BIG)

    -- 是否启用压缩
    self.compress = compress or false
    
    log:info("init udp cmgr succ")
end

--------------------------------
-- 创建连接
-- @function [parent=#UDPConnectManager] open
function UDPConnectManager:open(conv, host, port)
    if self.socket then
        -- 关闭以前连接
        self.socket:close()
        self.socket = nil
        self.host = nil
        self.port = nil
    end

    -- 建立新的连接
    local socket = net.SocketUDP.new()

    log:info("open udp conv:%s, host:%s, port:%s", conv, host, port)

    socket:addEventListener(net.SocketUDP.EVENT_DATA, handler(self, self.reciveDate))
    socket:addEventListener(net.SocketUDP.EVENT_CLOSE, handler(self, self.udpClose))
    socket:addEventListener(net.SocketUDP.EVENT_CONNECTED, handler(self, self.udpConnected))
    socket:connect(conv, host, port)
    
    self.socket = socket
    self.host = host
    self.port = port
end

--------------------------------
-- 发送请求
-- @function [parent=#UDPConnectManager] send
function UDPConnectManager:send(action, ...)
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
    
    -- requestId递增
    self.requestId = self.requestId + 1
    log:info("send data %s %s", action.command, #args)
end

--------------------------------
-- 添加推送callback
-- @function [parent=#UDPConnectManager] addPushCallback
function UDPConnectManager:addPushCallback(command, callback)
    if self.pushCallback[command] == nil then
        self.pushCallback[command] = {}
    end

    table.insert(self.pushCallback[command], callback)
end

--------------------------------
-- 移除推送callback
-- @function [parent=#UDPConnectManager] addPushCallback
function UDPConnectManager:removePushCallback(command, callback)
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
-- @function [parent=#UDPConnectManager] close
function UDPConnectManager:close()
    self.socket:close()
end

--------------------------------
-- 判断网络是否连接
-- @function [parent=#UDPConnectManager] isConnected
function UDPConnectManager:isConnected() 
    if not self.socket then
        return false
    end
    return self.socket.isConnected
end

--------------------------------
-- 关闭连接成功
-- @function [parent=#UDPConnectManager] udpClose
function UDPConnectManager:udpClose(event)
    log:info("udp closed")
    local event = {type="close", status="succ"}
    for _, callback in pairs(self.connCallback) do
        callback(event)
    end
end

--------------------------------
-- 创建连接
-- @function [parent=#UDPConnectManager] udpConnected
function UDPConnectManager:udpConnected(event)
    log:info("udp connect succ")
    local event = {type="conn", status="succ"}
    for _, callback in pairs(self.connCallback) do
        callback(event)
    end
end

--------------------------------
-- 创建连接
-- @function [parent=#UDPConnectManager] udpData 接受到udp数据
function UDPConnectManager:reciveDate(event)
    -- log:info("recive data")
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
-- @function [parent=#UDPConnectManager] decode 解码
function UDPConnectManager:decode()
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
    log:info("udp recv command:%s, requestId:%d", command, requestId)
    log:info("udp recv content:%s", content)
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
            Tips.showSceneTips(msg, 1)
        end
    end
end

return UDPConnectManager

