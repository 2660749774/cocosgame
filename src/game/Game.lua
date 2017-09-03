--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/27
-- Time: 16:44
-- To change this template use File | Settings | File Templates.
-- Game 游戏App

-- mvc导入
cc.exports.BaseScene = require "core.mvc.BaseScene"
cc.exports.BaseApp = require "core.mvc.BaseApp"
cc.exports.BasePanel = require "core.mvc.BasePanel"
cc.exports.BaseView = require "core.mvc.BaseView"


local Game = class("MyApp", BaseApp)

--------------------------------
-- 创建方法
-- @function [parent=#Game] onCreate
function Game:onCreate()
end

--------------------------------
-- 启动游戏
-- @function [parent=#Game] startup
function Game:startup()
    -- 无需重新加载的模块
    self.noReloadModule = {}

    -- app暴露给全局
    cc.exports.app = self

    -- 记录无需重新加载的模块
    self:recordNoReloadModule()

    -- 处理应用覆盖安装
    self:doAppCoverInstall()

    -- 载入全球模块
    self:loadGlobalModule()

    if confmgr.config.checkUpdate then
        -- 进行动更
        self:changeScene("Hotswap")
    else
        -- 切换到入口函数
        self:enterGame(false)
    end
end

--------------------------------
-- 重新载入游戏
-- @function [parent=#Game] enterGame
function Game:enterGame(hasUpdated)
    if hasUpdated then
        -- 清理缓存资源
        cc.FileUtils:getInstance():purgeCachedEntries()

        -- 重在Lua模块
        self:reloadLuaCode()

        -- 载入全局模块
        self:loadGlobalModule()
    end

    -- 初始化native桥
    nativeBridge.init()

    -- 进入游戏
    self:changeScene("Login")
end

--------------------------------
-- 重新载入Lua
-- @function [parent=#Game] reloadLuaCode
function Game:reloadLuaCode()
    for moduleName, _ in pairs(package.loaded) do
        if self.noReloadModule[moduleName] ~= true then
            log:info("reload module:%s", moduleName)
            package.loaded[moduleName] = nil
        end
    end
end

--------------------------------
-- 载入全局模块
-- @function [parent=#Game] loadGlobalModule
function Game:loadGlobalModule()
    -- 游戏core初始化
    require "core.init"

    -- 游戏game初始化
    require "game.init"
end

--------------------------------
-- 记录无需载入的名单
-- @function [parent=#Game] recordNoReloadModule
function Game:recordNoReloadModule()
    for moduleName, _ in pairs(package.loaded) do
        if moduleName ~= "config"
            and moduleName ~= "core.mvc.BaseView"
            and moduleName ~= "core.mvc.BaseApp"
            and moduleName ~= "core.mvc.BasePanel"
            and moduleName ~= "core.mvc.BaseScene"
            and moduleName ~= "game.Game"
            and moduleName ~= "core.log" then
            print("no reload moduleName:" .. moduleName)
            self.noReloadModule[moduleName] = true
        end
    end
end

--------------------------------
-- 处理应用覆盖安装
-- @function [parent=#Game] doAppCoverInstall
function Game:doAppCoverInstall()
    -- 添加搜索路径
    local TAG = "game"

    -- 获取底包版本号
    local originVersion = require("game.version")
    log:tag(TAG, "底包资源版本号:%s", originVersion.resVersion)
    log:tag(TAG, "底包客户端版本号:%s", originVersion.clientVersion)
    log:tag(TAG, "底包编译版本号:%s", originVersion.buildNo)
    log:tag(TAG, "底包类型:%s", originVersion.packType)

    -- 获取动更资源版本号
    local userDefault = cc.UserDefault:getInstance()
    local fileUtils = cc.FileUtils:getInstance()
    local resMove = userDefault:getStringForKey("resMoving", "false")
    local resVersion = userDefault:getStringForKey("resVersion", "")
    local updateDir = userDefault:getStringForKey("resDir", "")

    log:tag(TAG, "资源版本号:%s", resVersion)
    log:tag(TAG, "资源移动标志位:%s", resMove)
    log:tag(TAG, "资源所在目录:%s", updateDir)

    if resVersion ~= "" then
        -- 动更过
        local appCoverInstall = false

        local originVersionArray = string.split(originVersion.resVersion, ".")
        for i=1, 4 do
            originVersionArray[i] = tonumber(originVersionArray[i])
        end
        local resVersionArray = string.split(resVersion, ".")
        for i=1, 4 do
            resVersionArray[i] = tonumber(resVersionArray[i])
        end
        for i=1, 4 do
            if originVersionArray[i] > resVersionArray[i] then
                appCoverInstall = true
            end
        end

        local writePath = fileUtils:getWritablePath()
        if string.sub(writePath, -1, -1) ~= "/" then
            writePath = writePath .. "/"
        end
        if updateDir == "" then
            updateDir = "update"
        end

        log:tag(TAG, "覆盖安装:%s", appCoverInstall)
        log:tag(TAG, "是否在移动:%s", resMove)
        if appCoverInstall then
            local updatePath = writePath .. updateDir
            log:tag(TAG, "移除动更目录:%s", updatePath)
            fileUtils:removeDirectory(updatePath)
        end
    end
end

return Game
