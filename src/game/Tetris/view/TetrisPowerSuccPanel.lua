--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisPowerSuccPanel 俄罗斯方块
-- 副本开始弹框
local TetrisPowerSuccPanel = class("TetrisPowerSuccPanel", BasePanel)

--------------------------------
-- 创建方法
-- @function [parent=#TetrisPowerSuccPanel] onCreate
function TetrisPowerSuccPanel:onCreate(powerId, armyId, star, score)
    local layout = require("layout.PowerSuccPopup").create()

    log:info("showSuccPanel powerI:%s, armyId:%s, star:%s, score:%s", powerId, armyId, star, score)

    self.powerId = powerId
    self.armyId = armyId

    self.lbPowerName = layout['lb_powername']
    self.btnPowerContinue = layout['btn_powercontinue']
    self.btnClose = layout['btn_close']
    self.star1 = layout['sp_star1']
    self.star2 = layout['sp_star2']
    self.star3 = layout['sp_star3']
    self.score = layout['al_score']

    -- 设置关卡名称
    self.lbPowerName:setString(string.format("第 %s 关", armyId))

    -- 设置分数
    self.score:setString(tostring(score))
    if star >= 3 then
        self.star1:setVisible(true)
        self.star2:setVisible(true)
        self.star3:setVisible(true)
    elseif star >= 2 then
        self.star1:setVisible(true)
        self.star2:setVisible(true)
    else 
        self.star1:setVisible(true)
    end

    self:addLayoutWithMask(layout, "layout.ModalMask")

    self.btnPowerContinue:addClickEventListener(handler(self, self.powerContinue))
    self.btnClose:addClickEventListener(function() 
        self:getScene():popPanel()
        self:getScene():popPanel()
    end)
end

--------------------------------
-- 点击挑战副本
-- @function [parent=#TetrisPowerSuccPanel] powerContinue
function TetrisPowerSuccPanel:powerContinue()
    self:getScene():popPanel()
    self:getScene():popAndPushPanel("Tetris.view.TetrisPowerStart", {self.powerId, self.armyId + 1})
end

--------------------------------
-- 设置目标方块
-- @function [parent=#TetrisPowerSuccPanel] setTargetBlock
function TetrisPowerSuccPanel:setTargetBlock()
    local armyType = self.powerConf.armyType

    if armyType == 1 or armyType == 4 then
        local pic = string.format("tetris/%s.png", self.powerDetailconf.blockType)
        self.spTarget:setTexture(pic)
    elseif armyType == 2 then
        self.spTarget:setVisible(false)
    elseif armyType == 3 then
        self.spTarget:setTexture("tetris/fangkuai9.png")
        local animationLayout = require("layout.TetrisMeteorAnimation").create()
        local meteor = animationLayout['root']
        local animation = animationLayout['animation']
        self.spTarget:addChild(meteor)
        meteor:runAction(animation)
        animation:gotoFrameAndPlay(0)
    end
end



return TetrisPowerSuccPanel

