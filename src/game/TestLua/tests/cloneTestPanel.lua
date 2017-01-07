
--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TestLuaScene 测试场景
-- local BaseTestScene = require("game.TestLua.tests.BaseTestScene")
local cloneTestPanel = class("cloneTestPanel", BasePanel)

function cloneTestPanel:onCreate()
    -- BaseTestScene.onCreate(self)
    
    self:cloneTest()
    
end

function cloneTestPanel:cloneTest()
    self:cloneButton()
    self:cloneCheckBox()
    self:cloneImage()
    --self:cloneSlider()
end

function cloneTestPanel:cloneButton()
    local node = ccui.Button:create()
    node:setTitleText("Clone me")
    node:setTitleFontSize(18)
    node:addClickEventListener(function(event) 
        local cloneNode = node:clone()
        cloneNode:setTitleText("Clone Node")
        cloneNode:setPosition(cc.p(display.cx + 100, display.top - 150))
        self:addChild(cloneNode)
    end)
    node:setPosition(cc.p(display.cx, display.top - 150))
    self:addChild(node)
end

function cloneTestPanel:cloneCheckBox()
    local ratioBtn1 = ccui.RadioButton:create("res/RadioButtonOff.png", "res/RadioButtonOn.png")
    local ratioBtn2 = ccui.RadioButton:create("res/RadioButtonOff.png", "res/RadioButtonOn.png")
    local ratioBtn3 = ccui.RadioButton:create("res/RadioButtonOff.png", "res/RadioButtonOn.png")
    local ratioBtnGroup = ccui.RadioButtonGroup:create()
    ratioBtnGroup:addRadioButton(ratioBtn1)
    ratioBtnGroup:addRadioButton(ratioBtn2)
    ratioBtnGroup:addRadioButton(ratioBtn3)
    ratioBtn1:setPosition(cc.p(display.cx, display.top - 200))
    ratioBtn2:setPosition(cc.p(display.cx + 50, display.top - 200))
    ratioBtn3:setPosition(cc.p(display.cx + 100, display.top - 200))
    ratioBtnGroup:setPosition(cc.p(display.cx, display.top - 200))
    ratioBtnGroup:setSelectedButton(0)

    self:addChild(ratioBtn1)
    self:addChild(ratioBtn2)
    self:addChild(ratioBtn3)
    self:addChild(ratioBtnGroup)
    -- local cloneNode = group:clone() -- cc.uiloader:clone(node)
    -- if cloneNode then
    --     cloneNode:align(display.LEFT_TOP, display.left + 50, display.top - 400)
    --     :addTo(self):setButtonsLayoutMargin(10, 10, 10, 10)
    -- else
    --     print("clone button fail")
    -- end
end

function cloneTestPanel:cloneImage()
    local image = ccui.ImageView:create("res/PinkScale9Block.png")
    image:setPosition(cc.p(display.cx, display.top - 300))
    self:addChild(image)

    local cloneNode = image:clone()
    if cloneNode then
        cloneNode:setPosition(cc.p(display.cx + 200, display.top - 300))
        self:addChild(cloneNode)
    else
        print("clone button fail")
    end
end

function cloneTestPanel:cloneSlider()
    local sliderImages = {
        bar = "SliderBar.png",
        button = "SliderButton.png",
    }
    local slider =   ccui.Slider:create();
    local slider = cc.ui.UISlider.new(display.LEFT_TO_RIGHT, sliderImages, {scale9 = true})
        :setSliderSize(200, 40)
        :setSliderValue(75)
        :align(display.CENTER, display.right - 100, display.top - 150)
        :addTo(self)

    local cloneNode = slider:clone()
    if cloneNode then
        cloneNode:pos(display.right - 100, display.top - 200):addTo(self)
    else
        print("clone slider fail")
    end
end

return cloneTestPanel
