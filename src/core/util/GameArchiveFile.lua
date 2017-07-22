--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/27
-- Time: 16:44
-- To change this template use File | Settings | File Templates.
-- GameArchiveFile 存储游戏信息的文件
local GameArchiveFile = class("GameArchiveFile")
local scheduler = require("core.scheduler")

--------------------------------
-- 构造函数
-- @function [parent=#GameArchiveFile] ctor
function GameArchiveFile:ctor()
    self.fileName = "archivedata"
    self.data = {}
    self.aesKey = "1234567890abcDEF"
    self.version = 0
    self.lifes = 0
    self.nextLifeTime = 0
end

--------------------------------
-- 获取玩家存档数据
-- @function [parent=#GameArchiveFile] getData
function GameArchiveFile:getData()
    return self.data
end

--------------------------------
-- 查询指定Key
-- @function [parent=#GameArchiveFile] putData
function GameArchiveFile:queryData(key)
    local array = string.split(key, ".")
    local _data = self.data
    for _, k in pairs(array) do
        if type(_data) == "table" and _data[k] then
            _data = _data[k]
        else
            return nil
        end
    end
    return _data
end

--------------------------------
-- 存入指定Key
-- @function [parent=#GameArchiveFile] putData
function GameArchiveFile:putData(key, value)
    local array = string.split(key, ".")
    local _data = self.data
    for id, k in pairs(array) do
        if id == #array then
            _data[k] = value
            return
        end
        if not _data[k] or not (type(_data[k]) == "table") then
            _data[k] = {}
            _data = _data[k]
        else
            _data = _data[k]
        end
    end
end

--------------------------------
-- 减少生命
-- @function [parent=#GameArchiveFile] loseLife
function GameArchiveFile:loseLife(num)
    self.lifes = self.lifes - num
    emgr:dispatchEvent(EventDefine.PLAYER_LIFES_UPDATE, self.lifes)
    self:saveData()

    self:syncLifeData()
end

--------------------------------
-- 打印存档
-- @function [parent=#GameArchiveFile] printData
function GameArchiveFile:printData()
    log:info("archivedata:%s", json.encode(self.data))
end

--------------------------------
-- 同步网络数据
-- @function [parent=#GameArchiveFile] syncServerData
function GameArchiveFile:syncServerData()
    cmgr:send(actions.getPowerData, function(response) 
        if response.data.version > self.version then
            self.data = json.decode(response.data.powerData)
            self.version = response.data.version
            self.data.version = version
            self:savePowerData(false)
        else
            -- 网络同步进度
            self:syncPowerData()
        end
    end)

    -- 同步生命信息
    self:syncLifeData()
end

--------------------------------
-- 从文件中载入玩家存档
-- @function [parent=#GameArchiveFile] loadData
function GameArchiveFile:loadData()
    local path = self:getFilePath()
    local content = nil
    if io.exists(path) then
        content = io.readfile(path)
        content = utils.crypto.decryptAES256(content, self.aesKey)
        log:info("file content:%s", content)
    else
        content = "{}"
        log:info("archive file not found, path:%s", path)
    end

    

    self.data = json.decode(content)
    self.version = self.data.version or 1
    self.lifes = self.data.lifes or 5 -- 默认5条生命
    self.nextLifeTime = self.data.nextLifeTime or 0

    log:info("lifes:%s, nextLifeTime:%s, version:%s", self.lifes, self.nextLifeTime, self.version)

    self.data.version = self.version
    self.data.lifes = self.lifes
    self.data.nextLifeTime = self.nextLifeTime

    -- 定义schedler调用
    self.updateScheduler = scheduler.scheduleGlobal(handler(self, self.update), 1)
end

--------------------------------
-- 将玩家存档刷入文件
-- @function [parent=#GameArchiveFile] savePowerData
function GameArchiveFile:savePowerData(syncNet)
    if syncNet then
        self.version = self.version + 1
        self.data.version = self.version

        -- 同步网络
        self:syncPowerData()
    end

    self:saveData()
end

--------------------------------
-- 同步副本数据
-- @function [parent=#GameArchiveFile] syncPowerData
function GameArchiveFile:syncPowerData()
    local powerData = {}
    powerData.version = self.version
    powerData.power = self.data.power
    powerData.progress = self.data.progress

    -- 网络同步进度
    cmgr:send(actions.syncPowerData, nil, json.encode(powerData))
end

--------------------------------
-- 同步生命值
-- @function [parent=#GameArchiveFile] syncLifeData
function GameArchiveFile:syncLifeData()
    cmgr:send(actions.syncLife, function(response) 
        local lifes = response.data.lifes
        local nextLifeTime = response.data.nextLifeTime
        -- if lifes ~= self.lifes or timestamp ~= self.timestamp then
        --     self.lifes = lifes
        --     self.timestamp = timestamp
        --     emgr:dispatchEvent(EventDefine.PLAYER_LIFES_UPDATE, self.lifes)
        --     self:saveData()
        -- end
    end, self.lifes, self.nextLifeTime)
end

--------------------------------
-- 定时调用
-- @function [parent=#GameArchiveFile] update
function GameArchiveFile:update()
    self:updateLifeData()
end

--------------------------------
-- 更新生命数据
-- @function [parent=#GameArchiveFile] updateLifeData
function GameArchiveFile:updateLifeData()
    local currTime = os.time()
    log:info("update life curr:%s, next:%s", currTime, self.nextLifeTime)

    -- 数据改变标志
    local dataChange = false

    if self.nextLifeTime == 0 then
        -- 刚刚创建的用户
        self.nextLifeTime = currTime + Constants.RECOVERLIFE_INTERVAL
        dataChange = true
    else
        -- 恢复体力
        while (currTime > self.nextLifeTime) do
            self:addLife(1)
            if self.lifes >= Constants.MAX_LIFES then
                -- 正常恢复了
                self.nextLifeTime = self.nextLifeTime + Constants.RECOVERLIFE_INTERVAL
            else
                -- 没有恢复
                self.nextLifeTime = currTime + Constants.RECOVERLIFE_INTERVAL
            end
            dataChange = true
        end
    end

    if dataChange then
        self:saveData()
        self:syncLifeData()
    end

end

--------------------------------
-- 恢复生命
-- @function [parent=#GameArchiveFile] addLife
function GameArchiveFile:addLife(num)
    if (self.lifes + num) > Constants.MAX_LIFES then
        self.lifes = Constants.MAX_LIFES
    else
        self.lifes = self.lifes + 1
    end
    emgr:dispatchEvent(EventDefine.PLAYER_LIFES_UPDATE, self.lifes)
end

--------------------------------
-- 保存数据
-- @function [parent=#GameArchiveFile] saveData
function GameArchiveFile:saveData()
    -- 设定数据
    self.data.version = self.version
    self.data.lifes = self.lifes
    self.data.nextLifeTime = self.nextLifeTime

    local content = json.encode(self.data)
    local path = self:getFilePath()
    log:info("save data content:%s, path:%s", content, path)

    -- 进行加密
    content = utils.crypto.encryptAES256(content, self.aesKey)
    local rtn = io.writefile(path, content)
    log:info("save data rtn:%s", rtn)    
end

--------------------------------
-- 获取文件路径
-- @function [parent=#GameArchiveFile] getFilePath
function GameArchiveFile:getFilePath()
    local path = string.gsub(device.writablePath, "[\\\\/]+$", "") .. device.directorySeparator .. self.fileName
    log:info("writablePath:%s", device.writablePath)
    log:info("filePath:%s", path)

    return path
end



return GameArchiveFile