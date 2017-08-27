--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- HotswapTipsPanel 动更提示框
local HotswapTipsPanel = class("HotswapTipsPanel", BasePanel)

--------------------------------
-- 创建方法
-- @function [parent=#HotswapTipsPanel] onCreate
function HotswapTipsPanel:onCreate(tips, callback)
    local layout = require("layout.TetrisTipUpdate").create()
    self.disableTransition = true
    self.btnOk = layout['btn_ok']
    self.lbInfo = layout['lb_info']
    self.layout = layout
    self.tips = tips
    self.callback = callback

    self:initPanel()

    self.btnOk:addClickEventListener(handler(self, self.handleOk))

    self:addLayoutWithMask(layout, "layout.ModalMask")
end

--------------------------------
-- 初始化
-- @function [parent=#HotswapTipsPanel] initPanel
function HotswapTipsPanel:initPanel()
    self.lbInfo:setString(self.tips)
end

--------------------------------
-- 处理点击确认
-- @function [parent=#HotswapTipsPanel] handleOk
function HotswapTipsPanel:handleOk()
    local scene = self:getScene()
    local callback = self.callback
    scene:popPanel()
    if callback then
        callback()
    end
end

return HotswapTipsPanel

