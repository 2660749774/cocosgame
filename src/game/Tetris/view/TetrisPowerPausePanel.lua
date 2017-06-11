--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisPowerPausePanel 俄罗斯方块
-- 副本暂停弹框

local TetrisPowerPausePanel = class("TetrisPowerPausePanel", BasePanel)

--------------------------------
-- 创建方法
-- @function [parent=#TetrisPowerPausePanel] onCreate
function TetrisPowerPausePanel:onCreate(parent)
    local layout = require("layout.PowerPausePopup").create()

    log:info("parent:%s", parent)
    
    self.volState = 1

    self.btnContinue = layout['btn_continue']
    self.btnVol = layout['btn_vol']
    self.btnQuit = layout['btn_endgame']
    self.btnClose = layout['btn_close']
    self.parent = parent

    self.btnVol:loadTextureNormal("ui/tetris/power/vol_off.png",0)
    self.btnVol:loadTexturePressed("ui/tetris/power/vol_off.png",0)
    self.btnVol:loadTextureDisabled("ui/tetris/power/vol_off.png",0)

    self:addLayoutWithMask(layout, 'layout.ModalMask')

    self.btnContinue:addClickEventListener(handler(self, self.handleContinue))
    self.btnClose:addClickEventListener(handler(self, self.handleContinue))
    self.btnVol:addClickEventListener(handler(self, self.handleVol))
    self.btnQuit:addClickEventListener(handler(self, self.handleQuit))
end

function TetrisPowerPausePanel:handleContinue()
    local parent = self.parent
    self:getScene():popPanel()
    parent:resumeGame()
    

end

function TetrisPowerPausePanel:handleQuit()
    local scene = self:getScene()
    self.disableTransition = true
    self:getScene():popPanel()
    scene:pushPanel("Tetris.view.TetrisPowerEndIntro", {self.powerId, self.armyId})
    

    
end

function TetrisPowerPausePanel:handleVol()
    if self.volState == 1 then
        self.volState = 0
        self.btnVol:loadTextureNormal("ui/tetris/power/vol_on.png",0)
        self.btnVol:loadTexturePressed("ui/tetris/power/vol_on.png",0)
        self.btnVol:loadTextureDisabled("ui/tetris/power/vol_on.png",0)
    else
        self.volState = 1
        self.btnVol:loadTextureNormal("ui/tetris/power/vol_off.png",0)
        self.btnVol:loadTexturePressed("ui/tetris/power/vol_off.png",0)
        self.btnVol:loadTextureDisabled("ui/tetris/power/vol_off.png",0)
    end
end



return TetrisPowerPausePanel

