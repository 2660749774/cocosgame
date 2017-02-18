--------------------------------------------------------------
-- This file was automatically generated by Cocos Studio.
-- Do not make changes to this file.
-- All changes will be lost.
--------------------------------------------------------------

local luaExtend = require "LuaExtend"

-- using for layout to decrease count of local variables
local layout = nil
local localLuaFile = nil
local innerCSD = nil
local innerProject = nil
local localFrame = nil

local Result = {}
------------------------------------------------------------
-- function call description
-- create function caller should provide a function to 
-- get a callback function in creating scene process.
-- the returned callback function will be registered to 
-- the callback event of the control.
-- the function provider is as below :
-- Callback callBackProvider(luaFileName, node, callbackName)
-- parameter description:
-- luaFileName  : a string, lua file name
-- node         : a Node, event source
-- callbackName : a string, callback function name
-- the return value is a callback function
------------------------------------------------------------
function Result.create(callBackProvider)

local result={}
setmetatable(result, luaExtend)

--Create Scene
local Scene=cc.Node:create()
Scene:setName("Scene")

--Create popup_bg_4
local popup_bg_4 = cc.Sprite:create("ui/tetris/power/popup_bg.png")
popup_bg_4:setName("popup_bg_4")
popup_bg_4:setTag(51)
popup_bg_4:setCascadeColorEnabled(true)
popup_bg_4:setCascadeOpacityEnabled(true)
popup_bg_4:setPosition(320.0000, 568.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(popup_bg_4)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(1.0000)
layout:setPercentHeight(0.6294)
layout:setSize({width = 640.0000, height = 715.0000})
layout:setTopMargin(210.5000)
layout:setBottomMargin(210.5000)
popup_bg_4:setBlendFunc({src = 1, dst = 771})
Scene:addChild(popup_bg_4)

--Create power_start_3
local power_start_3 = cc.Sprite:create("ui/tetris/power/power_start.png")
power_start_3:setName("power_start_3")
power_start_3:setTag(50)
power_start_3:setCascadeColorEnabled(true)
power_start_3:setCascadeOpacityEnabled(true)
power_start_3:setPosition(320.0000, 134.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(power_start_3)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.1874)
layout:setPercentWidth(0.4563)
layout:setPercentHeight(0.1203)
layout:setSize({width = 292.0000, height = 86.0000})
layout:setLeftMargin(174.0000)
layout:setRightMargin(174.0000)
layout:setTopMargin(538.0000)
layout:setBottomMargin(91.0000)
power_start_3:setBlendFunc({src = 1, dst = 771})
popup_bg_4:addChild(power_start_3)

--Create powername_bg_2
local powername_bg_2 = cc.Sprite:create("ui/tetris/power/powername_bg.png")
powername_bg_2:setName("powername_bg_2")
powername_bg_2:setTag(49)
powername_bg_2:setCascadeColorEnabled(true)
powername_bg_2:setCascadeOpacityEnabled(true)
powername_bg_2:setPosition(320.0000, 660.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(powername_bg_2)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.9231)
layout:setPercentWidth(0.4313)
layout:setPercentHeight(0.1049)
layout:setSize({width = 276.0000, height = 75.0000})
layout:setLeftMargin(182.0000)
layout:setRightMargin(182.0000)
layout:setTopMargin(17.5000)
layout:setBottomMargin(622.5000)
powername_bg_2:setBlendFunc({src = 1, dst = 771})
popup_bg_4:addChild(powername_bg_2)

--Create lb_powername
local lb_powername = ccui.Text:create()
lb_powername:ignoreContentAdaptWithSize(true)
lb_powername:setTextAreaSize({width = 0, height = 0})
lb_powername:setFontSize(32)
lb_powername:setString([[第 5 关]])
lb_powername:enableShadow({r = 0, g = 0, b = 0, a = 255}, {width = 1, height = -1}, 0)
lb_powername:setLayoutComponentEnabled(true)
lb_powername:setName("lb_powername")
lb_powername:setTag(52)
lb_powername:setCascadeColorEnabled(true)
lb_powername:setCascadeOpacityEnabled(true)
lb_powername:setPosition(136.1547, 37.9598)
layout = ccui.LayoutComponent:bindLayoutComponent(lb_powername)
layout:setPositionPercentX(0.4933)
layout:setPositionPercentY(0.5061)
layout:setPercentWidth(0.4058)
layout:setPercentHeight(0.4400)
layout:setSize({width = 112.0000, height = 33.0000})
layout:setLeftMargin(80.1547)
layout:setRightMargin(83.8453)
layout:setTopMargin(20.5402)
layout:setBottomMargin(21.4598)
powername_bg_2:addChild(lb_powername)

--Create power_target_1
local power_target_1 = cc.Sprite:create("ui/tetris/power/power_target.png")
power_target_1:setName("power_target_1")
power_target_1:setTag(48)
power_target_1:setCascadeColorEnabled(true)
power_target_1:setCascadeOpacityEnabled(true)
power_target_1:setPosition(320.0000, 460.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(power_target_1)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.6434)
layout:setPercentWidth(0.5188)
layout:setPercentHeight(0.4098)
layout:setSize({width = 332.0000, height = 293.0000})
layout:setLeftMargin(154.0000)
layout:setRightMargin(154.0000)
layout:setTopMargin(108.5000)
layout:setBottomMargin(313.5000)
power_target_1:setBlendFunc({src = 1, dst = 771})
popup_bg_4:addChild(power_target_1)

--Create sp_target
local sp_target = cc.Sprite:create("Default/Sprite.png")
sp_target:setName("sp_target")
sp_target:setTag(56)
sp_target:setCascadeColorEnabled(true)
sp_target:setCascadeOpacityEnabled(true)
sp_target:setPosition(165.7581, 102.8859)
layout = ccui.LayoutComponent:bindLayoutComponent(sp_target)
layout:setPositionPercentX(0.4993)
layout:setPositionPercentY(0.3511)
layout:setPercentWidth(0.1386)
layout:setPercentHeight(0.1570)
layout:setSize({width = 46.0000, height = 46.0000})
layout:setLeftMargin(142.7581)
layout:setRightMargin(143.2419)
layout:setTopMargin(167.1141)
layout:setBottomMargin(79.8859)
sp_target:setBlendFunc({src = 1, dst = 771})
power_target_1:addChild(sp_target)

--Create lb_target_title
local lb_target_title = ccui.Text:create()
lb_target_title:ignoreContentAdaptWithSize(true)
lb_target_title:setTextAreaSize({width = 0, height = 0})
lb_target_title:setFontSize(32)
lb_target_title:setString([[目 标]])
lb_target_title:enableShadow({r = 55, g = 168, b = 245, a = 255}, {width = 1, height = -1}, 0)
lb_target_title:setLayoutComponentEnabled(true)
lb_target_title:setName("lb_target_title")
lb_target_title:setTag(53)
lb_target_title:setCascadeColorEnabled(true)
lb_target_title:setCascadeOpacityEnabled(true)
lb_target_title:setPosition(165.8459, 168.6847)
lb_target_title:setTextColor({r = 55, g = 168, b = 245})
layout = ccui.LayoutComponent:bindLayoutComponent(lb_target_title)
layout:setPositionPercentX(0.4995)
layout:setPositionPercentY(0.5757)
layout:setPercentWidth(0.2410)
layout:setPercentHeight(0.1126)
layout:setSize({width = 80.0000, height = 33.0000})
layout:setLeftMargin(125.8459)
layout:setRightMargin(126.1541)
layout:setTopMargin(107.8153)
layout:setBottomMargin(152.1847)
power_target_1:addChild(lb_target_title)

--Create lb_target
local lb_target = ccui.Text:create()
lb_target:ignoreContentAdaptWithSize(true)
lb_target:setTextAreaSize({width = 0, height = 0})
lb_target:setFontSize(32)
lb_target:setString([[清理岩石方块]])
lb_target:enableShadow({r = 55, g = 168, b = 245, a = 255}, {width = 1, height = -1}, 0)
lb_target:setLayoutComponentEnabled(true)
lb_target:setName("lb_target")
lb_target:setTag(54)
lb_target:setCascadeColorEnabled(true)
lb_target:setCascadeOpacityEnabled(true)
lb_target:setPosition(166.1170, 34.4929)
lb_target:setTextColor({r = 55, g = 168, b = 245})
layout = ccui.LayoutComponent:bindLayoutComponent(lb_target)
layout:setPositionPercentX(0.5004)
layout:setPositionPercentY(0.1177)
layout:setPercentWidth(0.5783)
layout:setPercentHeight(0.1126)
layout:setSize({width = 192.0000, height = 33.0000})
layout:setLeftMargin(70.1170)
layout:setRightMargin(69.8830)
layout:setTopMargin(242.0071)
layout:setBottomMargin(17.9929)
power_target_1:addChild(lb_target)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(1.0000)
--Create Animation List

result['root'] = Scene
return result;
end

return Result

