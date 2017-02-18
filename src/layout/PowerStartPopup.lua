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

--Create panel
local panel = ccui.Layout:create()
panel:ignoreContentAdaptWithSize(false)
panel:setClippingEnabled(false)
panel:setBackGroundColorType(1)
panel:setBackGroundColor({r = 150, g = 200, b = 255})
panel:setBackGroundColorOpacity(0)
panel:setTouchEnabled(true);
panel:setLayoutComponentEnabled(true)
panel:setName("panel")
panel:setTag(115)
panel:setCascadeColorEnabled(true)
panel:setCascadeOpacityEnabled(true)
panel:setAnchorPoint(0.5000, 0.5000)
panel:setPosition(320.0000, 568.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(panel)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(1.0000)
layout:setPercentHeight(1.0000)
layout:setSize({width = 640.0000, height = 1136.0000})
Scene:addChild(panel)

--Create popup_bg_4
local popup_bg_4 = cc.Sprite:create("ui/tetris/power/power_start_bg.png")
popup_bg_4:setName("popup_bg_4")
popup_bg_4:setTag(51)
popup_bg_4:setCascadeColorEnabled(true)
popup_bg_4:setCascadeOpacityEnabled(true)
popup_bg_4:setPosition(320.0000, 644.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(popup_bg_4)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.5669)
layout:setPercentWidth(1.0000)
layout:setPercentHeight(0.6294)
layout:setSize({width = 640.0000, height = 715.0000})
layout:setTopMargin(134.5000)
layout:setBottomMargin(286.5000)
popup_bg_4:setBlendFunc({src = 1, dst = 771})
panel:addChild(popup_bg_4)

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

--Create btn_powerstart
local btn_powerstart = ccui.Button:create()
btn_powerstart:ignoreContentAdaptWithSize(false)
btn_powerstart:loadTextureNormal("ui/tetris/power/power_start.png",0)
btn_powerstart:loadTexturePressed("ui/tetris/power/power_start.png",0)
btn_powerstart:loadTextureDisabled("ui/tetris/power/power_start.png",0)
btn_powerstart:setTitleFontSize(14)
btn_powerstart:setTitleColor({r = 65, g = 65, b = 70})
btn_powerstart:setScale9Enabled(true)
btn_powerstart:setCapInsets({x = 15, y = 11, width = 262, height = 64})
btn_powerstart:setLayoutComponentEnabled(true)
btn_powerstart:setName("btn_powerstart")
btn_powerstart:setTag(20)
btn_powerstart:setCascadeColorEnabled(true)
btn_powerstart:setCascadeOpacityEnabled(true)
btn_powerstart:setPosition(320.0000, 134.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(btn_powerstart)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.1874)
layout:setPercentWidth(0.4563)
layout:setPercentHeight(0.1203)
layout:setSize({width = 292.0000, height = 86.0000})
layout:setLeftMargin(174.0000)
layout:setRightMargin(174.0000)
layout:setTopMargin(538.0000)
layout:setBottomMargin(91.0000)
popup_bg_4:addChild(btn_powerstart)

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
layout:setPercentWidth(0.3623)
layout:setPercentHeight(0.4933)
layout:setSize({width = 100.0000, height = 37.0000})
layout:setLeftMargin(86.1547)
layout:setRightMargin(89.8453)
layout:setTopMargin(18.5402)
layout:setBottomMargin(19.4598)
powername_bg_2:addChild(lb_powername)

--Create sp_target
local sp_target = cc.Sprite:create("Default/Sprite.png")
sp_target:setName("sp_target")
sp_target:setTag(56)
sp_target:setCascadeColorEnabled(true)
sp_target:setCascadeOpacityEnabled(true)
sp_target:setPosition(320.0000, 406.7413)
layout = ccui.LayoutComponent:bindLayoutComponent(sp_target)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.5689)
layout:setPercentWidth(0.0719)
layout:setPercentHeight(0.0643)
layout:setSize({width = 46.0000, height = 46.0000})
layout:setLeftMargin(297.0000)
layout:setRightMargin(297.0000)
layout:setTopMargin(285.2587)
layout:setBottomMargin(383.7413)
sp_target:setBlendFunc({src = 1, dst = 771})
popup_bg_4:addChild(sp_target)

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
lb_target_title:setPosition(320.0000, 472.5399)
layout = ccui.LayoutComponent:bindLayoutComponent(lb_target_title)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.6609)
layout:setPercentWidth(0.1141)
layout:setPercentHeight(0.0517)
layout:setSize({width = 73.0000, height = 37.0000})
layout:setLeftMargin(283.5000)
layout:setRightMargin(283.5000)
layout:setTopMargin(223.9601)
layout:setBottomMargin(454.0399)
popup_bg_4:addChild(lb_target_title)

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
lb_target:setPosition(320.0000, 338.3480)
layout = ccui.LayoutComponent:bindLayoutComponent(lb_target)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.4732)
layout:setPercentWidth(0.3000)
layout:setPercentHeight(0.0517)
layout:setSize({width = 192.0000, height = 37.0000})
layout:setLeftMargin(224.0000)
layout:setRightMargin(224.0000)
layout:setTopMargin(358.1520)
layout:setBottomMargin(319.8480)
popup_bg_4:addChild(lb_target)

--Create btn_close
local btn_close = ccui.Button:create()
btn_close:ignoreContentAdaptWithSize(false)
btn_close:loadTextureNormal("ui/tetris/power/close.png",0)
btn_close:loadTexturePressed("ui/tetris/power/close.png",0)
btn_close:loadTextureDisabled("ui/tetris/power/close.png",0)
btn_close:setTitleFontSize(14)
btn_close:setTitleColor({r = 65, g = 65, b = 70})
btn_close:setScale9Enabled(true)
btn_close:setCapInsets({x = 15, y = 11, width = 35, height = 43})
btn_close:setLayoutComponentEnabled(true)
btn_close:setName("btn_close")
btn_close:setTag(279)
btn_close:setCascadeColorEnabled(true)
btn_close:setCascadeOpacityEnabled(true)
btn_close:setPosition(558.2432, 667.4741)
layout = ccui.LayoutComponent:bindLayoutComponent(btn_close)
layout:setPositionPercentX(0.8723)
layout:setPositionPercentY(0.9335)
layout:setPercentWidth(0.1016)
layout:setPercentHeight(0.0909)
layout:setSize({width = 65.0000, height = 65.0000})
layout:setLeftMargin(525.7432)
layout:setRightMargin(49.2568)
layout:setTopMargin(15.0259)
layout:setBottomMargin(634.9741)
popup_bg_4:addChild(btn_close)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(1.0000)
--Create Animation List

result['root'] = Scene
return result;
end

return Result

