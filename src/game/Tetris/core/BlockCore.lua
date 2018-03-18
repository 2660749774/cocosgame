--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2016/12/31
-- Time: 15:16
-- To change this template use File | Settings | File Templates.
-- BlockCore 方块core
local BlockCore = class("BlockCore")

--------------------------------
-- 创建方法
-- @function [parent=#BlockCore] onCreate
function BlockCore:ctor(type, x, y, idx)
    self.x = x
    self.y = y
    self.idx = idx
    self.type = type
    self.updateTimes = 0
end

--------------------------------
-- 获取方块数组
-- @function [parent=#BlockCore] getBlockArray
function BlockCore:getBlockArray()
    return self.shapes[self.idx]
end

--------------------------------
-- 进行行动
-- @function [parent=#BlockCore] getBlockArray
function BlockCore:doAction(action, reverse)
    reverse = reverse or false
    -- log:info("do action:%s, reverse:%s", action, reverse)
    self.updateTimes = self.updateTimes + 1
    if not reverse then
        if action == "up" then
            self:up()
        elseif action == "down" then
            self:down()
        elseif action == "left" then
            self:left()
        elseif action == "right" then
            self:right()
        elseif action == "shift" then
            self:shift()
        end
    else
        if action == "up" then
            self:down()
        elseif action == "down" then
            self:up()
        elseif action == "left" then
            self:right()
        elseif action == "right" then
            self:left()
        elseif action == "shift" then
            self:shift()
            self:shift()
            self:shift()
        end
    end
end

--------------------------------
-- 下降一格
-- @function [parent=#BlockCore] down
function BlockCore:down()
    self.y = self.y - 1
end

--------------------------------
-- 上升一格
-- @function [parent=#BlockCore] up
function BlockCore:up()
    self.y = self.y + 1 
end

--------------------------------
-- 向左一格
-- @function [parent=#BlockCore] left
function BlockCore:left()
    self.x = self.x - 1 
end

--------------------------------
-- 向右一格
-- @function [parent=#BlockCore] right
function BlockCore:right()
    self.x = self.x + 1
end

--------------------------------
-- 旋转一次
-- @function [parent=#BlockCore] shift
function BlockCore:shift()
    self.idx = (self.idx + 1) % 4
    if self.idx == 0 then
        self.idx = 4
    end
end

--------------------------------
-- 克隆方法
-- @function [parent=#BlockCore] clone
function BlockCore:clone()
    local block = BlockCore:create(self.type, self.x, self.y, self.idx)
    block.shapes = clone(self.shapes)
    block.updateTimes = self.updateTimes

    return block
end

return BlockCore

