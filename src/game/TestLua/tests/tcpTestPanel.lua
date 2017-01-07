
--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TestLuaScene 测试场景
-- local BaseTestScene = require("game.TestLua.tests.BaseTestScene")
local tcpTestPanel = class("tcpTestPanel", BasePanel)

local action = {
    createUser = {"user@createUser", "userName=%s&password=%s"}
}

function tcpTestPanel:onCreate()
    self.host = "127.0.0.1"
    self.port = 8010
    self.label = cc.Label:createWithSystemFont(string.format("正在连接服务器 host:%s, port:%s", self.host, self.port), "Arial",12)
    self.label:setPosition(cc.p(display.cx, display.cy))
    self:addChild(self.label)

    cmgr:open(self.host, self.port)

    local callback = handler(self, self.onCreateUser)
    scheduler.performWithDelayGlobal(function() 
        cmgr:send(action.createUser, callback, "w1", "123")
    end, 2)
    
end


function tcpTestPanel:onCreateUser(data)
    self.label:setString(string.format("response state:%s, msg:%s", data.state, data.msg))
end

return tcpTestPanel
