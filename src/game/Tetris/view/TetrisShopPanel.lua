--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisShopPanel  俄罗斯方块
-- 排行榜模块
local TetrisShopPanel = class("TetrisShopPanel", BasePanel)
local TetrisPowerConf = import("..data.TetrisPowerConf")


TetrisShopPanel.POS_ARRAY = {}
TetrisShopPanel.POS_ARRAY[1] = cc.p(320, 695)
TetrisShopPanel.POS_ARRAY[2] = cc.p(320, 585)
TetrisShopPanel.POS_ARRAY[3] = cc.p(320, 475)
TetrisShopPanel.POS_ARRAY[4] = cc.p(320, 365)
TetrisShopPanel.POS_ARRAY[5] = cc.p(320, 255)

--------------------------------
-- 创建方法
-- @function [parent=#TetrisShopPanel] onCreate
function TetrisShopPanel:onCreate(data)
    local layout = require("layout.TetrisShop").create()

    self.data = data
    self.btnClose = layout['btn_close']

    self:initPanel(layout)

    self.btnClose:addClickEventListener(handler(self, self.handleOk))

    self:addLayoutWithMask(layout, "layout.ModalMask")
end

--------------------------------
-- 初始化面板
-- @function [parent=#TetrisShopPanel] initPanel
function TetrisShopPanel:initPanel(layout)
    for index, data in pairs(self.data.goods) do
        local itemLayout = require("layout.TetrisShopItem").create()
        local panel = itemLayout['panel']
        local btnBuy = itemLayout['btn_buy']
        local lbDiam = itemLayout['lb_diam']
        local spDiam = itemLayout['sp_diam']
        local lbPrice = itemLayout['lb_price']
        panel:retain()
        panel:removeFromParent()

        -- 初始化数据
        btnBuy.data = data
        lbDiam:setString(data.diam)
        lbPrice:setString("￥" .. data.money)
        spDiam:setTexture(string.format("ui/shop/icon_diam%s.png", index))
        panel:setPosition(TetrisShopPanel.POS_ARRAY[index])
        btnBuy:addClickEventListener(handler(self, self.buyDiam))

        layout['panel']:addChild(panel)
        log:info("init shop btn:%s", btnBuy)
    end
end

--------------------------------
-- 购买钻石
-- @function [parent=#TetrisShopPanel] buyDiam
function TetrisShopPanel:buyDiam(event)
    local data = event.target.data
    cmgr:send(actions.createOrder, function(response) 
        log:info("orderId:%s", response.data.orderId)
    end, data.itemId)
end

--------------------------------
-- 处理点击确认
-- @function [parent=#TetrisShopPanel] handleOk
function TetrisShopPanel:handleOk()
    local scene = self:getScene()
    scene:popPanel()
end

return TetrisShopPanel

