--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2017/2/17
-- Time: 16:44
-- To change this template use File | Settings | File Templates.
-- BaseModel model基础类
local BaseModel = class("BaseModel")

-- 模型的变化监听器
BaseModel._watchers = {}


--------------------------------
-- 类的介绍
-- 1. 属性值发生变化会通知指定监听器
-- 2. 以下划线开头的属性为隐藏属性，不会变监听变化
-- 3. 函数属性不会被监听变化
--------------------------------

--------------------------------
-- 构造函数
-- @param name string 模型名称
-- @function [parent=#BaseModel] ctor
function BaseModel:ctor(name)
    self.proxy = {} -- 代理类，用于存储真正变化
    self.proxy._name = name
    
    -- 访问节点
    local metatable = {}
    metatable.__newindex = function(model, key, value)
        local oldValue = self.proxy[key]
        self.proxy[key] = value

        -- 如果是监视属性，通知监视器变化
        for _, watcher in pairs(BaseModel._watchers ) do
            watcher:onDataChange(model, key, oldValue, value)
        end
    end
    metatable.__index = function(model, key)
        return self.proxy[key]
    end
    setmetatable(self, metatable)
end

--------------------------------
-- 添加监听器
-- @param watcher function 监听器
-- @function [parent=#BaseModel] watch
function BaseModel.watch(watcher)
    table.insert(BaseModel._watchers , watcher)
end

--------------------------------
-- 移除监听器
-- @param watcher function 监听器
-- @function [parent=#BaseModel] unwatch
function BaseModel.unwatch(watcher)
    for index, value in pairs(BaseModel._watchers ) do
        if value == watcher then
            table.remove(BaseModel._watchers , index)
            return
        end
    end
end

return BaseModel