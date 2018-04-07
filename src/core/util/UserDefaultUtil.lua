--
-- User: wangys
-- UserDefaultUtil UserDefault存储工具类

local UserDefaultUtil = {}

--------------------------------
-- 设置key，value
-- @function [parent=#UserDefaultUtil] setStringForKey
function UserDefaultUtil.setStringForKey(key, value)
    cc.UserDefault:getInstance():setStringForKey(key, value)
    cc.UserDefault:getInstance():flush()
end

--------------------------------
-- 设置key，value
-- @function [parent=#UserDefaultUtil] setIntegerForKey
function UserDefaultUtil.setIntegerForKey(key, value)
    cc.UserDefault:getInstance():setIntegerForKey(key, value)
    cc.UserDefault:getInstance():flush()
end

--------------------------------
-- 设置key，value
-- @function [parent=#UserDefaultUtil] setFloatForKey
function UserDefaultUtil.setFloatForKey(key, value)
    cc.UserDefault:getInstance():setFloatForKey(key, value)
    cc.UserDefault:getInstance():flush()
end

--------------------------------
-- 设置key，value
-- @function [parent=#UserDefaultUtil] setDoubleForKey
function UserDefaultUtil.setDoubleForKey(key, value)
    cc.UserDefault:getInstance():setDoubleForKey(key, value)
    cc.UserDefault:getInstance():flush()
end

--------------------------------
-- 设置key，value
-- @function [parent=#UserDefaultUtil] setBoolForKey
function UserDefaultUtil.setBoolForKey(key, value)
    cc.UserDefault:getInstance():setBoolForKey(key, value)
    cc.UserDefault:getInstance():flush()
end

--------------------------------
-- 获取key，value
-- @function [parent=#UserDefaultUtil] getStringForKey
function UserDefaultUtil.getStringForKey(key, defaultValue)
    return cc.UserDefault:getInstance():getStringForKey(key, defaultValue)
end

--------------------------------
-- 获取key，value
-- @function [parent=#UserDefaultUtil] getDoubleForKey
function UserDefaultUtil.getDoubleForKey(key, defaultValue)
    return cc.UserDefault:getInstance():getDoubleForKey(key, defaultValue)
end

--------------------------------
-- 获取key，value
-- @function [parent=#UserDefaultUtil] getIntegerForKey
function UserDefaultUtil.getIntegerForKey(key, defaultValue)
    return cc.UserDefault:getInstance():getIntegerForKey(key, defaultValue)
end

--------------------------------
-- 获取key，value
-- @function [parent=#UserDefaultUtil] getFloatForKey
function UserDefaultUtil.getFloatForKey(key, defaultValue)
    return cc.UserDefault:getInstance():getFloatForKey(key, defaultValue)
end

--------------------------------
-- 获取key，value
-- @function [parent=#UserDefaultUtil] getBoolForKey
function UserDefaultUtil.getBoolForKey(key, defaultValue)
    return cc.UserDefault:getInstance():getBoolForKey(key, defaultValue)
end



return UserDefaultUtil
