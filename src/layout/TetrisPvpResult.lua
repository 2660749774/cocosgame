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
panel:setBackGroundColorOpacity(102)
panel:setTouchEnabled(true);
panel:setLayoutComponentEnabled(true)
panel:setName("panel")
panel:setTag(85)
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
local bg = cc.Sprite:create("ui/pvp/red_win_bg.png")
bg:setName("bg")
bg:setTag(170)
bg:setCascadeColorEnabled(true)
bg:setCascadeOpacityEnabled(true)
bg:setPosition(320.0000, 568.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(bg)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(1.3313)
layout:setPercentHeight(1.0000)
layout:setSize({width = 852.0000, height = 1136.0000})
layout:setLeftMargin(-106.0000)
layout:setRightMargin(-106.0000)
bg:setBlendFunc({src = 1, dst = 771})
panel:addChild(bg)

--Create Sprite_2
local Sprite_2 = cc.Sprite:create("ui/pvp/pvp_result.png")
Sprite_2:setName("Sprite_2")
Sprite_2:setTag(54)
Sprite_2:setCascadeColorEnabled(true)
Sprite_2:setCascadeOpacityEnabled(true)
Sprite_2:setPosition(149.9997, 615.9977)
Sprite_2:setScaleX(-1.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(Sprite_2)
layout:setPositionPercentX(0.2344)
layout:setPositionPercentY(0.5423)
layout:setPercentWidth(0.4219)
layout:setPercentHeight(0.1320)
layout:setSize({width = 270.0000, height = 150.0000})
layout:setLeftMargin(14.9997)
layout:setRightMargin(355.0003)
layout:setTopMargin(445.0023)
layout:setBottomMargin(540.9977)
Sprite_2:setBlendFunc({src = 1, dst = 771})
panel:addChild(Sprite_2)

--Create Sprite_2_0
local Sprite_2_0 = cc.Sprite:create("ui/pvp/pvp_result.png")
Sprite_2_0:setName("Sprite_2_0")
Sprite_2_0:setTag(55)
Sprite_2_0:setCascadeColorEnabled(true)
Sprite_2_0:setCascadeOpacityEnabled(true)
Sprite_2_0:setPosition(487.4604, 616.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(Sprite_2_0)
layout:setPositionPercentX(0.7617)
layout:setPositionPercentY(0.5423)
layout:setPercentWidth(0.4219)
layout:setPercentHeight(0.1320)
layout:setSize({width = 270.0000, height = 150.0000})
layout:setLeftMargin(352.4604)
layout:setRightMargin(17.5396)
layout:setTopMargin(445.0000)
layout:setBottomMargin(541.0000)
Sprite_2_0:setBlendFunc({src = 1, dst = 771})
panel:addChild(Sprite_2_0)

--Create end_bg
local end_bg = cc.Sprite:create("ui/pvp/pvp_end_bg.png")
end_bg:setName("end_bg")
end_bg:setTag(53)
end_bg:setCascadeColorEnabled(true)
end_bg:setCascadeOpacityEnabled(true)
end_bg:setPosition(320.0000, 738.5025)
layout = ccui.LayoutComponent:bindLayoutComponent(end_bg)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.6501)
layout:setPercentWidth(0.9063)
layout:setPercentHeight(0.1937)
layout:setSize({width = 580.0000, height = 220.0000})
layout:setLeftMargin(30.0000)
layout:setRightMargin(30.0000)
layout:setTopMargin(287.4975)
layout:setBottomMargin(628.5025)
end_bg:setBlendFunc({src = 1, dst = 771})
panel:addChild(end_bg)

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
btn_ok:setTag(56)
btn_ok:setCascadeColorEnabled(true)
btn_ok:setCascadeOpacityEnabled(true)
btn_ok:setPosition(319.9998, 225.9958)
layout = ccui.LayoutComponent:bindLayoutComponent(btn_ok)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.1989)
layout:setPercentWidth(0.4563)
layout:setPercentHeight(0.0757)
layout:setSize({width = 292.0000, height = 86.0000})
layout:setLeftMargin(173.9998)
layout:setRightMargin(174.0002)
layout:setTopMargin(867.0042)
layout:setBottomMargin(182.9958)
panel:addChild(btn_ok)

--Create self_panel
local self_panel = ccui.Layout:create()
self_panel:ignoreContentAdaptWithSize(false)
self_panel:setClippingEnabled(false)
self_panel:setBackGroundColorOpacity(0)
self_panel:setTouchEnabled(true);
self_panel:setLayoutComponentEnabled(true)
self_panel:setName("self_panel")
self_panel:setTag(59)
self_panel:setCascadeColorEnabled(true)
self_panel:setCascadeOpacityEnabled(true)
self_panel:setAnchorPoint(0.5000, 0.5000)
self_panel:setPosition(142.0000, 521.0361)
layout = ccui.LayoutComponent:bindLayoutComponent(self_panel)
layout:setPositionPercentX(0.2219)
layout:setPositionPercentY(0.4587)
layout:setPercentWidth(0.3125)
layout:setPercentHeight(0.0880)
layout:setSize({width = 200.0000, height = 100.0000})
layout:setLeftMargin(42.0000)
layout:setRightMargin(398.0000)
layout:setTopMargin(564.9639)
layout:setBottomMargin(471.0361)
panel:addChild(self_panel)

--Create score_panel_self
local score_panel_self = ccui.Layout:create()
score_panel_self:ignoreContentAdaptWithSize(false)
score_panel_self:setClippingEnabled(false)
score_panel_self:setBackGroundColorOpacity(102)
score_panel_self:setTouchEnabled(true);
score_panel_self:setLayoutComponentEnabled(true)
score_panel_self:setName("score_panel_self")
score_panel_self:setTag(27)
score_panel_self:setCascadeColorEnabled(true)
score_panel_self:setCascadeOpacityEnabled(true)
score_panel_self:setAnchorPoint(0.5000, 0.5000)
score_panel_self:setPosition(106.2287, 48.1337)
layout = ccui.LayoutComponent:bindLayoutComponent(score_panel_self)
layout:setPositionPercentX(0.5311)
layout:setPositionPercentY(0.4813)
layout:setPercentWidth(0.5500)
layout:setPercentHeight(0.4000)
layout:setSize({width = 110.0000, height = 40.0000})
layout:setLeftMargin(51.2287)
layout:setRightMargin(38.7713)
layout:setTopMargin(31.8663)
layout:setBottomMargin(28.1337)
self_panel:addChild(score_panel_self)

--Create Sprite_4
local Sprite_4 = cc.Sprite:create("ui/pvp/pvp_score_bg.png")
Sprite_4:setName("Sprite_4")
Sprite_4:setTag(57)
Sprite_4:setCascadeColorEnabled(true)
Sprite_4:setCascadeOpacityEnabled(true)
Sprite_4:setPosition(54.9999, 19.7401)
layout = ccui.LayoutComponent:bindLayoutComponent(Sprite_4)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.4935)
layout:setPercentWidth(1.0000)
layout:setPercentHeight(1.0000)
layout:setSize({width = 110.0000, height = 40.0000})
layout:setLeftMargin(-0.0001)
layout:setRightMargin(0.0001)
layout:setTopMargin(0.2599)
layout:setBottomMargin(-0.2599)
Sprite_4:setBlendFunc({src = 1, dst = 771})
score_panel_self:addChild(Sprite_4)

--Create Sprite_5
cc.SpriteFrameCache:getInstance():addSpriteFrames("ui/plist/common.plist")
local Sprite_5 = cc.Sprite:createWithSpriteFrameName("score_bg.png")
Sprite_5:setName("Sprite_5")
Sprite_5:setTag(58)
Sprite_5:setCascadeColorEnabled(true)
Sprite_5:setCascadeOpacityEnabled(true)
Sprite_5:setPosition(6.2906, 20.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(Sprite_5)
layout:setPositionPercentX(0.0572)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(0.4000)
layout:setPercentHeight(0.9000)
layout:setSize({width = 44.0000, height = 36.0000})
layout:setLeftMargin(-15.7094)
layout:setRightMargin(81.7094)
layout:setTopMargin(2.0000)
layout:setBottomMargin(2.0000)
Sprite_5:setBlendFunc({src = 1, dst = 771})
score_panel_self:addChild(Sprite_5)

--Create lb_score_self
local lb_score_self = ccui.Text:create()
lb_score_self:ignoreContentAdaptWithSize(true)
lb_score_self:setTextAreaSize({width = 0, height = 0})
lb_score_self:setFontSize(24)
lb_score_self:setString([[+23]])
lb_score_self:enableShadow({r = 0, g = 0, b = 0, a = 255}, {width = 1, height = -1}, 0)
lb_score_self:setLayoutComponentEnabled(true)
lb_score_self:setName("lb_score_self")
lb_score_self:setTag(60)
lb_score_self:setCascadeColorEnabled(true)
lb_score_self:setCascadeOpacityEnabled(true)
lb_score_self:setPosition(57.5174, 20.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(lb_score_self)
layout:setPositionPercentX(0.5229)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(0.3273)
layout:setPercentHeight(0.6000)
layout:setSize({width = 36.0000, height = 24.0000})
layout:setLeftMargin(39.5174)
layout:setRightMargin(34.4826)
layout:setTopMargin(8.0000)
layout:setBottomMargin(8.0000)
score_panel_self:addChild(lb_score_self)

--Create lb_num_self
local lb_num_self = ccui.TextAtlas:create([[1200]],
													"ui/number_atlas/number_yellow.png",
													24,
													34,
													"0")
lb_num_self:setLayoutComponentEnabled(true)
lb_num_self:setName("lb_num_self")
lb_num_self:setTag(70)
lb_num_self:setCascadeColorEnabled(true)
lb_num_self:setCascadeOpacityEnabled(true)
lb_num_self:setPosition(100.5723, 101.8784)
layout = ccui.LayoutComponent:bindLayoutComponent(lb_num_self)
layout:setPositionPercentX(0.5029)
layout:setPositionPercentY(1.0188)
layout:setPercentWidth(0.4800)
layout:setPercentHeight(0.3400)
layout:setSize({width = 96.0000, height = 34.0000})
layout:setLeftMargin(52.5723)
layout:setRightMargin(51.4277)
layout:setTopMargin(-18.8784)
layout:setBottomMargin(84.8784)
self_panel:addChild(lb_num_self)

--Create lb_name_self
local lb_name_self = ccui.Text:create()
lb_name_self:ignoreContentAdaptWithSize(true)
lb_name_self:setTextAreaSize({width = 0, height = 0})
lb_name_self:setFontSize(38)
lb_name_self:setString([[收集星星]])
lb_name_self:enableShadow({r = 0, g = 0, b = 0, a = 255}, {width = 2, height = -1}, 0)
lb_name_self:setLayoutComponentEnabled(true)
lb_name_self:setName("lb_name_self")
lb_name_self:setTag(67)
lb_name_self:setCascadeColorEnabled(true)
lb_name_self:setCascadeOpacityEnabled(true)
lb_name_self:setPosition(118.0253, 316.7489)
lb_name_self:setTextColor({r = 104, g = 178, b = 246})
layout = ccui.LayoutComponent:bindLayoutComponent(lb_name_self)
layout:setPositionPercentX(0.5901)
layout:setPositionPercentY(3.1675)
layout:setPercentWidth(0.7600)
layout:setPercentHeight(0.3800)
layout:setSize({width = 152.0000, height = 38.0000})
layout:setLeftMargin(42.0253)
layout:setRightMargin(5.9747)
layout:setTopMargin(-235.7489)
layout:setBottomMargin(297.7489)
self_panel:addChild(lb_name_self)

--Create win_self
cc.SpriteFrameCache:getInstance():addSpriteFrames("ui/plist/common.plist")
local win_self = cc.Sprite:createWithSpriteFrameName("winner.png")
win_self:setName("win_self")
win_self:setTag(68)
win_self:setCascadeColorEnabled(true)
win_self:setCascadeOpacityEnabled(true)
win_self:setPosition(121.2883, 242.5608)
layout = ccui.LayoutComponent:bindLayoutComponent(win_self)
layout:setPositionPercentX(0.6064)
layout:setPositionPercentY(2.4256)
layout:setPercentWidth(0.8500)
layout:setPercentHeight(0.6000)
layout:setSize({width = 170.0000, height = 60.0000})
layout:setLeftMargin(36.2883)
layout:setRightMargin(-6.2883)
layout:setTopMargin(-172.5608)
layout:setBottomMargin(212.5608)
win_self:setBlendFunc({src = 1, dst = 771})
self_panel:addChild(win_self)

--Create target_Panel
local target_Panel = ccui.Layout:create()
target_Panel:ignoreContentAdaptWithSize(false)
target_Panel:setClippingEnabled(false)
target_Panel:setBackGroundColorOpacity(0)
target_Panel:setTouchEnabled(true);
target_Panel:setLayoutComponentEnabled(true)
target_Panel:setName("target_Panel")
target_Panel:setTag(61)
target_Panel:setCascadeColorEnabled(true)
target_Panel:setCascadeOpacityEnabled(true)
target_Panel:setAnchorPoint(0.5000, 0.5000)
target_Panel:setPosition(491.8362, 521.0361)
layout = ccui.LayoutComponent:bindLayoutComponent(target_Panel)
layout:setPositionPercentX(0.7685)
layout:setPositionPercentY(0.4587)
layout:setPercentWidth(0.3125)
layout:setPercentHeight(0.0880)
layout:setSize({width = 200.0000, height = 100.0000})
layout:setLeftMargin(391.8362)
layout:setRightMargin(48.1638)
layout:setTopMargin(564.9639)
layout:setBottomMargin(471.0361)
panel:addChild(target_Panel)

--Create score_panel_target
local score_panel_target = ccui.Layout:create()
score_panel_target:ignoreContentAdaptWithSize(false)
score_panel_target:setClippingEnabled(false)
score_panel_target:setBackGroundColorOpacity(102)
score_panel_target:setTouchEnabled(true);
score_panel_target:setLayoutComponentEnabled(true)
score_panel_target:setName("score_panel_target")
score_panel_target:setTag(28)
score_panel_target:setCascadeColorEnabled(true)
score_panel_target:setCascadeOpacityEnabled(true)
score_panel_target:setAnchorPoint(0.5000, 0.5000)
score_panel_target:setPosition(103.7094, 48.1337)
layout = ccui.LayoutComponent:bindLayoutComponent(score_panel_target)
layout:setPositionPercentX(0.5185)
layout:setPositionPercentY(0.4813)
layout:setPercentWidth(0.5500)
layout:setPercentHeight(0.4000)
layout:setSize({width = 110.0000, height = 40.0000})
layout:setLeftMargin(48.7094)
layout:setRightMargin(41.2906)
layout:setTopMargin(31.8663)
layout:setBottomMargin(28.1337)
target_Panel:addChild(score_panel_target)

--Create Sprite_4
local Sprite_4 = cc.Sprite:create("ui/pvp/pvp_score_bg.png")
Sprite_4:setName("Sprite_4")
Sprite_4:setTag(62)
Sprite_4:setCascadeColorEnabled(true)
Sprite_4:setCascadeOpacityEnabled(true)
Sprite_4:setPosition(54.9999, 22.2599)
layout = ccui.LayoutComponent:bindLayoutComponent(Sprite_4)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.5565)
layout:setPercentWidth(1.0000)
layout:setPercentHeight(1.0000)
layout:setSize({width = 110.0000, height = 40.0000})
layout:setLeftMargin(-0.0001)
layout:setRightMargin(0.0001)
layout:setTopMargin(-2.2599)
layout:setBottomMargin(2.2599)
Sprite_4:setBlendFunc({src = 1, dst = 771})
score_panel_target:addChild(Sprite_4)

--Create Sprite_5
cc.SpriteFrameCache:getInstance():addSpriteFrames("ui/plist/common.plist")
local Sprite_5 = cc.Sprite:createWithSpriteFrameName("score_bg.png")
Sprite_5:setName("Sprite_5")
Sprite_5:setTag(63)
Sprite_5:setCascadeColorEnabled(true)
Sprite_5:setCascadeOpacityEnabled(true)
Sprite_5:setPosition(6.2900, 20.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(Sprite_5)
layout:setPositionPercentX(0.0572)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(0.4000)
layout:setPercentHeight(0.9000)
layout:setSize({width = 44.0000, height = 36.0000})
layout:setLeftMargin(-15.7100)
layout:setRightMargin(81.7100)
layout:setTopMargin(2.0000)
layout:setBottomMargin(2.0000)
Sprite_5:setBlendFunc({src = 1, dst = 771})
score_panel_target:addChild(Sprite_5)

--Create lb_score_target
local lb_score_target = ccui.Text:create()
lb_score_target:ignoreContentAdaptWithSize(true)
lb_score_target:setTextAreaSize({width = 0, height = 0})
lb_score_target:setFontSize(24)
lb_score_target:setString([[+23]])
lb_score_target:enableShadow({r = 0, g = 0, b = 0, a = 255}, {width = 1, height = -1}, 0)
lb_score_target:setLayoutComponentEnabled(true)
lb_score_target:setName("lb_score_target")
lb_score_target:setTag(64)
lb_score_target:setCascadeColorEnabled(true)
lb_score_target:setCascadeOpacityEnabled(true)
lb_score_target:setPosition(57.5200, 20.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(lb_score_target)
layout:setPositionPercentX(0.5229)
layout:setPositionPercentY(0.5000)
layout:setPercentWidth(0.3273)
layout:setPercentHeight(0.6000)
layout:setSize({width = 36.0000, height = 24.0000})
layout:setLeftMargin(39.5200)
layout:setRightMargin(34.4800)
layout:setTopMargin(8.0000)
layout:setBottomMargin(8.0000)
score_panel_target:addChild(lb_score_target)

--Create lb_num_target
local lb_num_target = ccui.TextAtlas:create([[1200]],
													"ui/number_atlas/number_yellow.png",
													24,
													34,
													"0")
lb_num_target:setLayoutComponentEnabled(true)
lb_num_target:setName("lb_num_target")
lb_num_target:setTag(71)
lb_num_target:setCascadeColorEnabled(true)
lb_num_target:setCascadeOpacityEnabled(true)
lb_num_target:setPosition(97.5726, 101.8782)
layout = ccui.LayoutComponent:bindLayoutComponent(lb_num_target)
layout:setPositionPercentX(0.4879)
layout:setPositionPercentY(1.0188)
layout:setPercentWidth(0.4800)
layout:setPercentHeight(0.3400)
layout:setSize({width = 96.0000, height = 34.0000})
layout:setLeftMargin(49.5726)
layout:setRightMargin(54.4274)
layout:setTopMargin(-18.8782)
layout:setBottomMargin(84.8782)
target_Panel:addChild(lb_num_target)

--Create lb_name_target
local lb_name_target = ccui.Text:create()
lb_name_target:ignoreContentAdaptWithSize(true)
lb_name_target:setTextAreaSize({width = 0, height = 0})
lb_name_target:setFontSize(38)
lb_name_target:setString([[收集星星]])
lb_name_target:enableShadow({r = 11, g = 29, b = 26, a = 255}, {width = 2, height = -1}, 0)
lb_name_target:setLayoutComponentEnabled(true)
lb_name_target:setName("lb_name_target")
lb_name_target:setTag(66)
lb_name_target:setCascadeColorEnabled(true)
lb_name_target:setCascadeOpacityEnabled(true)
lb_name_target:setPosition(99.5108, 316.7489)
lb_name_target:setTextColor({r = 242, g = 102, b = 139})
layout = ccui.LayoutComponent:bindLayoutComponent(lb_name_target)
layout:setPositionPercentX(0.4976)
layout:setPositionPercentY(3.1675)
layout:setPercentWidth(0.7600)
layout:setPercentHeight(0.3800)
layout:setSize({width = 152.0000, height = 38.0000})
layout:setLeftMargin(23.5108)
layout:setRightMargin(24.4892)
layout:setTopMargin(-235.7489)
layout:setBottomMargin(297.7489)
target_Panel:addChild(lb_name_target)

--Create win_target
cc.SpriteFrameCache:getInstance():addSpriteFrames("ui/plist/common.plist")
local win_target = cc.Sprite:createWithSpriteFrameName("winner.png")
win_target:setName("win_target")
win_target:setTag(69)
win_target:setCascadeColorEnabled(true)
win_target:setCascadeOpacityEnabled(true)
win_target:setPosition(104.0204, 242.5608)
layout = ccui.LayoutComponent:bindLayoutComponent(win_target)
layout:setPositionPercentX(0.5201)
layout:setPositionPercentY(2.4256)
layout:setPercentWidth(0.8500)
layout:setPercentHeight(0.6000)
layout:setSize({width = 170.0000, height = 60.0000})
layout:setLeftMargin(19.0204)
layout:setRightMargin(10.9796)
layout:setTopMargin(-172.5608)
layout:setBottomMargin(212.5608)
win_target:setBlendFunc({src = 1, dst = 771})
target_Panel:addChild(win_target)

--Create task_info
local task_info = ccui.Layout:create()
task_info:ignoreContentAdaptWithSize(false)
task_info:setClippingEnabled(false)
task_info:setBackGroundColorOpacity(102)
task_info:setTouchEnabled(true);
task_info:setLayoutComponentEnabled(true)
task_info:setName("task_info")
task_info:setTag(58)
task_info:setCascadeColorEnabled(true)
task_info:setCascadeOpacityEnabled(true)
task_info:setVisible(false)
task_info:setAnchorPoint(0.5000, 0.5000)
task_info:setPosition(156.2470, 372.7134)
layout = ccui.LayoutComponent:bindLayoutComponent(task_info)
layout:setPositionPercentX(0.2441)
layout:setPositionPercentY(0.3281)
layout:setPercentWidth(0.3125)
layout:setPercentHeight(0.1761)
layout:setSize({width = 200.0000, height = 200.0000})
layout:setLeftMargin(56.2470)
layout:setRightMargin(383.7530)
layout:setTopMargin(663.2866)
layout:setBottomMargin(272.7134)
panel:addChild(task_info)

--Create task_icon
local task_icon = cc.Sprite:create("ui/common/task.png")
task_icon:setName("task_icon")
task_icon:setTag(54)
task_icon:setCascadeColorEnabled(true)
task_icon:setCascadeOpacityEnabled(true)
task_icon:setPosition(49.2915, 116.0919)
task_icon:setScaleX(0.1858)
task_icon:setScaleY(0.1858)
layout = ccui.LayoutComponent:bindLayoutComponent(task_icon)
layout:setPositionPercentX(0.2465)
layout:setPositionPercentY(0.5805)
layout:setPercentWidth(2.5600)
layout:setPercentHeight(2.5600)
layout:setSize({width = 512.0000, height = 512.0000})
layout:setLeftMargin(-206.7085)
layout:setRightMargin(-105.2915)
layout:setTopMargin(-172.0919)
layout:setBottomMargin(-139.9081)
task_icon:setBlendFunc({src = 1, dst = 771})
task_info:addChild(task_icon)

--Create task_name
local task_name = ccui.Text:create()
task_name:ignoreContentAdaptWithSize(true)
task_name:setTextAreaSize({width = 0, height = 0})
task_name:setFontSize(26)
task_name:setString([[参与1场PVP]])
task_name:enableShadow({r = 0, g = 0, b = 0, a = 255}, {width = 1, height = -1}, 0)
task_name:setLayoutComponentEnabled(true)
task_name:setName("task_name")
task_name:setTag(55)
task_name:setCascadeColorEnabled(true)
task_name:setCascadeOpacityEnabled(true)
task_name:setAnchorPoint(0.0000, 0.5000)
task_name:setPosition(101.9087, 141.0578)
layout = ccui.LayoutComponent:bindLayoutComponent(task_name)
layout:setPositionPercentX(0.5095)
layout:setPositionPercentY(0.7053)
layout:setPercentWidth(0.6500)
layout:setPercentHeight(0.1300)
layout:setSize({width = 130.0000, height = 26.0000})
layout:setLeftMargin(101.9087)
layout:setRightMargin(-31.9087)
layout:setTopMargin(45.9422)
layout:setBottomMargin(128.0578)
task_info:addChild(task_name)

--Create reward_icon
local reward_icon = ccui.ImageView:create()
reward_icon:ignoreContentAdaptWithSize(false)
reward_icon:loadTexture("icon/gem_bg.png",0)
reward_icon:setLayoutComponentEnabled(true)
reward_icon:setName("reward_icon")
reward_icon:setTag(56)
reward_icon:setCascadeColorEnabled(true)
reward_icon:setCascadeOpacityEnabled(true)
reward_icon:setPosition(120.6710, 95.5262)
layout = ccui.LayoutComponent:bindLayoutComponent(reward_icon)
layout:setPositionPercentX(0.6034)
layout:setPositionPercentY(0.4776)
layout:setPercentWidth(0.2200)
layout:setPercentHeight(0.2200)
layout:setSize({width = 44.0000, height = 44.0000})
layout:setLeftMargin(98.6710)
layout:setRightMargin(57.3290)
layout:setTopMargin(82.4739)
layout:setBottomMargin(73.5262)
task_info:addChild(reward_icon)

--Create reward_num
local reward_num = ccui.Text:create()
reward_num:ignoreContentAdaptWithSize(true)
reward_num:setTextAreaSize({width = 0, height = 0})
reward_num:setFontSize(24)
reward_num:setString([[×10]])
reward_num:enableShadow({r = 0, g = 0, b = 0, a = 255}, {width = 1, height = -1}, 0)
reward_num:setLayoutComponentEnabled(true)
reward_num:setName("reward_num")
reward_num:setTag(57)
reward_num:setCascadeColorEnabled(true)
reward_num:setCascadeOpacityEnabled(true)
reward_num:setAnchorPoint(0.0000, 0.5000)
reward_num:setPosition(146.3266, 96.5244)
layout = ccui.LayoutComponent:bindLayoutComponent(reward_num)
layout:setPositionPercentX(0.7316)
layout:setPositionPercentY(0.4826)
layout:setPercentWidth(0.2400)
layout:setPercentHeight(0.1200)
layout:setSize({width = 48.0000, height = 24.0000})
layout:setLeftMargin(146.3266)
layout:setRightMargin(5.6734)
layout:setTopMargin(91.4756)
layout:setBottomMargin(84.5244)
task_info:addChild(reward_num)

--Create task_done_icon
local task_done_icon = cc.Sprite:create("ui/common/timg.png")
task_done_icon:setName("task_done_icon")
task_done_icon:setTag(59)
task_done_icon:setCascadeColorEnabled(true)
task_done_icon:setCascadeOpacityEnabled(true)
task_done_icon:setVisible(false)
task_done_icon:setPosition(266.8907, 115.4585)
task_done_icon:setScaleX(0.7300)
task_done_icon:setScaleY(0.7300)
layout = ccui.LayoutComponent:bindLayoutComponent(task_done_icon)
layout:setPositionPercentX(1.3345)
layout:setPositionPercentY(0.5773)
layout:setPercentWidth(0.6400)
layout:setPercentHeight(0.6500)
layout:setSize({width = 128.0000, height = 130.0000})
layout:setLeftMargin(202.8907)
layout:setRightMargin(-130.8907)
layout:setTopMargin(19.5415)
layout:setBottomMargin(50.4585)
task_done_icon:setBlendFunc({src = 1, dst = 771})
task_info:addChild(task_done_icon)

--Create task_done_txt
local task_done_txt = ccui.Text:create()
task_done_txt:ignoreContentAdaptWithSize(true)
task_done_txt:setTextAreaSize({width = 0, height = 0})
task_done_txt:setFontSize(28)
task_done_txt:setString([[完成]])
task_done_txt:enableShadow({r = 159, g = 1, b = 0, a = 255}, {width = 1, height = -1}, 0)
task_done_txt:setLayoutComponentEnabled(true)
task_done_txt:setName("task_done_txt")
task_done_txt:setTag(60)
task_done_txt:setCascadeColorEnabled(true)
task_done_txt:setCascadeOpacityEnabled(true)
task_done_txt:setPosition(64.0313, 65.1726)
task_done_txt:setRotationSkewX(-51.1990)
task_done_txt:setRotationSkewY(-51.1990)
task_done_txt:setTextColor({r = 0, g = 181, b = 105})
layout = ccui.LayoutComponent:bindLayoutComponent(task_done_txt)
layout:setPositionPercentX(0.5002)
layout:setPositionPercentY(0.5013)
layout:setPercentWidth(0.4375)
layout:setPercentHeight(0.2154)
layout:setSize({width = 56.0000, height = 28.0000})
layout:setLeftMargin(36.0313)
layout:setRightMargin(35.9687)
layout:setTopMargin(50.8275)
layout:setBottomMargin(51.1726)
task_done_icon:addChild(task_done_txt)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(0.1667)
--Create Animation List

result['root'] = Scene
return result;
end

return Result

