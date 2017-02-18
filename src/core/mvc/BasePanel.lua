--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/27
-- Time: 16:44
-- To change this template use File | Settings | File Templates.
-- BasePanel 表示一个面板

local BasePanel = class("BasePanel", cc.Node)

--------------------------------
-- 构造函数
-- @function [parent=#BasePanel] ctor
-- @param Scene scene 场景
-- @param string name View名称
function BasePanel:ctor(scene, name, args)
    self:enableNodeEvents()
    self.scene = scene
    self.name = name
    self.args = args
    self.disableTransition = false

    -- 调用init方法
    self:init()

   
    -- 调用onCreate方法
    if self.onCreate then
        self:onCreate(unpack(args))
    end
end


--------------------------------
-- 获取View名称
-- @function [parent=#BasePanel] getName
function BasePanel:getName()
    return self.name
end

--------------------------------
-- 获取View名称
-- @function [parent=#BasePanel] getName
function BasePanel:getScene()
    return self.scene
end


--------------------------------
-- 显示出来
-- @function [parent=#BasePanel] show
function BasePanel:show(layerName)
    self:setVisible(true)
    self.scene:addObject(self, layerName)
end

--------------------------------
-- 显示出来
-- @function [parent=#BasePanel] showWithUI
function BasePanel:showWithUI()
    log:info("showWithUI %s %s", self.name, self.scene:getName())
    self:setVisible(true)
    self.scene:addObject(self, "ui")
end

--------------------------------
-- 设置根panel
-- @function [parent=#BasePanel] setRootPanel
function BasePanel:setRootPanel(panel)
    self.rootPanel = panel
end 

--------------------------------
-- 添加Layout
-- @function [parent=#BasePanel] addLayout
function BasePanel:addLayout(layout)
    self:fixLayout(layout)

    self.rootPanel = layout['panel']
    local mask = maskLayout['root']
    mask:addChild(layout['root'])
    self:addChild(mask)
end 

--------------------------------
-- 添加Layout, 包括模态
-- @function [parent=#BasePanel] setVisible
function BasePanel:addLayoutWithMask(layout, maskLayout)
    local maskLayout = require(maskLayout).create()
    self:fixLayout(maskLayout)
    self:fixLayout(layout)

    self.rootPanel = layout['panel']
    local mask = maskLayout['root']
    mask:addChild(layout['root'])
    self:addChild(mask)
end

--------------------------------
-- 修正Layout布局
-- @param layout obj layout对象
-- @function [parent=#BasePanel] fixLayout
function BasePanel:fixLayout(layout)
    local panel = layout["panel"]
    if panel then
        panel:setAnchorPoint(0.5, 0.5)
        panel:setPosition(display.cx, display.cy)
    end
end

--------------------------------
-- 设置递归设置透明度
-- @function [parent=#BasePanel] setCascadeOpacityEnabled
function BasePanel:setCascadeOpacityEnabled(value)
     local childs = self:getChildren()
     for _, child in pairs(childs) do
        child:setCascadeOpacityEnabled(value)
     end
end

--------------------------------
-- 设置递归设置透明度
-- @function [parent=#BasePanel] setOpacity
function BasePanel:setOpacity(value)
     local childs = self:getChildren()
     for _, child in pairs(childs) do
        child:setOpacity(value)
     end
end

--------------------------------
-- 运行动画
-- @function [parent=#BasePanel] runAction
function BasePanel:runAction(action, callback)
     local childs = self:getChildren()
     local childNum = #childs
     local callbackNum = 0
     local _callback = function()
        callbackNum = callbackNum + 1
        if callback and (callbackNum == childNum) then
            callback()
        end
     end
     for _, child in pairs(childs) do
        local _action = cc.Sequence:create(action:clone(), cc.CallFunc:create(_callback))
        child:runAction(_action)
     end
end

--------------------------------
-- 运行打开特效
-- @function [parent=#BasePanel] runOpenTransition
function BasePanel:runOpenTransition()
    if self.rootPanel and not self.disableTransition then
        self.rootPanel:setScale(0.5)
        local action = cc.EaseQuinticActionOut:create(cc.ScaleBy:create(0.5, 2, 2))
        self.rootPanel:runAction(action)
    end
end

--------------------------------
-- 运行关闭特效
-- @function [parent=#BasePanel] runCloseTransition
function BasePanel:runCloseTransition(callback)
    if self.rootPanel and not self.disableTransition then
        local baseAction = cc.EaseQuinticActionIn:create(cc.ScaleBy:create(0.5, 0, 0))
        if callback then
            local action = cc.Sequence:create(baseAction, cc.CallFunc:create(callback))
            self.rootPanel:runAction(action)
        else
            local action = cc.EaseQuinticActionIn:create(baseAction)
            self.rootPanel:runAction(action)
        end
    else
        if callback then
            callback()
        end
    end
end


--------------------------------
-- 资源清理
-- 传入一个<br/>
-- {
--   {type="plist", key="res.plist"},
--   {type="image", key="ui.png"}
--   ... ...
-- }<br/>
-- 支持的type有["plist", "plist_group", "image", "armature", "armature_group", "animation"]
-- @function [parent=#BasePanel] cleanResources
function BasePanel:cleanResources(resources)
    for _, res in pairs(resources) do
        if res.type == "plist_group" then
            rmgr:removeSpriteFramesByGroup(res.key)
        elseif res.type == "plist" then
            rmgr:removeSpriteFrames(res.key)
        elseif res.type == "image" then
            rmgr:removeTexture(res.key)
        elseif res.type == "armature" then
            rmgr:removeArmature(res.key)
        elseif res.type == "armature_group" then
            rmgr:removeArmatureByGroup(res.key)
        elseif res.type == "animation" then
            rmgr:removeAnimation(res.key)
        else
            log:warn("clean fail, unknow resource type %s key %s", res.type, res.key)
        end
    end
    rmgr:removeUnusedTextures()
end

return BasePanel

