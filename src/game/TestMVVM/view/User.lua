--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- User MVVM用户
local BaseModel = require("core.mvvm.BaseModel")
local User = class("User", BaseModel)

--------------------------------
-- 创建方法
-- @function [parent=#TestMVVMScene] onCreate
function User:ctor()
    BaseModel.ctor(self, "user")

    self.name = "will123"   
    self.callback = function()
        log:info("callback")
    end 
    self.fullName = function()
        return "hello world " .. self.name
    end
    self:addComputedProperty("fullName", self.fullName, "name")
end

return User

