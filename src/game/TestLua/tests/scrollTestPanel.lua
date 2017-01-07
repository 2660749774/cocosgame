
--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- uiTestScene 测试场景
-- local BaseTestScene = require("game.TestLua.tests.BaseTestScene")
local scrollTestPanel = class("scrollTestPanel", BasePanel)

function scrollTestPanel:onCreate()
    -- BaseTestScene.onCreate(self)
    
    -- 重新注册事件
    self:getScene().btn:addClickEventListener(function (event)
        self:getScene():popPanel()
    end)

    
    self.layout = require("layout.scrollTestPanel").create()
    local scrollView = self.layout['scroll_view']
    self.layout['scroll_text']:setVisible (false)
    local scroll_text = self.layout['scroll_text']:clone()

    local file = "config.lua"
    local path = cc.FileUtils:getInstance():fullPathForFilename(file)
    if (io.exists(path)) then
        local content = io.readfile(path)
        scroll_text:setString(content)
    else
        scroll_text:setString("读取不到对应文件：" .. file)
    end
    scroll_text:setVisible (true)

    -- 重新定义滚动区域大小
    local contentSize = scroll_text:getContentSize()
    scrollView:setSize({width = contentSize.width, height = contentSize.height - 200})
    scrollView:setInnerContainerSize({width = contentSize.width, height = contentSize.height + 100})

    -- 设置文本
    scroll_text:setPosition(cc.p(0, 120))
    scroll_text:setAnchorPoint(0, 0)

    scrollView:addChild(scroll_text)


    self:addChild(self.layout["root"])

end

function scrollTestPanel:onExit()
    -- 重新注册事件
    self:getScene().btn:addClickEventListener(function (event)
        app:changeScene("TestLua", {}, "random", 1)
    end)
end



return scrollTestPanel
