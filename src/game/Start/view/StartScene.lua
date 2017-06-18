--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2016/6/4
-- Time: 13:09
-- To change this template use File | Settings | File Templates.
-- StartScene 开始场景
local StartScene = class("StartScene", BaseScene)


--------------------------------
-- 创建方法
-- @function [parent=#StartScene] onCreate
function StartScene:onCreate()
    local layout = require("layout.TetrisStart").create()
    self:fixLayout(layout)
    self.btnPlay = layout['btn_play']
    self.anim = layout['animation']
    self:runAction(self.anim)

    -- 添加监听器
    self.btnPlay:addClickEventListener(handler(self, self.playGame))
    self.anim:gotoFrameAndPlay(0)

    self:addObject(layout["root"], "scene")
end

--------------------------------
-- 开始游戏
-- @function [parent=#StartScene] playGame
function StartScene:playGame()
     app:changeScene("Tetris")
end

--------------------------------
-- 卸载资源
-- @function [parent=#StartScene] onExit
function StartScene:onExit()
-- 卸载资源
end


return StartScene

