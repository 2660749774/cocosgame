--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2016/12/31
-- Time: 15:16
-- To change this template use File | Settings | File Templates.
-- BlockView 方块的显示对象
local BlockView = class("BlockView", cc.Node)

--------------------------------
-- 创建方法
-- @function [parent=#BlockView] onCreate
function BlockView:ctor(model, pic)
    self.model = model
    self.pic = pic
    self.blockWidth = 27
    self.fixPixel = 3
    self.blocks = {}
    self:updateBlock()
end

--------------------------------
-- 进行更新
-- @function [parent=#BlockView] render
function BlockView:doUpdate()
    -- 更新方块位置
    self:updateBlock()

    -- 更新坐标位置
    local x, y = (self.model.x * self.blockWidth + self.fixPixel), (self.model.y * self.blockWidth + self.fixPixel)
    self:setPosition(cc.p(x, y))
end

--------------------------------
-- 更新方块显示
-- @function [parent=#BlockView] updateBlock
function BlockView:updateBlock()
    local array = self.model:getBlockArray()
    if #self.blocks == 0 then
        local bg = cc.Sprite:create() --cc.LayerColor:create(ccc4(0xFF, 0x00, 0x00, 0x80), self.blockWidth * 4, self.blockWidth * 4)
        bg:setContentSize(cc.size(self.blockWidth * 4,self.blockWidth * 4))
        bg:setAnchorPoint(0, 0)
        for i=1, #array do
            for j=1, #array[i] do
                if array[i][j] == 1 then
                    local sprite = cc.Sprite:createWithSpriteFrameName(self.pic)
                    sprite:setAnchorPoint(0, 0)

                    local x, y = (j - 1), (4 - i)
                    sprite:setPosition(x * self.blockWidth, y * self.blockWidth)
                    bg:addChild(sprite)
                    table.insert(self.blocks, sprite)
                end
            end
        end
        self:addChild(bg)
    else
        local index = 1
        for i=1, #array do
            for j=1, #array[i] do
                if array[i][j] == 1 then
                    local x, y = (j - 1), (4 - i)
                    self.blocks[index]:setPosition(x * self.blockWidth, y * self.blockWidth)
                    index = index + 1
                end
            end
        end
    end
end

--------------------------------
-- 获取block方块
-- @function [parent=#BlockView] getBlockArray
function BlockView:getBlockArray()
    return self.model:getBlockArray()
end

--------------------------------
-- 获取block方块
-- @function [parent=#BlockView] getBlock
function BlockView:getBlock(index)
    return self.blocks[index]
end

--------------------------------
-- 获取格子的偏移量
-- @function [parent=#BlockView] getOffSet
function BlockView:getOffSet()
    local minx, miny = self:_getGridArrayOffSet(self:getGridArray())

    return minx * self.blockWidth, miny * self.blockWidth
end


--------------------------------
-- 获取格子的逻辑坐标
-- @function [parent=#BlockView] getGridArray
    function BlockView:getGridArray()
        local array = {}
        for _, block in pairs(self.blocks) do
            local x, y = block:getPosition()
            table.insert(array, {x / self.blockWidth, y / self.blockWidth, block})
        end
        return array
    end
    
    --------------------------------
    -- 获取格子的负极值
    -- @function [parent=#BlockView] _getGridArrayOffSet
    function BlockView:_getGridArrayOffSet(array)
        local minx = -1
        local miny = -1
        for _, value in pairs(array) do
            if minx == -1 or value[1] < minx then
                minx = value[1]
            end
            if miny == -1 or value[2] < miny then
                miny = value[2]
            end
        end
    
        return minx, miny
    end



return BlockView

