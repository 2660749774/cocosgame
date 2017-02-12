--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2017/2/17
-- Time: 16:44
-- To change this template use File | Settings | File Templates.
-- BaseViewModel viewmodel基础类
local BaseViewModel = class("BaseViewModel")
local Binder = import(".Binder")

--------------------------------
-- 类的介绍
-- 1. 发现model，查找model中可以用于监视的对象
-- 2. 绑定属性到view
-- 3. 属性变化自动更新view
--------------------------------

--------------------------------
-- 构造函数
-- @param model BaseModel  model类
-- @function [parent=#BaseViewModel] ctor
function BaseViewModel:ctor(model)
    -- 用于监视的属性
    self.watchProps = {}
    -- 属性变化之后的响应器
    self.listeners = {}

    -- 自省，用于发现model中可以用于监视的属性
    self:initProperty(model.new())

    -- 监视model变化
    model.watch(self)
    
end

--------------------------------
-- 载入数据，子类实现，可以是网络，也可以是本地
-- @function [parent=#BaseViewModel] loadData
function BaseViewModel:loadData()
end

--------------------------------
-- 数据变化回调
-- @param model BaseModel  model类
-- @param key  变化的Key
-- @param oldValue 历史值
-- @param newValue 新值
-- @function [parent=#BaseViewModel] onDataChange
function BaseViewModel:onDataChange(model, key, oldValue, newValue)
    local _key = model._name .. "." .. key
    log:info("onDataChange model:%s, key:%s", model, _key)
    if self.listeners[_key] then
        for _, listener in pairs(self.listeners[_key]) do
            log:info("fireDataChange model:%s, key:%s, listener:%s", model, _key, listener)
            listener(listener, model, oldValue, newValue)
        end
    end
end

function BaseViewModel:onViewChange(key, value)
    local property = self.watchProps[key]
    log:info("onViewChange model:%s, key:%s", property, self.model)
    if property and self.model then
        self.model[property.prop] = value
    end
end

--------------------------------
-- bind View到viewmodel
-- @param view Layout对象 
-- @function [parent=#BaseViewModel] bind
function BaseViewModel:bind(view, props)
    for _, prop in pairs(props) do
        log:info("bind prop:%s, component:%s start", prop, view[prop])
        if view[prop] then
            Binder.bind(view[prop], self)
        end
        log:info("bind prop:%s, component:%s end", prop, view[prop])
    end
end

--------------------------------
-- 移除监听器
-- @param key string 监听器Key
-- @param listener function 监听器
-- @function [parent=#BaseViewModel] bind
function BaseViewModel:removeListener(key, listener)
    log:info("removeListener key:%s, listener:%s", key, listener)

    if self.listeners[key] then
        for index, value in pairs(self.listeners[key]) do
            if value == listener then
                table.remove(self.listeners[key], index)
                if #self.listeners[key] == 0 then
                    self.listeners[key] = nil
                end
                break
            end
        end
    end
end

--------------------------------
-- 自省，用于发现model中可以用于监视的属性
-- @param model BaseModel  model类
-- @function [parent=#BaseViewModel] initProperty
function BaseViewModel:initProperty(model)
    local name = model._name
    for key, value in pairs(model.proxy) do
        if type(key) == "string" then
            if string.find(key, "_") == 1 then
                -- 隐藏属性，忽略
            elseif key == "class" then
                -- class, 忽略
            elseif value and type(value) == "function" then
                -- 函数属性忽略
            else
                name = name .. "." .. key
                self.watchProps[name] = {prop=key}
            end
        end
    end

    log:info("show properties")
    log:showTable(self.watchProps)
end

return BaseViewModel