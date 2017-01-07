
--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- uiTestScene 测试场景
-- local BaseTestScene = require("game.TestLua.tests.BaseTestScene")
local sliderTestPanel = class("sliderTestPanel", BasePanel)

function sliderTestPanel:onCreate()
    -- BaseTestScene.onCreate(self)
    
    -- 重新注册事件
    self:getScene().btn:addClickEventListener(function (event)
        self:getScene():popPanel()
    end)

    
    self.layout = require("layout.SliderTestScene").create()
    local slider = self.layout['slider']
    local progressTxt = self.layout['progress_txt']
    progressTxt:setString("0")
    slider:setPercent(0)
    slider:addEventListener(function (target, event)
        log:info("slider event %s,%s", target, event)
        if event == 0 then
            -- 进度变化
            progressTxt:setString(tostring(slider:getPercent()))
        end
    end)
    self:addChild(self.layout["root"])

end

function sliderTestPanel:onExit()
    -- 重新注册事件
    self:getScene().btn:addClickEventListener(function (event)
        app:changeScene("TestLua", {}, "random", 1)
    end)
end



return sliderTestPanel
