--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/27
-- Time: 16:44
-- To change this template use File | Settings | File Templates.
-- BaseApp App基础类，附带场景切换功能

local BaseApp = class("AppBase")


--------------------------------
-- 构造函数
-- @function [parent=#BaseApp] ctor
function BaseApp:ctor(scenesRoot)
    -- 显示FPS
    if CC_SHOW_FPS then
        cc.Director:getInstance():setDisplayStats(true)
    end

    -- scenesRoot scene的父节点
    self.scenesRoot = scenesRoot

    -- 当前场景
    self.currScene = nil
    self.currSceneName = nil

    -- 上一个场景
    self.lastScene = nil
    self.lastSceneName = nil

    -- 调用onCreate方法
    if self.onCreate then
        self:onCreate()
    end
end


--------------------------------
-- 获取当前场景
-- @function [parent=#BaseApp] getCurrScene
function BaseApp:getCurrScene()
    return self.currScene
end

--------------------------------
-- 获取当前场景名称
-- @function [parent=#BaseApp] getCurrSceneName
function BaseApp:getCurrSceneName()
    return self.currSceneName
end


--------------------------------
-- 切换场景
-- @param string sceneName 场景名称
-- @param table args 参数
-- @param int transition 切换方式
-- @param int time 过渡时间
-- @param object more 更多参数
-- @function [parent=#BaseApp] changeScene
function BaseApp:changeScene(sceneName, args, transition, time, more)
    local scene = self:createScene(sceneName, args, transition, time, more)
    if scene then
        self.lastScene = self.currScene
        self.lastSceneName = self.currSceneName

        self.currScene = scene
        self.currSceneName = sceneName

        -- 显示Scene
        scene:showWithScene(transition, time, more)
        log:info("change scene %s to %s", self.lastSceneName, sceneName)
    end
end


--------------------------------
-- 在当前场景压入一个新的场景
-- @param string sceneName 场景名称
-- @param table args 参数
-- @param int transition 切换方式
-- @param int time 过渡时间
-- @param object more 更多参数
-- @function [parent=#BaseApp] changeScene
function BaseApp:pushScene(sceneName, args, transition, time, more)
    local scene = self:createScene(sceneName, args, transition, time, more)
    if scene then
        self.lastScene = self.currScene
        self.lastSceneName = self.currSceneName

        self.currScene = scene
        self.currSceneName = sceneName

        -- pushScene
        scene:pushWithScene(transition, time, more)
        log:info("push scene %s", sceneName)
    end
end

--------------------------------
-- 移除一个场景
-- @function [parent=#BaseApp] popScene
function BaseApp:popScene()
    self.lastScene, self.currScene = self.currScene, self.lastScene
    self.lastSceneName, self.currSceneName = self.currSceneName, self.lastSceneName

    director:popScene()
    log:info("pop scene %s", self.lastSceneName)
end

--------------------------------
-- 构造函数
-- @param string sceneName 场景名称
-- @param table args 参数
-- @function [parent=#BaseApp] createScene
function BaseApp:createScene(sceneName, args, transition, time, more)
    if sceneName ~= self.currSceneName then
        local packageName = ""
        if string.find(sceneName, "%.") ~= nil then
            packageName = string.format("%s.%sScene", self.scenesRoot, sceneName)
        else
            packageName = string.format("%s.%s.view.%sScene", self.scenesRoot, sceneName, sceneName)
        end
        local status, scene = xpcall(
            function()
                return require(packageName)
            end,
            function(msg)
                if not string.find(msg, string.format("'%s' not found:", packageName)) then
                    print("load view error: ", msg)
                end
            end
        )
        local t = type(scene)
        if status and (t == "table" or t == "userdata") then
            if scene.NeedLoading and self.currSceneName ~= "Loading" then
                -- 需要Loading
                local _args = {scene, sceneName, args, transition, time, more}
                self:changeScene("Loading", _args)
                return nil
            else
                -- 无需Loading
                return scene:create(self, sceneName, checktable(args))
            end
        end
        
        return nil
    else
        log:error("已经在当前场景 %s", self.currScene)
    end
end



return BaseApp
