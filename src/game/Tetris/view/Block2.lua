--
-- User: wangys
-- BaseBlock 俄罗斯方块 - 方块2
--   | 3 | 4 |   |
--   | 1 | 2 |   |
--   |   |   |   |



local BaseBlock = import(".BaseBlock")

local Block2 = class("Block2", BaseBlock)

--------------------------------
-- 构造函数
-- @function [parent=#Block2] ctor
function Block2:ctor(angle, min, max, pic)
    BaseBlock.ctor(self, 2, angle, min, max, pic)
    self:fillBlockArray()
    self:refreshDisplay()
end

--------------------------------
-- 填充block结构
-- @function [parent=#Block2] fillBlockArray
function Block2:fillBlockArray()
    self.blockArray = {
        {
            {0, 0, 0, 0},
            {0, 1, 1, 0},
            {0, 1, 1, 0},
            {0, 0, 0, 0}
        },
        {
            {0, 0, 0, 0},
            {0, 1, 1, 0},
            {0, 1, 1, 0},
            {0, 0, 0, 0}
        },
        {
            {0, 0, 0, 0},
            {0, 1, 1, 0},
            {0, 1, 1, 0},
            {0, 0, 0, 0}
        },
        {
            {0, 0, 0, 0},
            {0, 1, 1, 0},
            {0, 1, 1, 0},
            {0, 0, 0, 0}
        }
    }
end

return Block2