--
-- User: wangys
-- BlockProp 俄罗斯方块 - 方块属性
local BlockProp = class("BlockProp")

-- id sequence
local sequence = 1

--------------------------------
-- 构造函数
-- @function [parent=#BlockProp] ctor
function BlockProp:ctor(pic, blockType)
    self.id = sequence
    self.pic = pic
    -- blockType 1 普通障碍方块
    -- blockType 2 方块中包含星星
    -- blockType 3 方块中包含晶石
    -- blockType 4 石头方块, 包含水滴
    -- blockType 5 普通石头方块
    -- blockType 6 普通水滴方块
    self.blockType = blockType
    sequence = sequence + 1
end

return BlockProp