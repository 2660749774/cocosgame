
--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- uiTestScene 测试场景
-- local BaseTestScene = require("game.TestLua.tests.BaseTestScene")
local listTestPanel = class("listTestPanel", BasePanel)

function listTestPanel:onCreate()
    -- BaseTestScene.onCreate(self)
    
    -- 重新注册事件
    self:getScene().btn:addClickEventListener(function (event)
        self:getScene():popPanel()
    end)

    
    self.layout = require("layout.listTestPanel").create()
    local listView = self.layout['list_view']
    self:initList(listView, 200)


    self:addChild(self.layout["root"])

end

function listTestPanel:initList(listView, num)
    scheduler.scheduleGlobalByCoroutine(function()
        for i=1, num do
            local content = ccui.Button:create()
            content:setTitleText("List" .. i)
            content:setTitleColor(cc.c3b(0, 128, 0))
            content:setTitleFontSize(32)
            listView:pushBackCustomItem(content)
            coroutine.yield()
        end
    end, 1 / 30)
    
end

function listTestPanel:onExit()
    -- 重新注册事件
    self:getScene().btn:addClickEventListener(function (event)
        app:changeScene("TestLua", {}, "random", 1)
    end)
end



return listTestPanel
