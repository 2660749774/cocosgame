--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisTipsBuyEnergyPanel 通用Tips
local TetrisTipsBuyEnergyPanel = class("TetrisTipsBuyEnergyPanel", BasePanel)

--------------------------------
-- 创建方法
-- @function [parent=#TetrisTipsBuyEnergyPanel] onCreate
function TetrisTipsBuyEnergyPanel:onCreate(cost)
    log:info("TetrisTipsBuyEnergyPanel cost:%s", cost)
   
    local layout = require("layout.TetrisTipBuyEnergy").create()
    self.disableTransition = true
    self.icon = layout['icon']
    self.btnBuy = layout['btn_buy']
    self.btnWatch = layout['btn_watch']
    self.lbPrice = layout['lb_price']
    self.lbInfo = layout['lb_info']
    self.lbTime = layout['lb_time']
    self.lbTitle = layout['lb_title']
    self.btnClose = layout['btn_close']
    self.layout = layout

    self:initPanel(cost)

    self.btnClose:addClickEventListener(handler(self, self.handleOk))
    self.btnBuy:addClickEventListener(handler(self, self.handleBuyLife))

    self:addLayoutWithMask(layout, "layout.ModalMask")
end

--------------------------------
-- 初始化
-- @function [parent=#TetrisTipsBuyEnergyPanel] initPanel
function TetrisTipsBuyEnergyPanel:initPanel(cost)
    self.lifes = utils.gameArchive.lifes
    self.nextLifeTime = utils.gameArchive.nextLifeTime

    self.lbTitle:setString(tostring(self.lifes))
    self.lbPrice:setString(tostring(cost))
    self.lbTime:setString(self:formatTime(false))

    self.updateHandler = scheduler.scheduleGlobal(handler(self, self.updateTime), 1)
end

--------------------------------
-- 更新时间
-- @function [parent=#TetrisTipsBuyEnergyPanel] formatTime
function TetrisTipsBuyEnergyPanel:updateTime()
    self.lbTime:setString(self:formatTime(true))
end

--------------------------------
-- 格式化时间
-- @function [parent=#TetrisTipsBuyEnergyPanel] formatTime
function TetrisTipsBuyEnergyPanel:formatTime(callByUpdate)
    local cd = self.nextLifeTime - os.time()
    local minutes = string.format("%02d", math.ceil(cd / 60))
    local secs = string.format("%02d", cd % 60)

    if cd <= 0 then
        if callByUpdate then
            self:initPanel()
        end
        return "0 : 0"
    end

    return string.format("%s : %s", minutes, secs)
end

--------------------------------
-- 处理点击确认
-- @function [parent=#TetrisTipsBuyEnergyPanel] handleOk
function TetrisTipsBuyEnergyPanel:handleOk()
    local scene = self:getScene()
    scene:popPanel()
end

--------------------------------
-- 处理购买体力
-- @function [parent=#TetrisTipsBuyEnergyPanel] handleOk
function TetrisTipsBuyEnergyPanel:handleBuyLife()
    local lifes = utils.gameArchive.lifes
    local nextLifeTime = utils.gameArchive.nextLifeTime
    cmgr:send(actions.buyLife, function(response)
        -- 增加体力
        utils.gameArchive:addLife(1, true)
        utils.gameArchive:saveData()
        utils.gameArchive:syncLifeData()

        -- 更新界面信息
        self.lifes = utils.gameArchive.lifes
        self.lbPrice:setString(tostring(response.data.cost))
        self.lbTitle:setString(tostring(self.lifes))
    end, lifes, nextLifeTime)
end

--------------------------------
-- 退出界面
-- @function [parent=#TetrisTipsBuyEnergyPanel] onExit
function TetrisTipsBuyEnergyPanel:onExit()
    scheduler.unscheduleGlobal(self.updateHandler)
end

return TetrisTipsBuyEnergyPanel

