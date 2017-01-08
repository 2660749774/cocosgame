--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisScene 俄罗斯方块
local TetrisScene = class("TetrisScene", BaseScene)

--------------------------------
-- 创建方法
-- @function [parent=#TetrisScene] onCreate
function TetrisScene:onCreate()
    local layout = require("layout.TetrisMainScene").create()
    self:fixLayout(layout)

    -- 添加事件监听
    self.btnSingle = layout['btn_single']
    self.btnMultiplayer = layout['btn_multiplayer']
    self.inputHost = cc.EditBox:create(cc.size(250, 70), cc.Scale9Sprite:create(), cc.Scale9Sprite:create())
    self.inputHost:setAnchorPoint(0.5, 0.5)
    self.inputHost:setPosition(125, 35)
    self.inputHost:setFontColor(cc.c3b(0, 128, 0))
    self.inputHost:setText("192.168.0.116")
    self.inputHost:setInputMode(6)
    layout['bg_input']:addChild(self.inputHost)
    

    self.btnSingle:addClickEventListener(handler(self, self.playSingle))
    self.btnMultiplayer:addClickEventListener(handler(self, self.playMulti))

    self:addObject(layout["root"], "scene")
end

--------------------------------
-- 单机模式
-- @function [parent=#TetrisScene] playSingle
function TetrisScene:playSingle()
    self:pushPanel("Tetris.view.TetrisSingle")
end

--------------------------------
-- 联网模式
-- @function [parent=#TetrisScene] playSingle
function TetrisScene:playMulti()
    local host = self.inputHost:getText()
    log:info("host %s", host)
    if host == nil or host == "" then
        Tips.showSceneTips("请输入连接的主机名称", 2)
        return
    end
    self:pushPanel("Tetris.view.TetrisMulti", {host})
end

--------------------------------
-- 卸载资源
-- @function [parent=#TetrisScene] onExit
function TetrisScene:onExit()
    -- 卸载资源
end

return TetrisScene

