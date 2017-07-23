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
function TetrisTipsBuyTimePanel:onCreate(time, cost, okCallback, cancelCallback)
    log:info("TetrisTipsBuyTimePanel time:%s, cost:%s", time, cost)
   
    local layout = require("layout.TetrisTipBuyTime").create()
    self.disableTransition = true
    self.btnBuy = layout['btn_buy']
    self.lbPrice = layout['lb_price']
    self.lbInfo = layout['lb_info']
    self.btnClose = layout['btn_close']
    self.layout = layout
    self.okCallback = okCallback
    self.cancelCallback = cancelCallback

    self:initPanel(time, cost)

    self.btnBuy:addClickEventListener(handler(self, self.handleBuy))
    self.btnClose:addClickEventListener(handler(self, self.handleClose))

    self:addLayoutWithMask(layout, "layout.ModalMask")
end

--------------------------------
-- 初始化
-- @function [parent=#TetrisTipsBuyTimePanel] initPanel
function TetrisTipsBuyTimePanel:initPanel(time, cost)
    self.lbInfo:setString(string.format("延长光卡时间：%s秒！", time))
    self.lbPrice:setString(tostring(cost))
end

--------------------------------
-- 更新时间
-- @function [parent=#TetrisTipsBuyTimePanel] formatTime
function TetrisTipsBuyTimePanel:updateTime()
    self.lbTime:setString(self:formatTime())
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
    local scene = self:getScene()
    scene:popPanel()

    if callback then
        callback()
    end
end


return TetrisTipsBuyTimePanel

