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
    -- 游戏core初始化
    require "core.init"

    -- 游戏game初始化
    require "game.init"
    
    -- app暴露给全局
    cc.exports.app = self

    -- 初始化native桥
    nativeBridge.init()

    if confmgr.config.checkUpdate then
        -- 进行动更
        local hotswap = require("game.hotswap.HotSwapController").new(nil, confmgr)
        hotswap:start()
    else
        -- 切换到入口函数
        self:changeScene("Login")
    end
end

return Game
