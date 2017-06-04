-- Date: 2016/6/4
-- Time: 13:09
-- To change this template use File | Settings | File Templates.
-- ConfigManager 配置管理器
local ConfigManager = class("ConfigManager")

--------------------------------
-- 构造函数
-- @function [parent=#ConfigManager] ctor
function ConfigManager:ctor(channelId)
    self.channelId = channelId
    self.platform = device.platform

    -- 读取配置文件
    self:loadConfig()
end

--------------------------------
-- 读取配置文件
-- @function [parent=#ConfigManager] loadConfig
function ConfigManager:loadConfig()
    if self.platform == "windows" or self.platform == "mac" then
        -- windows or mac
        self.config = require("config.WinConfig")
    else
        -- mobile
        self.config = require("config.MobConfig")
    end
end

--------------------------------
-- 获取登录服务器配置
-- @function [parent=#ConfigManager] getLoginServer
function ConfigManager:getLoginServer()
    return self.config.loginHost, self.config.loginPort
end

return ConfigManager
