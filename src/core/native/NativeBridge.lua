
--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2017/5/13
-- Time: 21:10
-- To change this template use File | Settings | File Templates.
-- NativeBridge 调用Native的连接桥
local NativeBridge = {}

local UserDefaultUtil = require("core.util.UserDefaultUtil")
local RandomUtil = require("core.util.RandomUtil")

--------------------------------
-- NativeBridge 初始化
-- @function [parent=#NativeBridge] init
function NativeBridge.init()
    NativeBridge.platform = cc.Application:getInstance():getTargetPlatform()

	local args = {}
	args.action = "registerScriptHandler"
	args.listener = NativeBridge.callLua

	NativeBridge.callNativeMethod(args)
end

--------------------------------
-- 获取设备Id
-- @function [parent=#NativeBridge] getDeviceId
function NativeBridge.getDeviceId()
	local deviceId = UserDefaultUtil.getStringForKey("game.deviceId", "")
	if deviceId == "" then
		-- FIXME 去获取真实Id
		deviceId = NativeBridge.getFakeDeviceId()
		UserDefaultUtil.setStringForKey("game.deviceId", deviceId)
	end
	return deviceId
end

--------------------------------
-- 获取伪造的deviceId
-- @function [parent=#NativeBridge] getDeviceId
function NativeBridge.getFakeDeviceId()
	return device.platform .. "-" .. RandomUtil:genRandomStr(10)
end

--------------------------------
-- native调用lua的方法
-- @function [parent=#NativeBridge] callLua
function NativeBridge.callLua(jsonStr)
    log:info("native call lua, json:%s", jsonStr)

    -- json decode
	local json  = json.decode(jsonStr)
	
	if json.action == "sdk.init.success" then
		--这里用了c++的事件机制,因为appliaction还没起来
		local e = cc.EventCustom:new("event.sdk.initSuccess")		
		gcc.eventDispatcher:dispatchEvent(e)
	elseif json.action == "sdk.args.ok" then
		sdk.setArgs(json)
	elseif json.action == "sdk.login.success" then
		sdk.login_success(json)
		event.broadcast(event.sdk.loginSuccess)
	elseif json.action == "sdk.login.failed" then
		event.broadcast( event.sdk.loginFailed, language.get("login_sdk_failed") )
	elseif json.action == "sdk.logout" then
		g_login._isAutoLoginSdk = true
		g_login:backToLogin(enum.ui.layer.sdkLogin)
	end
end

--------------------------------
-- lua调用native方法
-- @function [parent=#NativeBridge] callNativeMethod
function NativeBridge.callNativeMethod(args)
    log:info("call native method, action:%s", args.action)
    log:showTable(args)

	if NativeBridge.platform == cc.PLATFORM_OS_ANDROID then
		NativeBridge.callJavaMethod(args)
	elseif NativeBridge.platform == cc.PLATFORM_OS_IPHONE
	    or NativeBridge.platform == cc.PLATFORM_OS_IPAD
	    or NativeBridge.platform == cc.PLATFORM_OS_MAC then
		NativeBridge.callObjectCMethod(args)
	end
end

--------------------------------
-- lua调用object c方法
-- @function [parent=#NativeBridge] callObjectCMethod
function NativeBridge.callObjectCMethod(args)
	local luaoc = require("cocos.cocos2d.luaoc")
	local ok, ret = luaoc.callStaticMethod("LuaBridge", "callObjectCMethod", args)

	if not ok then
        log:info("call object c method failed, code:%s", ret)
	end
end

--------------------------------
-- lua调用java方法
-- @function [parent=#NativeBridge] callJavaMethod
function NativeBridge.callJavaMethod(args)
	local listener = args.listener or 0
	args.listener = nil

    -- decode json
	local str = json.encode(t)
	local luaj = require("cocos.cocos2d.luaj")
	local ok, ret = luaj.callStaticMethod("com/will/LuaBridge", "callJavaMethod", {str, listener}, "(Ljava/lang/String;I)V")

	if not ok then
        log:info("call java method failed, code:%s", ret)
	end
end

return NativeBridge
