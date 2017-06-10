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
    self.targetIntro = layout['lb_target_intro']
    self.btnClose = layout['btn_close']
    self.star1 = layout['sp_star1']
    self.star2 = layout['sp_star2']
    self.star3 = layout['sp_star3']

    -- 设置关卡名称
    self.lbPowerName:setString(string.format("第 %s 关", armyId))

    -- 设置目标名称
    self.lbTarget:setString(self.powerDetailconf.targetName)

    -- 更新方块内容
    self:setTargetBlock()

    -- 更新star
    local queryKey = "power." .. powerId .. "." .. armyId
    local star = utils.gameArchive:queryData(queryKey)
    if star == nil then
    elseif star >= 3 then
        self.star1:setVisible(true)
        self.star2:setVisible(true)
        self.star3:setVisible(true)
    elseif star >= 2 then
        self.star1:setVisible(true)
        self.star2:setVisible(true)
    elseif star >= 1 then
        self.star1:setVisible(true)
    end

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
    if utils.gameArchive:queryData("lifes") < 1 then
        Tips.showSceneTips("您的生命值已耗费完毕，请等待恢复", 2)
        return
    end
    
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

    if armyType == TetrisPowerConf.TYPE_CLEAR_STONE or armyType == TetrisPowerConf.TYPE_MAZE or armyType == TetrisPowerConf.TYPE_SPAR then
        local pic = string.format("tetris/%s.png", self.powerDetailconf.blockType)
        self.spTarget:setTexture(pic)
        self.targetIntro:setVisible(false)
    elseif armyType == TetrisPowerConf.TYPE_TIMEMODE then
        self.spTarget:setVisible(false)
        self.targetIntro:setString(self.powerDetailconf.targetIntro)
        self.targetIntro:setColor(cc.c3b(218, 88, 100))
    elseif armyType == TetrisPowerConf.TYPE_METEOR2 then
        self.targetIntro:setVisible(false)
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

