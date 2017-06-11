--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisPowerFailPanel 俄罗斯方块
-- 副本开始弹框
local TetrisPowerFailPanel = class("TetrisPowerFailPanel", BasePanel)
local TetrisPowerConf = import("..data.TetrisPowerConf")

--------------------------------
-- 创建方法
-- @function [parent=#TetrisPowerFailPanel] onCreate
function TetrisPowerFailPanel:onCreate(powerId, armyId, score, needScore, parent)
    local layout = require("layout.PowerFailPopup").create()

    self.parent = parent
    self.powerId = powerId
    self.armyId = armyId
    self.powerConf = TetrisPowerConf.loadConfig(powerId, armyId)
    self.powerDetailconf = TetrisPowerConf.loadDetailConfig(powerId, armyId)

    self.btnRetry = layout['btn_powerretry']
    self.btnClose = layout['btn_close']
    self.lbReward = layout['lb_reward']

    self:addLayoutWithMask(layout, "layout.ModalMask")

    -- 减少生命
    utils.gameArchive:loseLife(1)

    self.btnRetry:addClickEventListener(handler(self, self.powerRetry))
    self.btnClose:addClickEventListener(function() 
        self:getScene():popPanel()
        self:getScene():popPanel()
    end)
end

--------------------------------
-- 点击挑战副本
-- @function [parent=#TetrisPowerFailPanel] powerContinue
function TetrisPowerFailPanel:powerRetry()
    if utils.gameArchive:queryData("lifes") < 1 then
        Tips.showSceneTips("您的生命值已耗费完毕，请等待恢复", 2)
        return
    end
    
    local parent = self.parent
    self:getScene():popPanel()
    parent:restartGame()
end


return TetrisPowerFailPanel

