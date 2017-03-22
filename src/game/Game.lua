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


    -- ucmgr:open(1, "127.0.0.1", "8010")
    -- ucmgr:send(actions.doUpdate, protos.KEY_PRESS, 1, 1, 3)


    -- 切换到入口函数
    self:changeScene("Tetris")
    self:text()
end

function Game:text()
    local text = "<font color='#09126' size=15>sdf</font>abc<font color='#09127' size=20>def</font>111[dsfsdf]"

    -- text = string.gsub(text, "<font color='(.-)' size=([0-9]-)>(.-)</font>", "<color=%1><size=%2>%3</size></color>")
    text = string.gsub(text, '<font color=\'(#%w-)%\' size=(%d-)>(.-)</font>', '<color=%1><size=%2>%3</size></font>')
    text = string.gsub(text, "<font color='(.-)'>(.-)</font>", "<color=%1>%2</color>")
    text = string.gsub(text, "%[(.-)%]", "<color=blue>%1</color>")
    log:info("text:%s", text)
end

return Game
