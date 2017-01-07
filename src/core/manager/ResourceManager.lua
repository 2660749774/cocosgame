--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/29
-- Time: 11:15
-- To change this template use File | Settings | File Templates.
-- ResourceManager 资源管理器，管理资源的加载与卸载
local ResourceManager = class("ResourceManager")

--------------------------------
-- 构造函数
-- @function [parent=#ResourceManager] ctor
function ResourceManager:ctor()
    -- 资源分组
    self.groups = {}
    self.resFiles = {}

    -- 动画组
    self.animGroups = {}

    -- 各种缓存
    self.textureCache = director:getTextureCache() -- 纹理缓存
    self.spriteFrameCache = cc.SpriteFrameCache:getInstance() -- plist缓存
    self.animationCache = cc.AnimationCache:getInstance() -- 动画缓存
    self.armatureManager = ccs.ArmatureDataManager:getInstance() -- 骨骼缓存
    log:info("init rmgr succ")
end

--------------------------------
-- 加载打包资源
-- @param string plist plist文件
-- @param string group 资源组
-- @function [parent=#ResourceManager] addAnimation
function ResourceManager:addAnimation(name, animation)
    log:info("add animation %s", name)
    self.animationCache:addAnimation(animation, name)
end


--------------------------------
-- 移除指定纹理
-- @function [parent=#ResourceManager] removeAnimation
function ResourceManager:removeAnimation(name)
    log:info("remove animation %s", name)
    return self.animationCache:removeAnimation(name)
end


--------------------------------
-- 加载动画
-- @param string fileName 文件名
-- @param string group 动画组
-- @function [parent=#ResourceManager] loadArmature
function ResourceManager:loadArmature(fileName, group)
    log:info("load armature %s", fileName)
    if group then
        self.animGroups[group] = self.animGroups[group] or {}
        table.insert(self.animGroups[group], fileName)
    end
    self.armatureManager:addArmatureFileInfo(fileName)
end

--------------------------------
-- 异步加载动画
-- @param string fileName 文件名
-- @param function callback 加载完成之后回调函数
-- @param string group 动画组
-- @function [parent=#ResourceManager] loadArmatureAsync
function ResourceManager:loadArmatureAsync(fileName, callback, group)
    log:info("load armature %s async", fileName)
    if group then
        self.animGroups[group] = self.animGroups[group] or {}
        table.insert(self.animGroups[group], fileName)
    end
    self.armatureManager:addArmatureFileInfoAsync(fileName, callback)
end

--------------------------------
-- 卸载动画资源
-- @param string group 动画组
-- @function [parent=#ResourceManager] removeArmature
function ResourceManager:removeArmature(fileName)
    log:info("remove armature %s", file)
    self.armatureManager:removeArmatureFileInfo(file)    
end

--------------------------------
-- 卸载动画资源
-- @param string group 动画组
-- @function [parent=#ResourceManager] removeArmatureByGroup
function ResourceManager:removeArmatureByGroup(group)
    log:info("remove armature by group %s", group)
    local resGroup = self.animGroups[group]
    if resGroup then
        for _, file in pairs(resGroup) do
            self:removeArmature(file)
        end
        self.animGroups[group]= nil
    end
end

--------------------------------
-- 加载打包资源
-- @param string plist plist文件
-- @param string group 资源组
-- @function [parent=#ResourceManager] loadTexture
function ResourceManager:loadTexture(filepath)
    log:info("load texture %s", filepath)
    self.textureCache:addImage(filepath)
end

--------------------------------
-- 移除指定纹理
-- @function [parent=#ResourceManager] removeTexture
function ResourceManager:removeTexture(filepath)
    log:info("remove texture %s", filepath)
    return self.textureCache:removeTextureForKey(filepath)
end

--------------------------------
-- 加载打包资源
-- @param string plist plist文件
-- @param string group 资源组
-- @function [parent=#ResourceManager] loadSpriteFrame
function ResourceManager:loadSpriteFrames(plist, group)
    log:info("load spriteFrame %s", plist)
    self.spriteFrameCache:addSpriteFrames(plist)
    if group and not self:isInGroup(plist, group) then
        self.resFiles[plist] = self.resFiles[plist] or 0
        self.resFiles[plist] = self.resFiles[plist] + 1
        self:addToGroup(plist, group)
    end
end

--------------------------------
-- 卸载打包资源
-- @param string plist plist文件
-- @param string group 资源组
-- @function [parent=#ResourceManager] removeSpriteFrame
function ResourceManager:removeSpriteFrames(plist)
    if self.resFiles[plist] then
        self.resFiles[plist] = self.resFiles[plist] - 1
        if self.resFiles[plist] <= 0 then
            -- 引用计数为0
            log:info("remove spriteFrame %s", plist)
            self.spriteFrameCache:removeSpriteFramesFromFile(plist)
            return true
        end
    else
        log:info("remove spriteFrame %s", plist)
        self.spriteFrameCache:removeSpriteFramesFromFile(plist)
        return true
    end
    return false
end

--------------------------------
-- 按组卸载打包资源
-- @param string plist plist文件
-- @param string group 资源组
-- @function [parent=#ResourceManager] removeSpriteFrameByGroup
function ResourceManager:removeSpriteFramesByGroup(group)
    log:info("remove spriteFrame by group %s", group)
    local resGroup = self:_getGroup(group)
    for _, file in pairs(resGroup) do
        self:removeSpriteFrames(file)
    end

    -- 清空资源组
    if self.groups[group] then
        self.groups[group] = nil
    end
end

--------------------------------
-- 获取SpriteFrame
-- @param string frameName frameName
-- @function [parent=#ResourceManager] getSpriteFrame
function ResourceManager:getSpriteFrame(frameName)
    local frame = self.spriteFrameCache:getSpriteFram(frameName)
    if not frame or tolua.isnull(frame) then
        log:warn("can't get spriteFrame, frameName: %s", frameName)
    end
    return frame
end

--------------------------------
-- 获取系统缓存的纹理
-- @function [parent=#ResourceManager] getCachedTextureInfo
function ResourceManager:getCachedTextureInfo()
    return self.textureCache:getCachedTextureInfo()
end

--------------------------------
-- 移除未使用的纹理
-- @function [parent=#ResourceManager] removeUnusedTextures
function ResourceManager:removeUnusedTextures()
    log:info("removeUnusedTextures")
    return self.textureCache:removeUnusedTextures()
end

--------------------------------
-- 判断指定文件是否存在
-- @param string filepath 文件路径
-- @function [parent=#ResourceManager] isExist
function ResourceManager:isExist(filepath)
    return fileUtils:isFileExist(filepath)
end

--------------------------------
-- 获取组
-- @param string group 组名
-- @param string file 文件名
-- @function [parent=#ResourceManager] addToGroup
function ResourceManager:addToGroup(file, group)
    local resGroup = self:_getGroup(group)
    if not resGroup[file] then
        table.insert(resGroup, file)
    end
end

--------------------------------
-- 判断文件是否已经在组中
-- @param string group 组名
-- @param string file 文件名
-- @function [parent=#ResourceManager] isInGroup
function ResourceManager:isInGroup(file, group)
    local resGroup = self:_getGroup(group)

    return resGroup[file] ~= nil
end

--------------------------------
-- 获取组
-- @function [parent=#ResourceManager] _getGroup
function ResourceManager:_getGroup(groupName)
    if not self.groups[groupName] then
        self.groups[groupName] = {}
    end
    return self.groups[groupName]
end

return ResourceManager

