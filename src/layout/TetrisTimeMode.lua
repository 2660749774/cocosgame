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
panel:setTouchEnabled(true);
panel:setLayoutComponentEnabled(true)
panel:setName("panel")
panel:setTag(34)
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

--Create scene_bg
local scene_bg = ccui.ImageView:create()
scene_bg:ignoreContentAdaptWithSize(false)
scene_bg:loadTexture("ui/tetris/power/power_bg.png",0)
scene_bg:setLayoutComponentEnabled(true)
scene_bg:setName("scene_bg")
scene_bg:setTag(64)
scene_bg:setCascadeColorEnabled(true)
scene_bg:setCascadeOpacityEnabled(true)
scene_bg:setPosition(319.1040, 568.9088)
layout = ccui.LayoutComponent:bindLayoutComponent(scene_bg)
layout:setPositionPercentXEnabled(true)
layout:setPositionPercentYEnabled(true)
layout:setPositionPercentX(0.4986)
layout:setPositionPercentY(0.5008)
layout:setPercentWidth(1.3313)
layout:setPercentHeight(1.0000)
layout:setSize({width = 852.0000, height = 1136.0000})
layout:setLeftMargin(-106.8960)
layout:setRightMargin(-105.1040)
layout:setTopMargin(-0.9088)
layout:setBottomMargin(0.9088)
panel:addChild(scene_bg)

--Create tetris_panel
local tetris_panel = ccui.Layout:create()
tetris_panel:ignoreContentAdaptWithSize(false)
tetris_panel:setClippingEnabled(true)
tetris_panel:setBackGroundColorOpacity(102)
tetris_panel:setTouchEnabled(true);
tetris_panel:setLayoutComponentEnabled(true)
tetris_panel:setName("tetris_panel")
tetris_panel:setTag(32)
tetris_panel:setCascadeColorEnabled(true)
tetris_panel:setCascadeOpacityEnabled(true)
tetris_panel:setAnchorPoint(0.5000, 0.5000)
tetris_panel:setPosition(318.9999, 643.3920)
layout = ccui.LayoutComponent:bindLayoutComponent(tetris_panel)
layout:setPositionPercentX(0.4984)
layout:setPositionPercentY(0.5664)
layout:setPercentWidth(0.5953)
layout:setPercentHeight(0.4780)
layout:setSize({width = 381.0000, height = 543.0000})
layout:setLeftMargin(128.4999)
layout:setRightMargin(130.5001)
layout:setTopMargin(221.1080)
layout:setBottomMargin(371.8920)
panel:addChild(tetris_panel)

--Create btn_down_low
local btn_down_low = ccui.Button:create()
btn_down_low:ignoreContentAdaptWithSize(false)
btn_down_low:loadTextureNormal("ui/tetris/down.png",0)
btn_down_low:loadTexturePressed("ui/tetris/down.png",0)
btn_down_low:loadTextureDisabled("ui/tetris/down.png",0)
btn_down_low:setTitleFontSize(28)
btn_down_low:setScale9Enabled(true)
btn_down_low:setCapInsets({x = 15, y = 11, width = 66, height = 74})
btn_down_low:setLayoutComponentEnabled(true)
btn_down_low:setName("btn_down_low")
btn_down_low:setTag(15)
btn_down_low:setCascadeColorEnabled(true)
btn_down_low:setCascadeOpacityEnabled(true)
btn_down_low:setPosition(173.3403, 68.5792)
layout = ccui.LayoutComponent:bindLayoutComponent(btn_down_low)
layout:setPositionPercentX(0.2708)
layout:setPositionPercentY(0.0604)
layout:setPercentWidth(0.1500)
layout:setPercentHeight(0.0845)
layout:setSize({width = 96.0000, height = 96.0000})
layout:setLeftMargin(125.3403)
layout:setRightMargin(418.6597)
layout:setTopMargin(1019.4210)
layout:setBottomMargin(20.5792)
panel:addChild(btn_down_low)

--Create btn_down
local btn_down = ccui.Button:create()
btn_down:ignoreContentAdaptWithSize(false)
btn_down:loadTextureNormal("ui/tetris/down_fast.png",0)
btn_down:loadTexturePressed("ui/tetris/down_fast.png",0)
btn_down:loadTextureDisabled("ui/tetris/down_fast.png",0)
btn_down:setTitleFontSize(28)
btn_down:setScale9Enabled(true)
btn_down:setCapInsets({x = 15, y = 11, width = 66, height = 74})
btn_down:setLayoutComponentEnabled(true)
btn_down:setName("btn_down")
btn_down:setTag(42)
btn_down:setCascadeColorEnabled(true)
btn_down:setCascadeOpacityEnabled(true)
btn_down:setPosition(173.6924, 214.0341)
layout = ccui.LayoutComponent:bindLayoutComponent(btn_down)
layout:setPositionPercentX(0.2714)
layout:setPositionPercentY(0.1884)
layout:setPercentWidth(0.1500)
layout:setPercentHeight(0.0845)
layout:setSize({width = 96.0000, height = 96.0000})
layout:setLeftMargin(125.6924)
layout:setRightMargin(418.3076)
layout:setTopMargin(873.9659)
layout:setBottomMargin(166.0341)
panel:addChild(btn_down)

--Create lb_score_title
local lb_score_title = ccui.Text:create()
lb_score_title:ignoreContentAdaptWithSize(true)
lb_score_title:setTextAreaSize({width = 0, height = 0})
lb_score_title:setFontSize(28)
lb_score_title:setString([[分 数]])
lb_score_title:setLayoutComponentEnabled(true)
lb_score_title:setName("lb_score_title")
lb_score_title:setTag(26)
lb_score_title:setCascadeColorEnabled(true)
lb_score_title:setCascadeOpacityEnabled(true)
lb_score_title:setVisible(false)
lb_score_title:setPosition(513.1556, 855.5805)
layout = ccui.LayoutComponent:bindLayoutComponent(lb_score_title)
layout:setPositionPercentX(0.8018)
layout:setPositionPercentY(0.7532)
layout:setPercentWidth(0.1094)
layout:setPercentHeight(0.0246)
layout:setSize({width = 70.0000, height = 28.0000})
layout:setLeftMargin(478.1556)
layout:setRightMargin(91.8444)
layout:setTopMargin(266.4195)
layout:setBottomMargin(841.5805)
panel:addChild(lb_score_title)

--Create lb_score
local lb_score = ccui.TextAtlas:create([[5211]],
													"ui/tetris/number.png",
													30,
													50,
													"0")
lb_score:setLayoutComponentEnabled(true)
lb_score:setName("lb_score")
lb_score:setTag(65)
lb_score:setCascadeColorEnabled(true)
lb_score:setCascadeOpacityEnabled(true)
lb_score:setVisible(false)
lb_score:setPosition(514.0000, 796.7838)
layout = ccui.LayoutComponent:bindLayoutComponent(lb_score)
layout:setPositionPercentX(0.8031)
layout:setPositionPercentY(0.7014)
layout:setPercentWidth(0.1875)
layout:setPercentHeight(0.0440)
layout:setSize({width = 120.0000, height = 50.0000})
layout:setLeftMargin(454.0000)
layout:setRightMargin(66.0000)
layout:setTopMargin(314.2162)
layout:setBottomMargin(771.7838)
panel:addChild(lb_score)

--Create btn_play
local btn_play = ccui.Button:create()
btn_play:ignoreContentAdaptWithSize(false)
cc.SpriteFrameCache:getInstance():addSpriteFrames("res/pack.plist")
btn_play:loadTextureNormal("PlayButton.png",1)
cc.SpriteFrameCache:getInstance():addSpriteFrames("res/pack.plist")
btn_play:loadTexturePressed("PlayButton.png",1)
cc.SpriteFrameCache:getInstance():addSpriteFrames("res/pack.plist")
btn_play:loadTextureDisabled("PlayButton.png",1)
btn_play:setTitleFontSize(14)
btn_play:setTitleColor({r = 65, g = 65, b = 70})
btn_play:setScale9Enabled(true)
btn_play:setCapInsets({x = 15, y = 11, width = 210, height = 98})
btn_play:setLayoutComponentEnabled(true)
btn_play:setName("btn_play")
btn_play:setTag(41)
btn_play:setCascadeColorEnabled(true)
btn_play:setCascadeOpacityEnabled(true)
btn_play:setPosition(327.0454, 665.1121)
layout = ccui.LayoutComponent:bindLayoutComponent(btn_play)
layout:setPositionPercentX(0.5110)
layout:setPositionPercentY(0.5855)
layout:setPercentWidth(0.3750)
layout:setPercentHeight(0.1056)
layout:setSize({width = 240.0000, height = 120.0000})
layout:setLeftMargin(207.0454)
layout:setRightMargin(192.9546)
layout:setTopMargin(410.8879)
layout:setBottomMargin(605.1121)
panel:addChild(btn_play)

--Create btn_shift
local btn_shift = ccui.Button:create()
btn_shift:ignoreContentAdaptWithSize(false)
btn_shift:loadTextureNormal("ui/tetris/shift.png",0)
btn_shift:loadTexturePressed("ui/tetris/shift.png",0)
btn_shift:loadTextureDisabled("ui/tetris/shift.png",0)
btn_shift:setTitleFontSize(28)
btn_shift:setScale9Enabled(true)
btn_shift:setCapInsets({x = 15, y = 11, width = 123, height = 131})
btn_shift:setLayoutComponentEnabled(true)
btn_shift:setName("btn_shift")
btn_shift:setTag(27)
btn_shift:setCascadeColorEnabled(true)
btn_shift:setCascadeOpacityEnabled(true)
btn_shift:setPosition(527.2410, 116.4452)
layout = ccui.LayoutComponent:bindLayoutComponent(btn_shift)
layout:setPositionPercentX(0.8238)
layout:setPositionPercentY(0.1025)
layout:setPercentWidth(0.2391)
layout:setPercentHeight(0.1347)
layout:setSize({width = 153.0000, height = 153.0000})
layout:setLeftMargin(450.7410)
layout:setRightMargin(36.2590)
layout:setTopMargin(943.0548)
layout:setBottomMargin(39.9452)
panel:addChild(btn_shift)

--Create btn_right
local btn_right = ccui.Button:create()
btn_right:ignoreContentAdaptWithSize(false)
btn_right:loadTextureNormal("ui/tetris/right.png",0)
btn_right:loadTexturePressed("ui/tetris/right.png",0)
btn_right:loadTextureDisabled("ui/tetris/right.png",0)
btn_right:setTitleFontSize(28)
btn_right:setScale9Enabled(true)
btn_right:setCapInsets({x = 15, y = 11, width = 66, height = 74})
btn_right:setLayoutComponentEnabled(true)
btn_right:setName("btn_right")
btn_right:setTag(26)
btn_right:setCascadeColorEnabled(true)
btn_right:setCascadeOpacityEnabled(true)
btn_right:setPosition(270.1837, 143.5790)
layout = ccui.LayoutComponent:bindLayoutComponent(btn_right)
layout:setPositionPercentX(0.4222)
layout:setPositionPercentY(0.1264)
layout:setPercentWidth(0.1500)
layout:setPercentHeight(0.0845)
layout:setSize({width = 96.0000, height = 96.0000})
layout:setLeftMargin(222.1837)
layout:setRightMargin(321.8163)
layout:setTopMargin(944.4210)
layout:setBottomMargin(95.5790)
panel:addChild(btn_right)

--Create btn_left
local btn_left = ccui.Button:create()
btn_left:ignoreContentAdaptWithSize(false)
btn_left:loadTextureNormal("ui/tetris/left.png",0)
btn_left:loadTexturePressed("ui/tetris/left.png",0)
btn_left:loadTextureDisabled("ui/tetris/left.png",0)
btn_left:setTitleFontSize(28)
btn_left:setLayoutComponentEnabled(true)
btn_left:setName("btn_left")
btn_left:setTag(25)
btn_left:setCascadeColorEnabled(true)
btn_left:setCascadeOpacityEnabled(true)
btn_left:setPosition(79.0177, 143.5790)
layout = ccui.LayoutComponent:bindLayoutComponent(btn_left)
layout:setPositionPercentX(0.1235)
layout:setPositionPercentY(0.1264)
layout:setPercentWidth(0.1500)
layout:setPercentHeight(0.0845)
layout:setSize({width = 96.0000, height = 96.0000})
layout:setLeftMargin(31.0177)
layout:setRightMargin(512.9823)
layout:setTopMargin(944.4210)
layout:setBottomMargin(95.5790)
panel:addChild(btn_left)

--Create del_line
local del_line = cc.Sprite:create("ui/tetris/del_line.png")
del_line:setName("del_line")
del_line:setTag(68)
del_line:setCascadeColorEnabled(true)
del_line:setCascadeOpacityEnabled(true)
del_line:setVisible(false)
del_line:setPosition(501.8242, 405.9948)
layout = ccui.LayoutComponent:bindLayoutComponent(del_line)
layout:setPositionPercentX(0.7841)
layout:setPositionPercentY(0.3574)
layout:setPercentWidth(0.0875)
layout:setPercentHeight(0.0167)
layout:setSize({width = 56.0000, height = 19.0000})
layout:setLeftMargin(473.8242)
layout:setRightMargin(110.1758)
layout:setTopMargin(720.5052)
layout:setBottomMargin(396.4948)
del_line:setBlendFunc({src = 1, dst = 771})
panel:addChild(del_line)

--Create hang
local hang = cc.Sprite:create("ui/tetris/hang.png")
hang:setName("hang")
hang:setTag(69)
hang:setCascadeColorEnabled(true)
hang:setCascadeOpacityEnabled(true)
hang:setVisible(false)
hang:setAnchorPoint(0.4497, 0.4381)
hang:setPosition(537.6376, 404.7581)
layout = ccui.LayoutComponent:bindLayoutComponent(hang)
layout:setPositionPercentX(0.8401)
layout:setPositionPercentY(0.3563)
layout:setPercentWidth(0.0313)
layout:setPercentHeight(0.0176)
layout:setSize({width = 20.0000, height = 20.0000})
layout:setLeftMargin(528.6436)
layout:setRightMargin(91.3565)
layout:setTopMargin(720.0039)
layout:setBottomMargin(395.9961)
hang:setBlendFunc({src = 1, dst = 771})
panel:addChild(hang)

--Create lb_hang
local lb_hang = ccui.TextAtlas:create([[100]],
													"ui/tetris/small number.png",
													10,
													15,
													"0")
lb_hang:setLayoutComponentEnabled(true)
lb_hang:setName("lb_hang")
lb_hang:setTag(72)
lb_hang:setCascadeColorEnabled(true)
lb_hang:setCascadeOpacityEnabled(true)
lb_hang:setVisible(false)
lb_hang:setPosition(510.5633, 376.3556)
layout = ccui.LayoutComponent:bindLayoutComponent(lb_hang)
layout:setPositionPercentX(0.7978)
layout:setPositionPercentY(0.3313)
layout:setPercentWidth(0.0469)
layout:setPercentHeight(0.0132)
layout:setSize({width = 30.0000, height = 15.0000})
layout:setLeftMargin(495.5633)
layout:setRightMargin(114.4367)
layout:setTopMargin(752.1444)
layout:setBottomMargin(368.8556)
panel:addChild(lb_hang)

--Create lb_left_line
local lb_left_line = ccui.TextAtlas:create([[10]],
													"ui/tetris/power/number_red.png",
													30,
													50,
													"0")
lb_left_line:setLayoutComponentEnabled(true)
lb_left_line:setName("lb_left_line")
lb_left_line:setTag(25)
lb_left_line:setCascadeColorEnabled(true)
lb_left_line:setCascadeOpacityEnabled(true)
lb_left_line:setVisible(false)
lb_left_line:setPosition(320.0000, 1066.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(lb_left_line)
layout:setPositionPercentX(0.5000)
layout:setPositionPercentY(0.9384)
layout:setPercentWidth(0.0938)
layout:setPercentHeight(0.0440)
layout:setSize({width = 60.0000, height = 50.0000})
layout:setLeftMargin(290.0000)
layout:setRightMargin(290.0000)
layout:setTopMargin(45.0001)
layout:setBottomMargin(1041.0000)
panel:addChild(lb_left_line)

--Create lb_time_minute
local lb_time_minute = ccui.TextAtlas:create([[10]],
													"ui/tetris/power/number_red.png",
													30,
													50,
													"0")
lb_time_minute:setLayoutComponentEnabled(true)
lb_time_minute:setName("lb_time_minute")
lb_time_minute:setTag(66)
lb_time_minute:setCascadeColorEnabled(true)
lb_time_minute:setCascadeOpacityEnabled(true)
lb_time_minute:setPosition(275.0262, 1066.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(lb_time_minute)
layout:setPositionPercentX(0.4297)
layout:setPositionPercentY(0.9384)
layout:setPercentWidth(0.0938)
layout:setPercentHeight(0.0440)
layout:setSize({width = 60.0000, height = 50.0000})
layout:setLeftMargin(245.0262)
layout:setRightMargin(334.9738)
layout:setTopMargin(45.0000)
layout:setBottomMargin(1041.0000)
panel:addChild(lb_time_minute)

--Create lb_time_sec
local lb_time_sec = ccui.TextAtlas:create([[10]],
													"ui/tetris/power/number_red.png",
													30,
													50,
													"0")
lb_time_sec:setLayoutComponentEnabled(true)
lb_time_sec:setName("lb_time_sec")
lb_time_sec:setTag(67)
lb_time_sec:setCascadeColorEnabled(true)
lb_time_sec:setCascadeOpacityEnabled(true)
lb_time_sec:setPosition(363.8164, 1066.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(lb_time_sec)
layout:setPositionPercentX(0.5685)
layout:setPositionPercentY(0.9384)
layout:setPercentWidth(0.0938)
layout:setPercentHeight(0.0440)
layout:setSize({width = 60.0000, height = 50.0000})
layout:setLeftMargin(333.8164)
layout:setRightMargin(246.1836)
layout:setTopMargin(45.0000)
layout:setBottomMargin(1041.0000)
panel:addChild(lb_time_sec)

--Create sp_mh
local sp_mh = cc.Sprite:create("ui/tetris/power/mh.png")
sp_mh:setName("sp_mh")
sp_mh:setTag(68)
sp_mh:setCascadeColorEnabled(true)
sp_mh:setCascadeOpacityEnabled(true)
sp_mh:setPosition(318.6265, 1070.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(sp_mh)
layout:setPositionPercentX(0.4979)
layout:setPositionPercentY(0.9419)
layout:setPercentWidth(0.0469)
layout:setPercentHeight(0.0440)
layout:setSize({width = 30.0000, height = 50.0000})
layout:setLeftMargin(303.6265)
layout:setRightMargin(306.3735)
layout:setTopMargin(41.0000)
layout:setBottomMargin(1045.0000)
sp_mh:setBlendFunc({src = 1, dst = 771})
panel:addChild(sp_mh)

--Create lb_left_bg
local lb_left_bg = cc.Sprite:create("ui/tetris/power/lb_left_bg.png")
lb_left_bg:setName("lb_left_bg")
lb_left_bg:setTag(42)
lb_left_bg:setCascadeColorEnabled(true)
lb_left_bg:setCascadeOpacityEnabled(true)
lb_left_bg:setPosition(120.0000, 1057.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(lb_left_bg)
layout:setPositionPercentX(0.1875)
layout:setPositionPercentY(0.9305)
layout:setPercentWidth(0.3750)
layout:setPercentHeight(0.1408)
layout:setSize({width = 240.0000, height = 160.0000})
layout:setRightMargin(400.0000)
layout:setTopMargin(-1.0000)
layout:setBottomMargin(977.0000)
lb_left_bg:setBlendFunc({src = 1, dst = 771})
Scene:addChild(lb_left_bg)

--Create next_bg
local next_bg = ccui.Layout:create()
next_bg:ignoreContentAdaptWithSize(false)
next_bg:setClippingEnabled(false)
next_bg:setBackGroundColorOpacity(102)
next_bg:setTouchEnabled(true);
next_bg:setLayoutComponentEnabled(true)
next_bg:setName("next_bg")
next_bg:setTag(71)
next_bg:setCascadeColorEnabled(true)
next_bg:setCascadeOpacityEnabled(true)
next_bg:setPosition(87.4052, 56.8405)
layout = ccui.LayoutComponent:bindLayoutComponent(next_bg)
layout:setPositionPercentX(0.3642)
layout:setPositionPercentY(0.3553)
layout:setPercentWidth(0.3750)
layout:setPercentHeight(0.5625)
layout:setSize({width = 90.0000, height = 90.0000})
layout:setLeftMargin(87.4052)
layout:setRightMargin(62.5948)
layout:setTopMargin(13.1595)
layout:setBottomMargin(56.8405)
lb_left_bg:addChild(next_bg)

--Create next_bg_title
local next_bg_title = ccui.ImageView:create()
next_bg_title:ignoreContentAdaptWithSize(false)
next_bg_title:loadTexture("ui/tetris/NEXT.png",0)
next_bg_title:setLayoutComponentEnabled(true)
next_bg_title:setName("next_bg_title")
next_bg_title:setTag(66)
next_bg_title:setCascadeColorEnabled(true)
next_bg_title:setCascadeOpacityEnabled(true)
next_bg_title:setPosition(51.8657, 124.4441)
layout = ccui.LayoutComponent:bindLayoutComponent(next_bg_title)
layout:setPositionPercentX(0.2161)
layout:setPositionPercentY(0.7778)
layout:setPercentWidth(0.3333)
layout:setPercentHeight(0.1875)
layout:setSize({width = 80.0000, height = 30.0000})
layout:setLeftMargin(11.8657)
layout:setRightMargin(148.1343)
layout:setTopMargin(20.5559)
layout:setBottomMargin(109.4441)
lb_left_bg:addChild(next_bg_title)

--Create lb_right_bg
local lb_right_bg = cc.Sprite:create("ui/tetris/power/lb_right_bg.png")
lb_right_bg:setName("lb_right_bg")
lb_right_bg:setTag(43)
lb_right_bg:setCascadeColorEnabled(true)
lb_right_bg:setCascadeOpacityEnabled(true)
lb_right_bg:setPosition(520.5939, 1057.0000)
layout = ccui.LayoutComponent:bindLayoutComponent(lb_right_bg)
layout:setPositionPercentX(0.8134)
layout:setPositionPercentY(0.9305)
layout:setPercentWidth(0.3750)
layout:setPercentHeight(0.1408)
layout:setSize({width = 240.0000, height = 160.0000})
layout:setLeftMargin(400.5939)
layout:setRightMargin(-0.5939)
layout:setTopMargin(-1.0000)
layout:setBottomMargin(977.0000)
lb_right_bg:setBlendFunc({src = 1, dst = 771})
Scene:addChild(lb_right_bg)

--Create lb_result_title
local lb_result_title = ccui.Text:create()
lb_result_title:ignoreContentAdaptWithSize(true)
lb_result_title:setTextAreaSize({width = 0, height = 0})
lb_result_title:setFontSize(20)
lb_result_title:setString([[分数：]])
lb_result_title:setLayoutComponentEnabled(true)
lb_result_title:setName("lb_result_title")
lb_result_title:setTag(110)
lb_result_title:setCascadeColorEnabled(true)
lb_result_title:setCascadeOpacityEnabled(true)
lb_result_title:setPosition(94.0601, 73.8188)
layout = ccui.LayoutComponent:bindLayoutComponent(lb_result_title)
layout:setPositionPercentX(0.3919)
layout:setPositionPercentY(0.4614)
layout:setPercentWidth(0.2500)
layout:setPercentHeight(0.1250)
layout:setSize({width = 60.0000, height = 20.0000})
layout:setLeftMargin(64.0601)
layout:setRightMargin(115.9399)
layout:setTopMargin(76.1812)
layout:setBottomMargin(63.8188)
lb_right_bg:addChild(lb_result_title)

--Create pg_result
local pg_result = ccui.Slider:create()
pg_result:ignoreContentAdaptWithSize(false)
pg_result:loadBarTexture("ui/tetris/power/progress_bg.png",0)
pg_result:loadProgressBarTexture("ui/tetris/power/progress.png",0)
pg_result:loadSlidBallTextureNormal("Default/SliderNode_Normal.png",0)
pg_result:loadSlidBallTexturePressed("Default/SliderNode_Press.png",0)
pg_result:loadSlidBallTextureDisabled("Default/SliderNode_Disable.png",0)
pg_result:setPercent(100)
pg_result:setLayoutComponentEnabled(true)
pg_result:setName("pg_result")
pg_result:setTag(109)
pg_result:setCascadeColorEnabled(true)
pg_result:setCascadeOpacityEnabled(true)
pg_result:setPosition(143.5600, 98.3155)
layout = ccui.LayoutComponent:bindLayoutComponent(pg_result)
layout:setPositionPercentX(0.5982)
layout:setPositionPercentY(0.6145)
layout:setPercentWidth(0.7000)
layout:setPercentHeight(0.1563)
layout:setSize({width = 168.0000, height = 25.0000})
layout:setLeftMargin(59.5600)
layout:setRightMargin(12.4400)
layout:setTopMargin(49.1845)
layout:setBottomMargin(85.8155)
lb_right_bg:addChild(pg_result)

--Create lb_result
local lb_result = ccui.TextAtlas:create([[100]],
													"ui/tetris/power/number.png",
													15,
													25,
													"/")
lb_result:setLayoutComponentEnabled(true)
lb_result:setName("lb_result")
lb_result:setTag(45)
lb_result:setCascadeColorEnabled(true)
lb_result:setCascadeOpacityEnabled(true)
lb_result:setPosition(143.5600, 72.4299)
layout = ccui.LayoutComponent:bindLayoutComponent(lb_result)
layout:setPositionPercentX(0.5982)
layout:setPositionPercentY(0.4527)
layout:setPercentWidth(0.1875)
layout:setPercentHeight(0.1563)
layout:setSize({width = 45.0000, height = 25.0000})
layout:setLeftMargin(121.0600)
layout:setRightMargin(73.9400)
layout:setTopMargin(75.0701)
layout:setBottomMargin(59.9299)
lb_right_bg:addChild(lb_result)

--Create Animation
result['animation'] = ccs.ActionTimeline:create()
  
result['animation']:setDuration(0)
result['animation']:setTimeSpeed(1.0000)
--Create Animation List

result['root'] = Scene
return result;
end

return Result

