--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisPvpEndIntroPanel 俄罗斯方块
-- 副本开始介绍
local TetrisPvpEndIntroPanel = class("TetrisPvpEndIntroPanel", BasePanel)
local TetrisPowerConf = import("..data.TetrisPowerConf")

--------------------------------
-- 创建方法
-- @function [parent=#TetrisPvpEndIntroPanel] onCreate
function TetrisPvpEndIntroPanel:onCreate(isWin, callback)
    local layout = require("layout.TetrisPvpEndIntro").create()
    self.disableTransition = true
    self.lbIntro = layout['lb_intro']
    self.panel = layout['panel']
    self.callback = callback

    log:info("pvp end isWin:%s, callback:%s", isWin, self.callback)
    if isWin then
        -- 设置目标名称
        self.lbIntro:setString("胜利了！")
    else
        -- 设置目标名称
        self.lbIntro:setString("失败了！")
    end

    self:addLayoutWithMask(layout, "layout.ModalMask")
    self.panel:setPosition(display.cx, display.height + 203)

    self:playAnimation()
end

--------------------------------
-- 播放动画
-- @function [parent=#TetrisPvpEndIntroPanel] onCreate
function TetrisPvpEndIntroPanel:playAnimation()
    local action1 = cc.EaseSineOut:create(cc.MoveTo:create(0.2, cc.p(display.cx, display.cy + 101.5)))
    local action2 = cc.DelayTime:create(2)
    local action3 = cc.MoveTo:create(0.1, cc.p(display.cx, display.cy + 140))
    local action4 = cc.EaseSineIn:create(cc.MoveTo:create(0.3, cc.p(display.cx, 0)))
    local sequence = cc.Sequence:create(action1, action2, action3, action4, cc.CallFunc:create(function()
        local callback = self.callback
        local scene = self:getScene()
        scene:popPanel()

        -- callback
        callback()
    end))

    self.panel:runAction(sequence)
end

return TetrisPvpEndIntroPanel

