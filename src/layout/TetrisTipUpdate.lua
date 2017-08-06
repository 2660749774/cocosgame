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

--Create bg
local bg = cc.Sprite:create("ui/tips/tips_bg.png")
bg:setName("bg")
bg:setTag(77)
bg:setCascadeColorEnabled(true)
bg:setCascadeOpacityEnabled(true)
bg:setPosition(320.0000, 568.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(bg)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(0.9766)
layout:setPercentHeight(0.4137)
layout:setSize({width = 625.0000, height = 470.0000})
layout:setLeftMargin(7.5000)
layout:setRightMargin(7.5000)
layout:setTopMargin(333.0000)
layout:setBottomMargin(333.0000)
bg:setBlendFunc({src = 1, dst = 771})
panel:addChild(bg)

--Create inner_bg
local inner_bg = cc.Sprite:create("ui/tips/tips_inner_bg.png")
inner_bg:setName("inner_bg")
inner_bg:setTag(78)
inner_bg:setCascadeColorEnabled(true)
inner_bg:setCascadeOpacityEnabled(true)
inner_bg:setPosition(320.0000, 622.0110)
layout = ccui.LayoutComponent:bindLayoutComponent(inner_bg)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.5475)
layout:setPercentWidth(0.7031)
layout:setPercentHeight(0.1320)
layout:setSize({width = 450.0000, height = 150.0000})
layout:setLeftMargin(95.0000)
layout:setRightMargin(95.0000)
layout:setTopMargin(438.9890)
layout:setBottomMargin(547.0110)
inner_bg:setBlendFunc({src = 1, dst = 771})
panel:addChild(inner_bg)

--Create lb_title
local lb_title = ccui.Text:create()
lb_title:ignoreContentAdaptWithSize(true)
lb_title:setTextAreaSize({width = 0, height = 0})
lb_title:setFontSize(28)
lb_title:setString([[游戏更新]])
lb_title:enableShadow({r = 0, g = 0, b = 0, a = 255}, {width = 1, height = -1}, 0)
lb_title:setLayoutComponentEnabled(true)
lb_title:setName("lb_title")
lb_title:setTag(81)
lb_title:setCascadeColorEnabled(true)
lb_title:setCascadeOpacityEnabled(true)
lb_title:setPosition(320.0000, 761.7169)
layout = ccui.LayoutComponent:bindLayoutComponent(lb_title)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.6705)
layout:setPercentWidth(0.1750)
layout:setPercentHeight(0.0246)
layout:setSize({width = 112.0000, height = 28.0000})
layout:setLeftMargin(264.0000)
layout:setRightMargin(264.0000)
layout:setTopMargin(360.2831)
layout:setBottomMargin(747.7169)
panel:addChild(lb_title)

--Create lb_info
local lb_info = ccui.Text:create()
lb_info:ignoreContentAdaptWithSize(true)
lb_info:setTextAreaSize({width = 0, height = 0})
lb_info:setFontSize(24)
lb_info:setString([[检查到有新的版本，点击更新。
本次更新大小：1M]])
lb_info:setLayoutComponentEnabled(true)
lb_info:setName("lb_info")
lb_info:setTag(83)
lb_info:setCascadeColorEnabled(true)
lb_info:setCascadeOpacityEnabled(true)
lb_info:setPosition(320.0000, 621.8820)
lb_info:setTextColor({r = 25, g = 76, b = 94})
layout = ccui.LayoutComponent:bindLayoutComponent(lb_info)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.5474)
layout:setPercentWidth(0.5250)
layout:setPercentHeight(0.0423)
layout:setSize({width = 336.0000, height = 48.0000})
layout:setLeftMargin(152.0000)
layout:setRightMargin(152.0000)
layout:setTopMargin(490.1180)
layout:setBottomMargin(597.8820)
panel:addChild(lb_info)

--Create btn_ok
local btn_ok = ccui.Button:create()
btn_ok:ignoreContentAdaptWithSize(false)
cc.SpriteFrameCache:getInstance():addSpriteFrames("ui/plist/common.plist")
btn_ok:loadTextureNormal("btn_ok.png",1)
cc.SpriteFrameCache:getInstance():addSpriteFrames("ui/plist/common.plist")
btn_ok:loadTexturePressed("btn_ok.png",1)
cc.SpriteFrameCache:getInstance():addSpriteFrames("ui/plist/common.plist")
btn_ok:loadTextureDisabled("btn_ok.png",1)
btn_ok:setTitleFontSize(14)
btn_ok:setTitleColor({r = 65, g = 65, b = 70})
btn_ok:setScale9Enabled(true)
btn_ok:setCapInsets({x = 15, y = 11, width = 262, height = 64})
btn_ok:setLayoutComponentEnabled(true)
btn_ok:setName("btn_ok")
btn_ok:setTag(79)
btn_ok:setCascadeColorEnabled(true)
btn_ok:setCascadeOpacityEnabled(true)
btn_ok:setPosition(320.0002, 466.0006)
layout = ccui.LayoutComponent:bindLayoutComponent(btn_ok)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.4102)
layout:setPercentWidth(0.4563)
layout:setPercentHeight(0.0757)
layout:setSize({width = 292.0000, height = 86.0000})
layout:setLeftMargin(174.0002)
layout:setRightMargin(173.9998)
layout:setTopMargin(626.9994)
layout:setBottomMargin(423.0006)
panel:addChild(btn_ok)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(1.0000)
--Create Animation List

result['root'] = Scene
return result;
end

return Result
