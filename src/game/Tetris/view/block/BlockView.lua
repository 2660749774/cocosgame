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
    local x, y = (self.model.x * self.blockWidth + 1), (self.model.y * self.blockWidth + 1)
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




return BlockView

