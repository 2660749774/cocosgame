
--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- networkTestPanel 测试场景
-- local BaseTestScene = require("game.TestLua.tests.BaseTestScene")
local networkTestPanel = class("networkTestPanel", BasePanel)


function networkTestPanel:onCreate()
    -- BaseTestScene.onCreate(self)
    
    local items = {
        "httpget",
        "httppost",
        "httphost",
        "tcp",
    }
    self.layout = require("layout.TestLuaLayout").create()
    self:createMenu(items, handler(self, self.openTest))
    self:addChild(self.layout["root"])
end

function networkTestPanel:createMenu( items, callback )
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

function networkTestPanel:openTest(name)
    log:info("test %s", name)
    self:getScene():pushPanel("TestLua.tests." .. name .. "Test")
end


return networkTestPanel
