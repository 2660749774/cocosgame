local Button = ccui.Button

local longPressCheckInterval = 0.1

--------------------------------
-- 构造函数
-- @function [parent=#Button] onTouch
function Button.onTouch(target, event)
    if event == ccui.TouchEventType.began then
        if target.playSoundEffect ~= false then
            amgr:playEffect("click_btn2.wav")
        end
        target:setScale(1.2)

        -- 处理长按事件
        if target.longPressListener then
            target.tick = 0
            target.ended = false
            target.longPress = false
            target.longPressTrigger = false
            target.scheduler = scheduler.scheduleGlobal(handler(target, target.onLongPress), longPressCheckInterval)
        end
    elseif event == ccui.TouchEventType.canceled or event == ccui.TouchEventType.ended then
        target:setScale(1)

        -- 判断是否触发点击事件
        if event == ccui.TouchEventType.ended and not target.longPress and target.clickEventListener then
            target.clickEventListener({target=target, type="click"})
        end
        
        -- 结束点击，取消长按监听器
        if target.scheduler then
            if target.longPress then
                target.longPressListener({target=target, type="longPress", longPress=false})
            end
            target.ended = true
            target.longPress = false
            scheduler.unscheduleGlobal(target.scheduler)
        end
    end
end

--------------------------------
-- 处理长按事件
-- @function [parent=#Button] onLongPress
function Button:onLongPress()
    if not self.ended and self.longPressListener then
        self.tick = self.tick + longPressCheckInterval
        if self.tick >= self.longPressInterval then
            self.longPress = true
            self.longPressListener({target=self, type="longPress", longPress=true})
        end
    end
end


--------------------------------
-- 添加长按监听事件
-- @function [parent=#Button] addLongPressEventListener
function Button:addLongPressEventListener(listener, interval)
    interval = interval or 1
    self.longPressListener = listener
    self.longPressInterval = interval
end

--------------------------------
-- 添加长按监听事件
-- @function [parent=#Button] addLongPressEventListener
function Button:addClickEventListener(listener)
    self.clickEventListener = listener
end