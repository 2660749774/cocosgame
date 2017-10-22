--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2016/12/31
-- Time: 15:16
-- To change this template use File | Settings | File Templates.
-- BlockView 方块的显示对象
local BlockView = class("BlockView")

--------------------------------
-- 创建方法
-- @function [parent=#BlockView] onCreate
function BlockView:ctor(x, y, idx)
    self.x = x
    self.y = y
    self.idx = idx
end

--------------------------------
-- 获取方块数组
-- @function [parent=#BlockView] getBlockArray
function BlockView:getBlockArray()
    return self.shapes[self.idx]
end

--------------------------------
-- 进行行动
-- @function [parent=#BlockView] getBlockArray
function BlockView:doAction(action, reverse)
    reverse = reverse or false

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
-- @function [parent=#BlockView] down
function BlockView:down()
    self.y = self.y - 1
end

--------------------------------
-- 上升一格
-- @function [parent=#BlockView] up
function BlockView:up()
    self.y = self.y + 1 
end

--------------------------------
-- 向左一格
-- @function [parent=#BlockView] left
function BlockView:left()
    self.x = self.x - 1 
end

--------------------------------
-- 向右一格
-- @function [parent=#BlockView] right
function BlockView:right()
    self.x = self.x + 1
end

--------------------------------
-- 旋转一次
-- @function [parent=#BlockView] shift
function BlockView:shift()
    self.idx = (self.idx + 1) % 4
end



return BlockView

