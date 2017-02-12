--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TestMVVMScene 测试MVVM
local TestMVVMScene = class("TestMVVMScene", BaseScene)
local UserViewModel = import(".UserViewModel")

--------------------------------
-- 创建方法
-- @function [parent=#TestMVVMScene] onCreate
function TestMVVMScene:onCreate()
    local layout = require("layout.TestMVVMScene").create()
    self:fixLayout(layout)

    -- 添加事件监听
    self.inputHost = cc.EditBox:create(cc.size(350, 70), cc.Scale9Sprite:create(), cc.Scale9Sprite:create())
    self.inputHost:setAnchorPoint(0.5, 0.5)
    self.inputHost:setPosition(175, 35)
    self.inputHost:setFontColor(cc.c3b(0, 128, 0))
    self.inputHost:setText("${user.name}")
    self.inputHost:setInputMode(6)
    layout['bg_input']:addChild(self.inputHost)
    layout['inputHost'] = self.inputHost

    self.vm = UserViewModel.new()
    self.vm:bind(layout, {"user_name", "inputHost"})
    self.vm:loadData()
    
    self:addObject(layout['root'], "scene")
end


return TestMVVMScene

