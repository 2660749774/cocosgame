--
-- User: wangys
-- BaseBlock 俄罗斯方块 - 方块3
--   |   |   |   |   |
--   | 1 | 2 | 3 | 4 |
--   |   |   |   |   |
--   |   |   |   |   |

--   |   | 1 |   |   |
--   |   | 2 |   |   |
--   |   | 3 |   |   |
--   |   | 4 |   |   |



local BaseBlock = import(".BaseBlock")

local Block3 = class("Block3", BaseBlock)

--------------------------------
-- 构造函数
-- @function [parent=#Block3] ctor
function Block3:ctor(angle, min, max, pic)
    BaseBlock.ctor(self, 3, angle, min, max, pic)
    self:fillBlockArray()
    self:refreshDisplay()
end

--------------------------------
-- 填充block结构
-- @function [parent=#Block3] fillBlockArray
function Block3:fillBlockArray()
    self.blockArray = {
        {
            {0, 0, 0, 0},
            {1, 1, 1, 1},
            {0, 0, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {0, 0, 1, 0},
            {0, 0, 1, 0},
            {0, 0, 1, 0},
            {0, 0, 1, 0}
        },
        {
            {0, 0, 0, 0},
            {1, 1, 1, 1},
            {0, 0, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {0, 0, 1, 0},
            {0, 0, 1, 0},
            {0, 0, 1, 0},
            {0, 0, 1, 0}
        }
    }
end



return Block3