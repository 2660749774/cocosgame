--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/27
-- Time: 16:44
-- To change this template use File | Settings | File Templates.
-- BaseView 表示一个显示界面

local BaseView = class("BaseView", cc.Node)

--------------------------------
-- 构造函数
-- @function [parent=#BaseView] ctor
-- @param string name View名称
function BaseView:ctor(name, args)
    self:enableNodeEvents()
    self.name = name
    self.args = args or {}

    -- 调用init方法
    self:init()

   
    -- 调用onCreate方法
    if self.onCreate then
        self:onCreate(unpack(self.args))
    end
end


--------------------------------
-- 获取View名称
-- @function [parent=#BaseView] getName
function BaseView:getName()
    return self.name
end

--------------------------------
-- 添加Layout
-- @function [parent=#BaseView] addLayout
function BaseView:addLayout(layout)
    self:fixLayout(layout)

    self:addChild(layout['root'])
end 

--------------------------------
-- 修正Layout布局
-- @param layout obj layout对象
-- @function [parent=#BaseView] fixLayout
function BaseView:fixLayout(layout)
    local panel = layout["panel"]
    if panel then
        panel:setAnchorPoint(0.5, 0.5)
        panel:setPosition(display.cx, display.cy)
    end
end

--------------------------------
-- 设置递归设置透明度
-- @function [parent=#BaseView] setCascadeOpacityEnabled
function BaseView:setCascadeOpacityEnabled(value)
     local childs = self:getChildren()
     for _, child in pairs(childs) do
        child:setCascadeOpacityEnabled(value)
     end
end

--------------------------------
-- 设置递归设置透明度
-- @function [parent=#BaseView] setOpacity
function BaseView:setOpacity(value)
     local childs = self:getChildren()
     for _, child in pairs(childs) do
        child:setOpacity(value)
     end
end

--------------------------------
-- 运行动画
-- @function [parent=#BaseView] runAction
function BaseView:runAction(action, callback)
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
-- 资源清理
-- 传入一个<br/>
-- {
--   {type="plist", key="res.plist"},
--   {type="image", key="ui.png"}
--   ... ...
-- }<br/>
-- 支持的type有["plist", "plist_group", "image", "armature", "armature_group", "animation"]
-- @function [parent=#BaseView] cleanResources
function BaseView:cleanResources(resources)
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

return BaseView

