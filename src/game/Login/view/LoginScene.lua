--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2016/6/4
-- Time: 13:09
-- To change this template use File | Settings | File Templates.
-- LoginScene 登录场景
local LoginScene = class("LoginScene", BaseScene)


--------------------------------
-- 创建方法
-- @function [parent=#LoginScene] onCreate
function LoginScene:onCreate()
    local layout = require("layout.TetrisLogin").create()
    self:fixLayout(layout)
    self.lbTips = layout['lb_tips']

    self.host, self.port = confmgr:getLoginServer()

    -- 添加触摸监听
    self:addLayerTouchListener()

    -- 连接服务器
    self:connectServer()    

    -- 重试计数器
    self.retryCount = 0

    self:addObject(layout["root"], "scene")
end

--------------------------------
-- 连接服务器
-- @function [parent=#LoginScene] connectServer
function LoginScene:connectServer()
    log:info("login server host:%s, port:%s", self.host, self.port)
    self:updateTips("正在连接登录服务器...")

    self.connectHandler = handler(self, self.onConnectCallback)
    cmgr:addConnCallback(self.connectHandler)
    cmgr:open(self.host, self.port)
end

--------------------------------
-- 处理Tcp连接
-- @function [parent=#LoginScene] connectServer
function LoginScene:onConnectCallback(event)
    if event.type ~= "conn" then
        return
    end

    log:info("onConnectCallback, type:%s, event:%s", event.type, event.status)
    self.retryCount = self.retryCount + 1
    if event.type == "conn" and event.status == "succ" then
        -- 连接成功
        self:updateTips("连接登录服务器成功")
        cmgr:removeConnCallback(self.connectHandler)
        self.retryCount = 0

        -- 登录
        self:login()
    elseif event.type == "conn" and event.status == "fail" then
        if self.retryCount > 3 then
            app:changeScene("Tetris")
        else
            -- 连接失败
            self:updateTips("连接登录服务器失败，点击屏幕重试！")
            self.needReconnect = true
            cmgr:removeConnCallback(self.connectHandler)
        end
    end
end

--------------------------------
-- 进行登录
-- @function [parent=#LoginScene] login
function LoginScene:login()
    self:updateTips("正在获取角色信息...")
    local deviceInfo = nativeBridge.getDeviceId()
    local deviceType = self:getDeviceType()
    local yx = "will"
    local yxSource = "will"
    local uuid = ""
    log:info("deviceInfo:%s", deviceInfo)
    cmgr:send(actions.login, handler(self, self.onLoginCallback), deviceInfo, deviceType, yx, yxSource, uuid)
end

--------------------------------
-- 登录结果处理
-- @function [parent=#LoginScene] onLoginCallback
function LoginScene:onLoginCallback(response)
    cmgr:send(actions.createPlayer, function(response) 
        -- 登录成功
        cmgr:send(actions.getPlayerInfo, handler(self, self.onGetPlayerInfo))
    end)
end

--------------------------------
-- 获取用户信息成功
-- @function [parent=#LoginScene] onLoginCallback
function LoginScene:onGetPlayerInfo(response)
    log:info("playerInfo")
    log:showTable(response)

    -- 存储
    mmgr.player = require("game.Common.model.Player").new()
    mmgr.player:update(response.data)

    self:updateTips("获取角色信息成功")

    scheduler.performWithDelayGlobal(function() 
        -- 切换场景
        app:changeScene("Tetris")
    end, 0.5)

    
end

--------------------------------
-- 添加触摸监听
-- @function [parent=#LoginScene] addLayerTouchListener
function LoginScene:addLayerTouchListener()
    local listener = cc.EventListenerTouchOneByOne:create()
    -- 开始触摸
    listener:registerScriptHandler(function(touch, event) 
        self:onTouch()
    end, cc.Handler.EVENT_TOUCH_BEGAN)

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
end

--------------------------------
-- 触发触摸
-- @function [parent=#LoginScene] onTouch
function LoginScene:onTouch()
    if self.needReconnect then
        self.needReconnect = false
        self:connectServer()
    end
end

--------------------------------
-- 更新tips
-- @function [parent=#LoginScene] updateTips
function LoginScene:updateTips(tips)
    self.lbTips:setString(tips)
end

--------------------------------
-- 获取设备类型
-- @function [parent=#LoginScene] updateTips
function LoginScene:getDeviceType()
    if device.platform == "ios" then
        return 1
    elseif device.platform == "android" then
        return 2
    elseif device.platform == "mac" then
        return 3
    else
        return 4
    end
end


--------------------------------
-- 卸载资源
-- @function [parent=#LoginScene] onExit
function LoginScene:onExit()
-- 卸载资源
end


return LoginScene

