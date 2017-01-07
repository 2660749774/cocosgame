
--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- uiTestPanel 测试场景
-- local BaseTestScene = require("game.TestLua.tests.BaseTestScene")
local uiTestPanel = class("uiTestPanel", BasePanel)

-- 需要加载
uiTestPanel.NeedLoading = true
uiTestPanel.LoadingRes = {
    plist = {
        {"pack.plist"}, 
        {"pack.plist"}
    },
    image = {
        {"ui/button/mask.png"},
        {"ui/button/on_bg.png"},
        {"ui/button/off_bg.png"},
        {"ui/button/toggle.png"},
        {"ui/button/green_btn.png"},
        {"ui/button/choose_bg.png"},
        {"ui/button/choose.png"},
        {"ui/slider/slider_bg.png"},
        {"ui/slider/slider_2.png"},
        {"ui/slider/slider_1.png"},
        {"ui/slider/slider.png"},
    }
}

function uiTestPanel:onCreate()
    -- BaseTestScene.onCreate(self)
    
    local items = {
        "slider",
        "button",
    }
    self.layout = require("layout.TestLuaLayout").create()
    self:createMenu(items, handler(self, self.openTest))
    self:addChild(self.layout["root"])
end

function uiTestPanel:createMenu( items, callback )
    local menuList = self.layout['menu_list']
    local menuBtn = self.layout['menu_btn']
    for i, v in ipairs(items) do
        local content = ccui.Button:create()
        content:setTitleText(v)
        content:setTitleColor(cc.c3b(0, 128, 0))
        content:setTitleFontSize(32)
        content:addClickEventListener(
            function(event)
                callback(v)
            end
        )
        menuList:pushBackCustomItem(content)
    end
end

function uiTestPanel:openTest(name)
    log:info("test %s", name)
    self:getScene():pushPanel("TestLua.tests." .. name .. "Test")
end

function uiTestPanel:onCleanup()
    self:cleanResources({
        {type="plist", key="pack.plist"}
    })
end

return uiTestPanel
