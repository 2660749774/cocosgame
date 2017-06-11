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

    self.lbArmynum = layout['lb_armynum']
    self.lbPowerName = layout['lb_powername']
    self.btnPowerStart = layout['btn_powerstart']
    self.lbTarget1 = layout['lb_target1']
    self.spTarget1 = layout['sp_target1']
    self.lbTarget2 = layout['lb_target2']
    self.spTarget2 = layout['sp_target2']
    self.targetIntro = layout['lb_target_intro']
    self.btnClose = layout['btn_close']
    self.lbTips = layout['lb_tips']

    -- 设置关卡数
    if powerId == 1 then
        self.lbArmynum:setString(armyId)
    else
        self.lbArmynum:setString(59 + armyId)
    end

    -- 设置目标名称
    self.lbPowerName:setString(self.powerDetailconf.targetName)

    -- 更新方块内容
    self:setTargetBlock()

    -- 更新star
    -- local queryKey = "power." .. powerId .. "." .. armyId
    -- local star = utils.gameArchive:queryData(queryKey)
    -- if star == nil then
    -- elseif star >= 3 then
    --     self.star1:setVisible(true)
    --     self.star2:setVisible(true)
    --     self.star3:setVisible(true)
    -- elseif star >= 2 then
    --     self.star1:setVisible(true)
    --     self.star2:setVisible(true)
    -- elseif star >= 1 then
    --     self.star1:setVisible(true)
    -- end

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

    if armyType == TetrisPowerConf.TYPE_CLEAR_STONE or armyType == TetrisPowerConf.TYPE_MAZE then
        self.spTarget1:setTexture("ui/tetris/power/water_bg.png")
        self.spTarget1:setPosition(323, 395)
        self.spTarget2:setVisible(false)
        self.lbTarget1:setString("使用有限的方块")
        self.lbTarget1:setAnchorPoint(0.5, 0.5)
        self.lbTarget1:setPosition(323, 346)
        self.lbTarget2:setString("清理陨石")
        self.lbTarget2:setAnchorPoint(0.5, 0.5)
        self.lbTarget2:setPosition(323, 312)
        self.lbTips:setString("消除所有的陨石就能发现水源")
    elseif armyType == TetrisPowerConf.TYPE_TIMEMODE then
        self.spTarget1:setTexture("ui/tetris/power/time_bg.png")
        self.lbTarget1:setString(string.format("%s秒内", self.powerDetailconf.maxTime))
        self.spTarget2:setTexture("ui/tetris/power/score_bg.png")
        self.lbTarget2:setString(string.format("获得%s分", self.powerDetailconf.scoreNum))
        self.lbTips:setString("注意方块中的小奖励哦")
    elseif armyType == TetrisPowerConf.TYPE_METEOR2 then
        self.spTarget1:setTexture("ui/tetris/power/time_bg.png")
        self.lbTarget1:setString(string.format("%s秒内", self.powerDetailconf.maxTime))
        self.spTarget2:setTexture("ui/tetris/power/meteor_bg.png")
        self.lbTarget2:setString(string.format("收集%s颗星辰", self.powerDetailconf.scoreNum))
        self.lbTips:setString("只有3个连在一起的星辰才能被收集")
    elseif armyType == TetrisPowerConf.TYPE_SPAR then
        self.spTarget1:setTexture("ui/tetris/power/time_bg.png")
        self.lbTarget1:setString(string.format("%s秒内", self.powerDetailconf.maxTime))
        self.spTarget2:setTexture("ui/tetris/power/spar_bg.png")
        self.lbTarget2:setString(string.format("收集%s颗能量石", self.powerDetailconf.collectBlockNum))
        self.lbTips:setString("能量石无法被消除，让它掉落到底部")
    end
end



return TetrisPowerStartPanel

