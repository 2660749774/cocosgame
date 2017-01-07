
--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- containerTestPanel 测试场景
-- local BaseTestScene = require("game.TestLua.tests.BaseTestScene")
local containerTestPanel = class("containerTestPanel", BasePanel)


function containerTestPanel:onCreate()
    -- BaseTestScene.onCreate(self)
    
    local items = {
        "list",
        "scroll",
        "table",
        "page"
    }
    self.layout = require("layout.TestLuaLayout").create()
    self:createMenu(items, handler(self, self.openTest))
    self:addChild(self.layout["root"])
end

function containerTestPanel:createMenu( items, callback )
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

function containerTestPanel:openTest(name)
    log:info("test %s", name)
    self:getScene():pushPanel("TestLua.tests." .. name .. "Test")
end

return containerTestPanel
