--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2016/6/4
-- Time: 13:09
-- To change this template use File | Settings | File Templates.
-- HotswapScene 动更场景
local HotswapScene = class("HotswapScene", BaseScene)


--------------------------------
-- 创建方法
-- @function [parent=#HotswapScene] onCreate
function HotswapScene:onCreate()
    local layout = require("layout.TetrisHotswap").create()
    self:fixLayout(layout)
    self.lbTips = layout['lb_tips']
    self.progress = layout['progress']
    self.progress:loadSlidBallTextureNormal('', 0)
    self.progress:loadSlidBallTexturePressed('', 0)
    self.progress:loadSlidBallTextureDisabled('', 0)
    self.progress:setPercent(0)
    self.progress:setVisible(false)

    -- 添加触摸监听
    self:addLayerTouchListener()  

    -- 重试计数器
    self.retryCount = 0

    self:addObject(layout["root"], "scene")

    -- 动更controller
    self.hotswap = require("game.Hotswap.HotSwapController").new(self, confmgr)
    self.hotswap:start()
end

--------------------------------
-- 添加触摸监听
-- @function [parent=#HotswapScene] addLayerTouchListener
function HotswapScene:addLayerTouchListener()
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
-- @function [parent=#HotswapScene] onTouch
function HotswapScene:onTouch()
    if self.needReconnect then
        self.needReconnect = false
    end
end

--------------------------------
-- 更新tips
-- @function [parent=#HotswapScene] updateTips
function HotswapScene:updateTips(tips)
    self.lbTips:setString(tips)
end

--------------------------------
-- 弹出提示更新的对话框
-- @function [parent=#HotswapScene] showUpdatePopup
function HotswapScene:showUpdatePopup(tips, fileSize, callback)
    local msg = string.format("检查到有新的版本，点击更新。\n本次更新大小：%s", fileSize)
    self:pushPanel("Hotswap.view.HotswapTips", { msg, callback })
end

--------------------------------
-- 弹出提示客户段更新的对话框
-- @function [parent=#HotswapScene] showUpdatePopup
function HotswapScene:showClientUpdatePopup(callback)
    local msg = string.format("您的客户端版本过低\n请前往更新最新版本！")
    self:pushPanel("Hotswap.view.HotswapTips", { msg, callback })
end

--------------------------------
-- 更新进度
-- @function [parent=#HotswapScene] updateProgress
function HotswapScene:updateProgress(progress)
    self.progress:setVisible(true)
    self.progress:setPercent(math.ceil(progress * 100))
end

--------------------------------
-- 隐藏进度条
-- @function [parent=#HotswapScene] hidenProgress
function HotswapScene:hidenProgress()
    self.progress:setVisible(false)
end

--------------------------------
-- 获取设备类型
-- @function [parent=#HotswapScene] updateTips
function HotswapScene:getDeviceType()
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
-- @function [parent=#HotswapScene] onExit
function HotswapScene:onExit()
    -- 卸载资源
end


return HotswapScene

