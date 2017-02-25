--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/27
-- Time: 16:44
-- To change this template use File | Settings | File Templates.
-- GameArchiveFile 存储游戏信息的文件
local GameArchiveFile = class("GameArchiveFile")

--------------------------------
-- 构造函数
-- @function [parent=#GameArchiveFile] ctor
function GameArchiveFile:ctor()
    self.fileName = "archivedata"
    self.data = {}
    self.aesKey = "1234567890abcDEF"
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
-- 打印存档
-- @function [parent=#GameArchiveFile] printData
function GameArchiveFile:printData()
    log:info("archivedata:%s", json.encode(self.data))
end

--------------------------------
-- 从文件中载入玩家存档
-- @function [parent=#GameArchiveFile] loadData
function GameArchiveFile:loadData()
    local path = self:getFilePath()
    if not io.exists(path) then
        log:info("archive file not found, path:%s", path)
        return
    end

    local content = io.readfile(path)
    content = utils.crypto.decryptAES256(content, self.aesKey)
    log:info("file content:%s", content)

    self.data = json.decode(content)
end

--------------------------------
-- 将玩家存档刷入文件
-- @function [parent=#GameArchiveFile] saveData
function GameArchiveFile:saveData()
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