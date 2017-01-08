--
-- User: wangys
-- BaseBlock 俄罗斯方块 - 方块1
--   | 4 | 3 |   |
--   |   | 1 | 2 |
--   |   |   |   |

--   |   |   | 4 |
--   |   | 1 | 3 |
--   |   | 2 |   |

--   |   |   |   |
--   | 2 | 1 |   |
--   |   | 3 | 4 |


--   |   | 2 |   |
--   | 3 | 1 |   |
--   | 4 |   |   |


local BaseBlock = import(".BaseBlock")

local Block7 = class("Block7", BaseBlock)


--------------------------------
-- 构造函数
-- @function [parent=#Block7 ctor
function Block7:ctor(angle, min, max, pic)
    BaseBlock.ctor(self, 7, angle, min, max, pic)
    self:fillBlockArray()
    self:refreshDisplay()
end

--------------------------------
-- 填充block结构
-- @function [parent=#Block7] fillBlockArray
function Block7:fillBlockArray()
    self.blockArray = {
        {
            {0, 0, 0, 0},
            {1, 1, 0, 0},
            {0, 1, 1, 0},
            {0, 0, 0, 0}
        },
        {
            {0, 0, 1, 0},
            {0, 1, 1, 0},
            {0, 1, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {0, 0, 0, 0},
            {1, 1, 0, 0},
            {0, 1, 1, 0},
            {0, 0, 0, 0}
        },
        {
            {0, 0, 1, 0},
            {0, 1, 1, 0},
            {0, 1, 0, 0},
            {0, 0, 0, 0}
        }
    }
end



return Block7