--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TestScene 测试场景
local TestScene = class("TestScene", BaseScene)

--------------------------------
-- 创建方法
-- @function [parent=#TestScene] onCreate
function TestScene:onCreate()
    local layout = require("layout.UITestScene").create()
    self:addObject(layout["root"], "ui")
    self.layout = layout
    
    -- LoadingBar
    local loadingBar = layout["LoadingBar_2"];
    loadingBar:setPercent(100)
    
    -- Button
    local btn = layout["Button_2"]
    local btn1 = layout["box_1"]
    btn1:addClickEventListener(function() 
        log:info("box click")
    end)
    btn1:addTouchEventListener(handler(self,self.onTouch))
    btn:addTouchEventListener(handler(self,self.onTouch))
    
    -- Slider
    local slider = layout["Slider_3"]
    loadingBar:setPercent(slider:getPercent())
    slider:addEventListener(handler(self,self.onClick))
    
    -- checkBox
    local checkBox = layout["checkBox"]
    checkBox:addEventListener(handler(self, self.onClick))
    
    -- ScrollView
    local scrollView = layout["scrollView"]
    local innerWidth = scrollView:getSize().width
    local innerHeight = scrollView:getSize().height
    scrollView:setInnerContainerSize(cc.size(200, 56 * 10))
    for i = 1, 10 do
        local item = require("layout.ListItem_0").create()
        item['list_label']:setString("num" .. i)
        log:info("item pos, (%d, %d)", 10, scrollView:getInnerContainerSize().height - 56 * i - 12)
        item['root']:setPosition(cc.p(10, scrollView:getInnerContainerSize().height - 56 * i - 12))
        item['panel']:setName("scrollItem" .. i)
        item['Button_1']:setTouchEnabled(false)
        
        local btn = item['panel']
        local touchBeginPoint = nil
        local touchMovePoint = nil
        local isMove = false
        local moveDis = 5
        local function onTouchBegan(touch, event)
            self.layout['info_text']:setString("无事件")
            log:info("onTouchBegan %s", btn:getName())
            isMove = false
            local location = touch:getLocation()
            touchBeginPoint = {x = location.x, y = location.y}
            local s         = btn:getContentSize()
            local rect      = { x=0, y=0, width=s.width, height=s.height }
            local touchP    = btn:convertToNodeSpace( touchBeginPoint )
            if cc.rectContainsPoint(rect, touchP) then
                --btn:setScale(1.1)
            end
            return true
        end
        local function onTouchMove(touch, event)
            local location = touch:getLocation()
            touchMovePoint = {x = location.x, y = location.y}
            log:info("onTouchMove dis %d", math.abs(touchBeginPoint.y - touchMovePoint.y))
            if math.abs(touchBeginPoint.y - touchMovePoint.y) > moveDis then
                isMove = true
                btn:setScale(1.0)
            end
        end
        local function onTouchEnd(touch, event)
            log:info("onTouchEnd %s", btn:getName())
            local location = touch:getLocation()
            touchBeginPoint = {x = location.x, y = location.y}
            local s         = btn:getContentSize()
            local rect      = { x=0, y=0, width=s.width, height=s.height }
            local touchP    = btn:convertToNodeSpaceAR( touchBeginPoint )
            if cc.rectContainsPoint(rect, touchP) and not isMove then
               self:onTouch(btn,ccui.TouchEventType.ended)
            end
            btn:setScale(1.0)
        end

        local listener = cc.EventListenerTouchOneByOne:create()
        listener:setSwallowTouches(false)
        listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
        listener:registerScriptHandler(onTouchMove,cc.Handler.EVENT_TOUCH_MOVED )
        listener:registerScriptHandler(onTouchEnd,cc.Handler.EVENT_TOUCH_ENDED )
        --local eventDispatcher = btn:getEventDispatcher()
        --eventDispatcher:addEventListenerWithSceneGraphPriority(listener, btn)
        
        scrollView:addChild(item['root'])
    end
    --scrollView:scrollToTop(1, true)
    
    
    
    -- ListView
    local list = layout["ListView_1"]
    for i = 0, 10 do
        local item = require("layout.ListItem_0").create()
        item['list_label']:setString("num" .. i)
        local layout = ccui.Layout:create()
        log:info("list view contentsize(%d, %d)", item['panel']:getContentSize().width, item['panel']:getContentSize().height)
        layout:setContentSize(item['panel']:getContentSize())
        layout:addChild(item['root'])
        item['panel']:setPosition(cc.p(0, layout:getContentSize().height))
        list:pushBackCustomItem(layout)
    end
    list:addScrollViewEventListener(handler(self, self.onList))
    
    -- pageview
    local page = layout["PageView_1"]
    for i = 0, 10 do
        local item = require("layout.ListItem_0").create()
        item['list_label']:setString("num" .. i)
        local layout = ccui.Layout:create()
        log:info("page view contentsize(%d, %d)", item['panel']:getContentSize().width, item['panel']:getContentSize().height)
        layout:setContentSize(item['panel']:getContentSize())
        layout:addChild(item['root'])
        item['panel']:setPosition(cc.p(0, layout:getContentSize().height))
        page:addPage(layout)
    end
    
    -- 帧事件
    self.scheduler = scheduler.scheduleGlobal(handler(self, self.onUpdate), 0.01)
end

function TestScene:onList(target, event)
    if event == ccui.ListViewEventType.ONSELECTEDITEM_START then
        self.layout['info_text']:setString(target:getName() .. "选择开始")
    elseif event == ccui.ListViewEventType.ONSELECTEDITEM_END then
        self.layout['info_text']:setString(target:getName() .. "选择结束" .. target:getCurSelectedIndex())
    end
end

function TestScene:onScroll(target, event)
    if event == ccui.ScrollviewEventType.bounceBottom then
        self.layout['info_text']:setString(target:getName() .. "被按下")
    elseif event == ccui.TouchEventType.canceled then
        self.layout['info_text']:setString(target:getName() .. "被取消")
    elseif event == ccui.TouchEventType.ended then
        self.layout['info_text']:setString(target:getName() .. "被结束")
    elseif event == ccui.TouchEventType.moved then
        self.layout['info_text']:setString(target:getName() .. "移动")
    end
end

--------------------------------
-- 处理帧事件
-- @function [parent=#TestScene] onUpdate
function TestScene:onUpdate(dt)
    dt = dt * 1000
	log:debug("on update %d", dt)
	if not self.percent then
	   self.percent = 0
	end
	self.layout["LoadingBar_2"]:setPercent(self.percent)
    self.percent = self.percent + 1
    if self.percent > 100 then
        self.percent = 0;
    end
end

--------------------------------
-- 处理触摸事件
-- @function [parent=#TestScene] onTouch
function TestScene:onTouch(target, event)
    if event == ccui.TouchEventType.began then
        self.layout['info_text']:setString(target:getName() .. "被按下")
    elseif event == ccui.TouchEventType.canceled then
        self.layout['info_text']:setString(target:getName() .. "被取消")
    elseif event == ccui.TouchEventType.ended then
        self.layout['info_text']:setString(target:getName() .. "被结束")
    elseif event == ccui.TouchEventType.moved then
        self.layout['info_text']:setString(target:getName() .. "移动")
    end
    return false
end

--------------------------------
-- 处理点击事件
-- @function [parent=#TestScene] onClick
function TestScene:onClick(target, event)
    if iskindof(target,"ccui.CheckBox") then
        if event == ccui.CheckBoxEventType.selected then
            self.layout['info_text']:setString(target:getName() .. "Selected")
        elseif event == ccui.CheckBoxEventType.unselected then
            self.layout['info_text']:setString(target:getName() .. "UnSelected")
        end
        return
    end
    
    if iskindof(target,"ccui.Slider") and event == ccui.SliderEventType.percentChanged then
        self.layout["LoadingBar_2"]:setPercent(self.layout['Slider_3']:getPercent())
        self.layout['info_text']:setString(target:getName() .. self.layout['Slider_3']:getPercent())
        return
    end
    self.layout['info_text']:setString(target:getName() .. "click")
    
end


--------------------------------
-- 卸载资源
-- @function [parent=#TestScene] onExit
function TestScene:onExit()
    -- 卸载资源
end

return TestScene