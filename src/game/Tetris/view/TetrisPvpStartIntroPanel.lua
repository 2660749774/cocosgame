--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisPvpStartIntroPanel 俄罗斯方块Pvp介绍模块
-- 副本开始介绍
local TetrisPvpStartIntroPanel = class("TetrisPvpStartIntroPanel", BasePanel)
local TetrisPowerConf = import("..data.TetrisPowerConf")

--------------------------------
-- 创建方法
-- @function [parent=#TetrisPvpStartIntroPanel] onCreate
function TetrisPvpStartIntroPanel:onCreate(scheduleData, callback)
    local layout = require("layout.TetrisPvpStartIntro").create()
    self.disableTransition = true
    self.lbSelf = layout['lb_self']
    self.lbTarget = layout['lb_target']
    self.panel = layout['panel']
    self.callback = callback

    -- 设置目标名称
    if scheduleData.att.isHost then
        self.lbSelf:setString(scheduleData.att.playerName)
        self.lbTarget:setString(scheduleData.def.playerName)
    else
        self.lbSelf:setString(scheduleData.def.playerName)
        self.lbTarget:setString(scheduleData.att.playerName)
    end

    self:addLayoutWithMask(layout, "layout.ModalMask")
    self.panel:setPosition(display.cx, 0)

    self:playAnimation()
end

--------------------------------
-- 播放动画
-- @function [parent=#TetrisPvpStartIntroPanel] onCreate
function TetrisPvpStartIntroPanel:playAnimation()
    local action1 = cc.EaseSineOut:create(cc.MoveTo:create(0.2, cc.p(display.cx, display.cy + 140)))
    local action2 = cc.DelayTime:create(2)
    local action3 = cc.MoveTo:create(0.1, cc.p(display.cx, display.cy + 100))
    local action4 = cc.EaseSineIn:create(cc.MoveTo:create(0.3, cc.p(display.cx, display.height + 280)))
    local sequence = cc.Sequence:create(action1, action2, action3, action4, cc.CallFunc:create(function()
        if self.callback then
            self.callback()
        end
        self:getScene():popPanel()
    end))

    self.panel:runAction(sequence)
end

return TetrisPvpStartIntroPanel

