--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisPowerSuccPanel 俄罗斯方块
-- 副本开始弹框
local TetrisPowerSuccPanel = class("TetrisPowerSuccPanel", BasePanel)
local TetrisPowerConf = import("..data.TetrisPowerConf")

--------------------------------
-- 创建方法
-- @function [parent=#TetrisPowerSuccPanel] onCreate
function TetrisPowerSuccPanel:onCreate(powerId, armyId, star, score)
    local layout = require("layout.PowerSuccPopup").create()

    log:info("showSuccPanel powerI:%s, armyId:%s, star:%s, score:%s", powerId, armyId, star, score)

    self.powerId = powerId
    self.armyId = armyId

    self.btnPowerContinue = layout['btn_powercontinue']
    self.btnClose = layout['btn_close']
    self.lbReward = layout['lb_reward']

    -- 存储进度
    local queryKey = "power." .. powerId .. "." .. armyId
    local _star = utils.gameArchive:queryData(queryKey)
    if _star == nil or _star < star then
        utils.gameArchive:putData(queryKey, star)
    end

    local progressKey = "power.progress"
    local progress = utils.gameArchive:queryData(progressKey)
    if progress == nil or progress.powerId < powerId or (progress.powerId == powerId and progress.armyId <= armyId) then
        local _armyId = armyId + 1
        local _powerId = powerId
        local maxArmyId = TetrisPowerConf.getPowerMaxArmyId(powerId)
        if _armyId > maxArmyId then
            _powerId = math.min(TetrisPowerConf.MAX_POWER_ID, powerId + 1)
            if _powerId > powerId then
                _armyId = 1
            else
                _armyId = armyId
            end
        end
        progress = {powerId = _powerId, armyId = _armyId}
        utils.gameArchive:putData(progressKey, progress)
        emgr:dispatchEvent(EventDefine.POWER_PROGRESS_UPDATE, progress)
    end
    utils.gameArchive:printData()
    utils.gameArchive:saveData(true)


    -- local powerData = utils.gameArchive:getData()['power']
    -- if nil == powerData then
    --     utils.gameArchive:getData()['power'] = {}
    --     powerData = utils.gameArchive:getData()['power']
    -- end
    -- if powerData[powerId .. "-" .. armyId] == nil or powerData[powerId .. "-" .. armyId]['star'] < star then
    --     powerData[powerId .. "-" .. armyId]['star'] == star
    -- end


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


return TetrisPowerSuccPanel

