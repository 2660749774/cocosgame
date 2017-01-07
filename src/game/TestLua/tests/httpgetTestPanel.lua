
--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TestLuaScene 测试场景
-- local BaseTestScene = require("game.TestLua.tests.BaseTestScene")
local httpgetTestPanel = class("httpgetTestPanel", BasePanel)

function httpgetTestPanel:onCreate()
    local url = "http://forum.cocos.com/t/quick-touch/37565"
    self.label = cc.Label:createWithSystemFont("正在发送网络请求:" .. url, "Arial",12)
    self.label:setPosition(cc.p(display.cx, display.cy))
    self:addChild(self.label)

    net.WebUtil.sendRequestWithData(url, handler(self, self.onResponse), {["qq"]="sdf", ["tx"]="sdf"})
end

function httpgetTestPanel:onResponse(event)
    if tolua.isnull(self) then
        return
    end
 
    if event.state > cc.HTTP.StateServerError then
        -- 请求失败，显示错误代码和错误消息
        self.label:setString("请求失败, code:" .. tostring(request:getErrorCode()) .. ", message:" .. tostring(request:getErrorMessage()))
        return
    end
    
    if event.state == cc.HTTP.StateServerError then
        -- 请求结束，但没有返回 200 响应代码
        self.label:setString("服务器返回错误, responseCode:" .. tostring(event.responseCode))
        return
    end

    if event.state == cc.HTTP.StateCompleted then
        -- 请求成功，显示服务端返回的内容
        self.label:setString(event.data)
    end
 
    
end

return httpgetTestPanel
