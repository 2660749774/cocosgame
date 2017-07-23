--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisTipsPanel 通用Tips
local TetrisTipsPanel = class("TetrisTipsPanel", BasePanel)
local TetrisPowerConf = import("..data.TetrisPowerConf")

--------------------------------
-- 创建方法
-- @function [parent=#TetrisTipsPanel] onCreate
function TetrisTipsPanel:onCreate(type)
    log:info("TetrisTipsPanel type:%s", type)
    log:showTable(data)
    local layout = require("layout.TetrisTipComm").create()
    self.disableTransition = true
    self.icon = layout['icon']
    self.btnOk = layout['btn_ok']
    self.lbTitle = layout['lb_title']
    self.lbInfo = layout['lb_info']
    self.infoIcon = layout['icon_info']
    self.btnClose = layout['btn_close']
    self.layout = layout

    self:initPanel(type)

    self.btnClose:addClickEventListener(handler(self, self.handleOk))
    self.btnOk:addClickEventListener(handler(self, self.handleOk))

    self:addLayoutWithMask(layout, "layout.ModalMask")
end

--------------------------------
-- 初始化
-- @function [parent=#TetrisTipsPanel] initPanel
function TetrisTipsPanel:initPanel(type)
    if type == 1 then
        -- 网络没连接
        self.icon:setTexture("ui/tips/nonetwork_icon.png")
        self.infoIcon:setTexture("ui/tips/btn_cancel.png")
        self.lbInfo:setString("没有网络连接\n请检查网络情况")
        self.lbTitle:setString("无法连接！")
    elseif type == 2 then
        -- 商店购买失败
        self.icon:setTexture("ui/tips/diam_icon.png")
        self.infoIcon:setTexture("ui/tips/btn_cancel.png")
        self.lbInfo:setString("商店购买失败\n请再次尝试")
        self.lbTitle:setString("购买失败！")
    end
end

--------------------------------
-- 处理点击确认
-- @function [parent=#TetrisTipsPanel] handleOk
function TetrisTipsPanel:handleOk()
    local scene = self:getScene()
    scene:popPanel()
end

return TetrisTipsPanel

