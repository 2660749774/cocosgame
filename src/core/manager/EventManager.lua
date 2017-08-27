--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/30
-- Time: 11:49
-- To change this template use File | Settings | File Templates.
-- EventManager 时间管理器
local EventManager = class("EventManager")

--------------------------------
-- 构造函数
-- @function [parent=#EventManager] ctor
function EventManager:ctor()
    self.listeners = {}
end

--------------------------------
-- 添加事件监听器
-- @function [parent=#EventManager] addEventListener
function EventManager:addEventListener(eventName, listener)
    -- log:info("[emgr]add event listener name:%s, listeners:%s", eventName, listener)
    eventName = string.upper(tostring(eventName))
    if self.listeners[eventName] == nil then
        self.listeners[eventName] = {}
    end

    table.insert(self.listeners[eventName], listener)
end

--------------------------------
-- 派发事件
-- @function [parent=#EventManager] dispatchEvent
function EventManager:dispatchEvent(eventName, data)
    eventName = string.upper(tostring(eventName))
    -- log:info("[emgr]dispath event name:%s, listeners:%s", eventName, self.listeners[eventName])
    if self.listeners[eventName] == nil then
        return
    end

    for _, listener in pairs(self.listeners[eventName]) do
        listener(data)
    end
end

--------------------------------
-- 移除事件监听
-- @function [parent=#EventManager] removeEventListener
function EventManager:removeEventListener(eventName, listener)
    -- log:info("[emgr]remove event listener name:%s, listeners:%s", eventName, listener)
    eventName = string.upper(tostring(eventName))
    if self.listeners[eventName] == nil then
        return
    end

    for id, _listener in pairs(self.listeners[eventName]) do
        if _listener == listener then
            table.remove(self.listeners[eventName], id)
            return
        end
    end
end



return EventManager
