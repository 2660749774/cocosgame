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

    -- 游戏core初始化
    require "core.init"

    -- 游戏game初始化
    require "game.init"

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

        -- 游戏core初始化
        require "core.init"

        -- 游戏game初始化
        require "game.init"
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
            package.loaded[moduleName] = nil
        end
    end
end

--------------------------------
-- 记录无需载入的名单
-- @function [parent=#Game] recordNoReloadModule
function Game:recordNoReloadModule()
    for moduleName, _ in pairs(package.loaded) do
        print("moduleName:" .. moduleName)
        if moduleName ~= "config" then
            self.noReloadModule[moduleName] = true
        end
    end
end

return Game
