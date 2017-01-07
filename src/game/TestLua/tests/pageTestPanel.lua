
--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- uiTestScene 测试场景
-- local BaseTestScene = require("game.TestLua.tests.BaseTestScene")
local pageTestPanel = class("pageTestPanel", BasePanel)

function pageTestPanel:onCreate()
    -- BaseTestScene.onCreate(self)
    -- 重新注册事件
    self:getScene().btn:addClickEventListener(function (event)
        self:getScene():popPanel()
    end)

    
    self.layout = require("layout.PageTestScene").create()
    local pageView = self.layout['page_view']
    pageView:scrollToPage(0)
    pageView:addEventListener(function(target, event)
        log:info("pageview %s %s %s", target, event, pageView:getCurrentPageIndex())
         self.ratioBtnGroup:setSelectedButton(pageView:getCurrentPageIndex())
    end)

    self:initCheckBox(#pageView:getItems(), 0)
    self:addChild(self.layout["root"])
end

function pageTestPanel:initCheckBox(pageNum, initPage)
    self.ratioBtnGroup = ccui.RadioButtonGroup:create()
    for i=1, pageNum do
        local ratioBtn = ccui.RadioButton:create("res/RadioButtonOff.png", "res/RadioButtonOn.png")
        ratioBtn:setPosition(cc.p(display.cx + (i - 1) * 50, display.bottom + 100))
        self.ratioBtnGroup:addRadioButton(ratioBtn)
        self:addChild(ratioBtn)
    end
    self:addChild(self.ratioBtnGroup)
    self.ratioBtnGroup:setSelectedButton(initPage)
end

function pageTestPanel:onExit()
    -- 重新注册事件
    self:getScene().btn:addClickEventListener(function (event)
        app:changeScene("TestLua", {}, "random", 1)
    end)
end



return pageTestPanel
