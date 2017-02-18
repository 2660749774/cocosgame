--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisPowerStartPanel 俄罗斯方块
-- 副本开始弹框
local TetrisPowerStartPanel = class("TetrisPowerStartPanel", BasePanel)
local TetrisPowerConf = import("..data.TetrisPowerConf")

--------------------------------
-- 创建方法
-- @function [parent=#TetrisPowerStartPanel] onCreate
function TetrisPowerStartPanel:onCreate(powerId, armyId)
    local layout = require("layout.PowerStartPopup").create()
    log:info("powerId:%s, armyId:%s", powerId, armyId)
    self.powerConf = TetrisPowerConf.loadConfig(powerId, armyId)
    self.powerDetailconf = TetrisPowerConf.loadDetailConfig(powerId, armyId)

    self.lbPowerName = layout['lb_powername']
    self.btnPowerStart = layout['btn_powerstart']
    self.lbTarget = layout['lb_target']
    self.spTarget = layout['sp_target']
    self.btnClose = layout['btn_close']

    -- 设置关卡名称
    self.lbPowerName:setString(string.format("第 %s 关", armyId))

    -- 设置目标名称
    self.lbTarget:setString(self.powerDetailconf.targetName)

    -- 更新方块内容
    self:setTargetBlock()

    self:addLayoutWithMask(layout, "layout.ModalMask")

    self.btnPowerStart:addClickEventListener(handler(self, self.powerStart))
    self.btnClose:addClickEventListener(function() 
        self:getScene():popPanel()
    end)
end

--------------------------------
-- 点击挑战副本
-- @function [parent=#TetrisPowerStartPanel] powerStart
function TetrisPowerStartPanel:powerStart()
    local animationLayout = require("layout.TetrisStartAnimation").create()
    animationLayout['panel']:setAnchorPoint(0.5, 0.5)
    animationLayout['panel']:setPosition(display.cx, display.cy)
    self:getScene():addObject(animationLayout['root'], "modal")

    local animation = animationLayout['animation']
    animationLayout['root']:runAction(animation)
    animation:setLastFrameCallFunc(function()
        animationLayout['root']:removeFromParent()
    end)
    animation:setFrameEventCallFunc(function(frame)
        if frame:getEvent() == "loadNext" then
            self:getScene():popAndPushPanel("Tetris.view." .. self.powerConf.module, {self.powerConf.powerId, self.powerConf.armyId})
        end
    end)
    animation:gotoFrameAndPlay(0, false) 
end

--------------------------------
-- 设置目标方块
-- @function [parent=#TetrisPowerStartPanel] setTargetBlock
function TetrisPowerStartPanel:setTargetBlock()
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



return TetrisPowerStartPanel

