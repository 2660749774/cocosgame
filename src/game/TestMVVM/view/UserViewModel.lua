--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- User MVVM用户
local BaseViewModel = require("core.mvvm.BaseViewModel")
local User = import(".User")
local UserViewModel = class("UserViewModel", BaseViewModel)

--------------------------------
-- 创建方法
-- @function [parent=#TestMVVMScene] onCreate
function UserViewModel:ctor()
    BaseViewModel.ctor(self, User)
end

function UserViewModel:loadData()
    self.model = User.new()
end


return UserViewModel

