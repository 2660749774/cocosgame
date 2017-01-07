
--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- uiTestScene 测试场景
-- local BaseTestScene = require("game.TestLua.tests.BaseTestScene")
local buttonTestPanel = class("buttonTestPanel", BasePanel)

function buttonTestPanel:onCreate()
    -- BaseTestScene.onCreate(self)
    
    -- 重新注册事件
    self:getScene().btn:addClickEventListener(function (event)
        self:getScene():popPanel()
    end)

    
    -- toggle button
    self.layout = require("layout.ButtonTestScene").create()

    self.greenBtn = self.layout['green_btn']

    local toggleNode = self.layout['toggle_btn']
    cc.MenuItemFont:setFontSize(24)
    local menuOn = cc.MenuItemFont:create("ON")
    local menuOff = cc.MenuItemFont:create("OFF")
    local toggleMenu = cc.MenuItemToggle:create(menuOn)
    toggleMenu:addSubItem(menuOff)
    toggleMenu:setSelectedIndex(0)
    local menu = cc.Menu:createWithItem(toggleMenu)
    menu:setPosition(cc.p(0, 0))
    toggleNode:addChild(menu)
    toggleMenu:registerScriptTapHandler(function( target )
        log:info("value:%s", toggleMenu:getSelectedIndex())
    end)


    -- slider button
    local markSpite = cc.Sprite:create("ui/button/mask.png")
    local onSprite = cc.Sprite:create("ui/button/on_bg.png")
    local offSprite = cc.Sprite:create("ui/button/off_bg.png")
    local toggleSprite = cc.Sprite:create("ui/button/toggle.png")
    -- toggleSprite:setAnchorPoint(1, 0.5)
    local onLabel = cc.Label:createWithSystemFont("ON","Arial",18)
    local offLabel = cc.Label:createWithSystemFont("OFF","Arial",18)
    switch_btn = cc.ControlSwitch:create(markSpite, offSprite, onSprite, toggleSprite, offLabel, onLabel)
    local switchNode = self.layout['switch_btn']
    switchNode:addChild(switch_btn)

    -- editbox
    local editbox = cc.EditBox:create(cc.size(480, 60), cc.Scale9Sprite:create(), cc.Scale9Sprite:create())
    editbox:setPosition(cc.p(500,40))
    editbox:setPlaceHolder("please input text")
    self.layout["root"]:addChild(editbox)

    self:addChild(self.layout["root"])
end

function buttonTestPanel:onExit()
    -- 重新注册事件
    self:getScene().btn:addClickEventListener(function (event)
        app:changeScene("TestLua", {}, "random", 1)
    end)
end



return buttonTestPanel
