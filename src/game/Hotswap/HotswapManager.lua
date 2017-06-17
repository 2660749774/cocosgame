--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2017/6/17
-- Time: 15:02
-- To change this template use File | Settings | File Templates.
-- HotswapController 热更管理器
local HotswapController = class("HotswapController")

local UserDefaultUtil = require("core.util.UserDefaultUtil")
local HotswapData = require("game.Hotswap.HotswapData")
local WebUtil = require("core.net.WebUtil")

--------------------------------
-- 构造函数
-- @function [parent=#HotswapController] ctor
function HotswapController:ctor(view, confmgr)
    -- 配置管理器
    self.confmgr = confmgr
    -- 视图信息
    self.view = view

    -- 当前版本信息
    self.localVersion = {}

    -- 动更目录
    self.updateDir = "update"

    -- 临时解压目录
    self.tempDir = "tmp"

    -- 当前状态
    self.state = 0

    -- 文件管理器
    self.fileUtils = cc.FileUtils:getInstance()

    -- 重试次数
    self.retryCount = 0
    -- 是否有更新
    self.hasUpdate = false
    -- 更新信息
    self.updateInfo = nil
    -- cdn游标
    self.cdnIndex = 1
end

--------------------------------
-- 检查动更
-- @function [parent=#HotswapController] start
function HotswapController:start()
    -- 获取本地版本号
    self:getLocalVersion()

    -- 请求服务器动更信息
    self:checkUpdate()
end

--------------------------------
-- 动更结束
-- @function [parent=#HotswapController] over
function HotswapController:over()

end

--------------------------------
-- 检查版本号
-- @function [parent=#HotswapController] checkUpdate
function HotswapController:checkUpdate()
    local resVersion = self.localVersion.resVersion
    local clientVersion = self.localVersion.clientVersion
    local buildNo = self.localVersion.buildNo
    local game = self.confmgr.conf.game
    local channelId = self.confmgr:channelId()
    local packType = self.localVersion.packType

    local url = self.confmgr.conf.hotswapUrl
    local paramPattern = "game=%s&channelId=%s&resVersion=%s&clientVersion=%s&buildNo=%s&packType=%s"
    local param = string.format(paramPattern, game, channelId, resVersion, clientVersion, buildNo, packType)

    WebUtil.sendRequest(url, handler(self, self.doVersionCheck), "GET")
end


--------------------------------
-- 处理版本检查
-- @function [parent=#HotswapController] doVersionCheck
function HotswapController:doVersionCheck(data)
    if data.state == cc.HTTP.StateProgress then
        return
    end

    if data.state ~= cc.HTTP.StateCompleted then
        -- 下载失败
        self.retryCount = self.retryCount + 1
        if self.retryCount >= 3 then
            -- 检测版本信息失败
            self:over()
            return
        end

        self:checkUpdate()
    end

    --[[
        {
            "state":1,
            -- 动更
            "data":{
                "state":1,
                "tips":"动更提示消息",
                "file":"1.0.0.0/2.0.0.0",
                "cdnList":[
                    "http://res.cdn.com/game/cn_android"
                ]
                "md5":"123456",
                "fileSize":1212121
            }
            -- 推荐强更
            "data":{
                "state":2,
                "forceTips":"推荐新版本更新",
                "forceUrl":"推荐强更的地址",
                "tips":"动更提示消息",
                "file":"1.0.0.0/2.0.0.0",
                "cdnList":[
                    "http://res.cdn.com/game/cn_android"
                ]
                "md5":"123456",
                "fileSize":1212121
            }

            -- 强制强更
            "data":{
                "state":3,
                "forceTips":"推荐新版本更新",
                "forceUrl":"推荐强更的地址"
            }
        }
    ]]--

    local response = json.decode(data.data)
    if response and response.state == 1 then
        if response.data.state == 0 then
            -- 没有动更
            self:over()
        elseif response.data.state == 1 then
            -- 资源更新
            self:doResUpdate(response.data)
        elseif response.data.state == 2 then
            -- 推荐强更
            self:doClientUpdate(response.data)
        elseif response.data.state == 3 then
            -- 强制更新
            self:doClientUpdate(response.data)
        else
            -- 不正常的state
            self:over()
        end
    else
        -- 服务器异常
        self:over()
    end
end

--------------------------------
-- 获取资源更新
-- @function [parent=#HotswapController] doResUpdate
function HotswapController:doResUpdate(data)
    --[[
        "data":{
            "state":1,
            "tips":"动更提示消息",
            "file":"1.0.0.0/2.0.0.0",
            "cdnList":[
                "http://res.cdn.com/game/cn_android"
            ]
            "md5":"123456",
            "fileSize":1212121
        }
    ]]--
    -- 存储更新信息
    self.updateInfo = data
    self:showUpdatePopup(data.tips, data.fileSize, handler(self, self.downloadResUpdate))

end

--------------------------------
-- 下载资源更新
-- @function [parent=#HotswapController] downloadResUpdate
function HotswapController:downloadResUpdate()
    if self.cdnIndex > #self.updateInfo.cdnList then
        self.cdnIndex = 1
    end
    local url = self.updateInfo.cdnList[self.cdnList]
    url = self:getURL(url, self.updateInfo.file) 

    
end

--------------------------------
-- 弹出动更提示框
-- @function [parent=#HotswapController] getLocalVersion
function HotswapController:showUpdatePopup(tips, fileSize, callback)
    self.view:showUpdatePopup(tips, fileSize, callback)
end

--------------------------------
-- 获取本地版本号
-- @function [parent=#HotswapController] getLocalVersion
function HotswapController:getLocalVersion()
    -- 获取底包版本号
    local originVersion = require("game.version")

    -- 获取资源版本号
    local resVersion = UserDefaultUtil.getStringForKey(HotswapData.version.resKey, "")
    if resVersion == "" then
        resVersion = originVersion.resVersion
        UserDefaultUtil.setStringForKey(HotswapData.version.resKey, resVersion)
    end

    -- 获取客户端版本号
    local clientVersion = UserDefaultUtil.getStringForKey(HotswapData.version.clientKey, "")
    if clientVersion == "" then
        clientVersion = originVersion.clientVersion
        UserDefaultUtil.setStringForKey(HotswapData.version.clientKey, clientVersion)
    end
    clientVersion = originVersion.clientVersion

    -- 获取底包类型
    local packType = UserDefaultUtil.getStringForKey(HotswapData.version.packType, "")
    if packType == "" then
        packType = originVersion.packType
        UserDefaultUtil.setStringForKey(HotswapData.version.packType, packType)
    end


    self.localVersion = {resVersion = resVersion, clientVersion = clientVersion, buildNo = originVersion.buildNo, packType = packType}
end

--------------------------------
-- 清除缓存重新载入模块
-- @function [parent=#HotswapController] reloadModule
function HotswapController:reloadModule(moduleName)
    if package.loaded[moduleName] ~= nil then
        package.loaded[moduleName] = nil
    end
    return require(moduleName)
end

--------------------------------
-- 获取URL
-- @function [parent=#HotswapController] getURL
function HotswapController:getURL(rootUrl, value)
    if string.endwith(rootUrl, "/") then
        return rootUrl .. value
    else
        return rootUrl .. "/" .. value
    end
end


return HotswapController