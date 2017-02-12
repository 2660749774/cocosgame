--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2017/2/17
-- Time: 16:44
-- To change this template use File | Settings | File Templates.
-- Binder 绑定帮助类
local Binder = {}

local function addListener(vm, key, func)
    if vm.listeners[key] == nil then
        vm.listeners[key] = {}
    end
    table.insert(vm.listeners[key], func)
    log:info("addListener %s", func)
end

local function getBindKey(vm, value)
    local key, subN = string.gsub(value, "^${(.*)}$", "%1")
    log:info("getBindKey %s", key)
    if subN > 0 and vm.watchProps[key] ~= nil then
        return key
    end
    return nil
end

local function bindText(component, vm)
    local key = getBindKey(vm, component:getString())
    if nil ~= key then
        addListener(vm, key, function(listener, model, oldValue, newValue)
            component:setString(newValue)
        end)
    end
end

local function bindEditBox(component, vm)
    local key = getBindKey(vm, component:getText())

    if nil ~= key then
        component:registerScriptEditBoxHandler(function(event) 
            if event == "changed" then
                log:info("handle EditBox event %s, value %s", event, component:getText())
                vm:onViewChange(key, component:getText())
            end
        end)

        addListener(vm, key, function(listener, model, oldValue, newValue)
            component:setText(newValue)
            vm:removeListener(key, listener)
        end)
    end
end

function Binder.bind(component, vm)
    if component == nil then
        return
    end

    local componentType = tolua.type(component)
    log:info("componentType:%s", componentType)
    if componentType == "ccui.Text" then
        bindText(component, vm)
    elseif componentType == "ccui.EditBox" then
        bindEditBox(component, vm)
    end 
end


return Binder