--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisTipsBuyTimePanel 通用Tips
local TetrisTipsBuyTimePanel = class("TetrisTipsBuyTimePanel", BasePanel)

--------------------------------
-- 创建方法
-- @function [parent=#TetrisTipsBuyTimePanel] onCreate
function TetrisTipsBuyTimePanel:onCreate(itemNum, cost, buyTimes, itemType, okCallback, cancelCallback)
    log:info("TetrisTipsBuyTimePanel itemNum:%s, cost:%s, buyTimes:%s", itemNum, cost, buyTimes)
   
    local layout = require("layout.TetrisTipBuyTime").create()
    self.disableTransition = true
    self.btnBuy = layout['btn_buy']
    self.lbPrice = layout['lb_price']
    self.lbInfo = layout['lb_info']
    self.btnClose = layout['btn_close']
    self.layout = layout
    self.okCallback = okCallback
    self.cancelCallback = cancelCallback
    self.cost = cost
    self.buyTimes = buyTimes

    self:initPanel(itemType, itemNum)

    self.btnBuy:addClickEventListener(handler(self, self.handleBuy))
    self.btnClose:addClickEventListener(handler(self, self.handleClose))

    self:addLayoutWithMask(layout, "layout.ModalMask")
end

--------------------------------
-- 初始化
-- @function [parent=#TetrisTipsBuyTimePanel] initPanel
function TetrisTipsBuyTimePanel:initPanel(itemType, itemNum)
    if itemType == 1 then
        self.lbInfo:setString(string.format("延长关卡时间：%s秒！", itemNum))
    else
        self.lbInfo:setString(string.format("延长关卡方块数：%s块！", itemNum))
    end
    self.lbPrice:setString(tostring(self.cost))
end

--------------------------------
-- 处理点击关闭
-- @function [parent=#TetrisTipsBuyTimePanel] handleClose
function TetrisTipsBuyTimePanel:handleClose()
    local callback = self.cancelCallback
    local scene = self:getScene()
    scene:popPanel()

    if callback then
        callback()
    end
end

--------------------------------
-- 处理点击关闭
-- @function [parent=#TetrisTipsBuyTimePanel] handleBuy
function TetrisTipsBuyTimePanel:handleBuy()
    local callback = self.okCallback
    cmgr:send(actions.buyItem, function()
        local scene = self:getScene()
        scene:popPanel()

        if callback then
            callback()
        end
    end, self.cost, self.buyTimes)
end


return TetrisTipsBuyTimePanel

