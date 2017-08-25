
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
local targetPlatform = nil
local deviceInfo = nil
local deviceId = nil

--------------------------------
-- NativeBridge 初始化
-- @function [parent=#NativeBridge] init
function NativeBridge.init()
	log:info("[native]init")
    NativeBridge.platform = cc.Application:getInstance():getTargetPlatform()

	-- 注册自身
	local args = {}
	args.action = "registerScriptHandler"
	args.listener = NativeBridge.callLua
	args.host = "www.baidu.com"
	NativeBridge.callNativeMethod(args)
	
	targetPlatform = cc.Application:getInstance():getTargetPlatform()
	log:info("targetPlatform:%s", targetPlatform)

	-- 主动调用
	NativeBridge.getDeviceId()
	NativeBridge.getDeviceInfo()
end

--------------------------------
-- 获取设备Id
-- @function [parent=#NativeBridge] getDeviceId
function NativeBridge.getDeviceId()
	if deviceId ~= nil then
		return deviceId
	end
	
	deviceId = UserDefaultUtil.getStringForKey("game.deviceId", "")
	if deviceId == "" then
		if targetPlatform == cc.PLATFORM_OS_ANDROID 
			or targetPlatform == cc.PLATFORM_OS_IPHONE
			or targetPlatform == cc.PLATFORM_OS_IPAD then
			-- ios、android平台
			local args = {
				action = "getDeviceId"
			}
			deviceId = NativeBridge.callNativeMethodWithReturn(args)
			UserDefaultUtil.setStringForKey("game.deviceId", deviceId)
		else
			-- FIXME 去获取真实Id
			deviceId = NativeBridge.getFakeDeviceId()
			UserDefaultUtil.setStringForKey("game.deviceId", deviceId)
		end
	end
	log:info("deviceId:%s", deviceId)
	return deviceId
end

--------------------------------
-- 获取设备信息
-- @function [parent=#NativeBridge] getDeviceInfo
function NativeBridge.getDeviceInfo()
	if deviceInfo ~= nil then
		return deviceInfo
	end

	if targetPlatform == cc.PLATFORM_OS_ANDROID 
			or targetPlatform == cc.PLATFORM_OS_IPHONE
			or targetPlatform == cc.PLATFORM_OS_IPAD then
			-- ios、android平台
			local args = {
				action = "getDeviceInfo"
			}
			local _deviceInfo = NativeBridge.callNativeMethodWithReturn(args)
			if _deviceInfo ~= nil and deviceInfo ~= "" then
				deviceInfo = json.decode(_deviceInfo)
			end
	else
		deviceInfo = {}
	end

	log:info("deviceInfo:")
	log:showTable(deviceInfo)
	return deviceInfo
end

--------------------------------
-- 获取网络信息
-- @function [parent=#NativeBridge] getNetworkName
function NativeBridge.getNetworkName()
	local networkName = "unknow"
	if targetPlatform == cc.PLATFORM_OS_ANDROID 
			or targetPlatform == cc.PLATFORM_OS_IPHONE
			or targetPlatform == cc.PLATFORM_OS_IPAD then
			-- ios、android平台
			local args = {
				action = "getNetworkName"
			}
			networkName = NativeBridge.callNativeMethodWithReturn(args)
	end
	log:info("networkName:%s", networkName)
	return networkName
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
	elseif json.action == "enterBackground"
		or json.action == "enterForeground"
		or json.action == "becomeActive"
		or json.action == "resignActive" 
		or json.action == "memoryWarning"
		or json.action == "networkChanged" then
		emgr:dispatchEvent(EventDefine.APP_STATE_CHANGE, json.action)
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
-- lua调用native方法，带返回值
-- @function [parent=#NativeBridge] callNativeMethodWithReturn
function NativeBridge.callNativeMethodWithReturn(args)
	log:info("call native method with return, action:%s", args.action)
    log:showTable(args)

	if NativeBridge.platform == cc.PLATFORM_OS_ANDROID then
		return NativeBridge.callJavaMethodWithReturn(args)
	elseif NativeBridge.platform == cc.PLATFORM_OS_IPHONE
	    or NativeBridge.platform == cc.PLATFORM_OS_IPAD
	    or NativeBridge.platform == cc.PLATFORM_OS_MAC then
		return NativeBridge.callObjectCMethodWithReturn(args)
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
-- lua调用object c方法，带返回值
-- @function [parent=#NativeBridge] callObjectCMethod
function NativeBridge.callObjectCMethodWithReturn(args)
	local luaoc = require("cocos.cocos2d.luaoc")
	local ok, ret = luaoc.callStaticMethod("LuaBridge", "callObjectCMethodWithReturn", args)

	if not ok then
        log:info("call object c method failed, code:%s", ret)
		return ""
	end
	return ret
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

--------------------------------
-- lua调用java方法，带返回值
-- @function [parent=#NativeBridge] callJavaMethodWithReturn
function NativeBridge.callJavaMethodWithReturn(args)
	local listener = args.listener or 0
	args.listener = nil

    -- decode json
	local str = json.encode(t)
	local luaj = require("cocos.cocos2d.luaj")
	local ok, ret = luaj.callStaticMethod("com/will/LuaBridge", "callJavaMethodWithReturn", {str}, "(Ljava/lang/String;)Ljava/lang/String;")

	if not ok then
        log:info("call java method failed, code:%s", ret)
		return ""
	end
	return ret
end

return NativeBridge
