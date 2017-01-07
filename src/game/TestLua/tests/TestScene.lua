
--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TestLuaScene 测试场景
local TestScene = class("TestScene", BaseScene)

function TestScene:onCreate(panelName)
    self.menuLayer = cc.Layer:create()

    -- self:addChild(self.menuLayer, 3000)
    self:addObject(self.menuLayer, "scene")

    self.btn = ccui.Button:create()
    self.btn:setTitleText("RETURN")
    self.btn:setTitleColor(cc.c3b(0, 128, 0))
    self.btn:setTitleFontSize(32)
    self.btn:addClickEventListener(function (event)
        app:changeScene("TestLua", {}, "random", 1)
    end)
    self.btn:setPosition(cc.p(display.right - 80, display.bottom + 30))
    self.menuLayer:addChild(self.btn)

    local text = "=====   " .. self.__cname .. "  ====="
    local label = cc.Label:createWithSystemFont(text,"Arial",24)
    label:setTextColor(cc.c3b(0, 255, 0))
    label:setPosition(cc.p(display.cx, display.top - 60))
    self.menuLayer:addChild(label)

    log:info("open panel %s", panelName)
    if panelName then
        self:openPanel(panelName)
    end
end

return TestScene