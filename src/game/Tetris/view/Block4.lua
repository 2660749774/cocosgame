--
-- User: wangys
-- BaseBlock 俄罗斯方块 - 方块4
--   |   | 4 |   |   |
--   |   | 3 |   |   |
--   | 1 | 2 |   |   |
--   |   |   |   |   |

--   |   |   |   |   |
--   |   | 1 |   |   |
--   |   | 2 | 3 | 4 |
--   |   |   |   |   |

--   |   |   |   |   |
--   |   |   |   |   |
--   |   | 2 | 1 |   |
--   |   | 3 |   |   |
--   |   | 4 |   |   |

--   |   |   |   |   |
--   |   |   |   |   |
--   |4  | 3 | 2 |   |
--   |   |   | 1 |   |
--   |   |   |   |   |


local BaseBlock = import(".BaseBlock")

local Block4 = class("Block4", BaseBlock)

--------------------------------
-- 构造函数
-- @function [parent=#Block4] ctor
function Block4:ctor(angle, min, max, pic)
    BaseBlock.ctor(self, 4, angle, min, max, pic)
    self:fillBlockArray()
    self:refreshDisplay()
end

--------------------------------
-- 填充block结构
-- @function [parent=#Block4] fillBlockArray
function Block4:fillBlockArray()
    self.blockArray = {
        {
            {0, 0, 1, 0},
            {0, 0, 1, 0},
            {0, 1, 1, 0},
            {0, 0, 0, 0}
        },
        {
            {0, 1, 0, 0},
            {0, 1, 1, 1},
            {0, 0, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {0, 1, 1, 0},
            {0, 1, 0, 0},
            {0, 1, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {1, 1, 1, 0},
            {0, 0, 1, 0},
            {0, 0, 0, 0},
            {0, 0, 0, 0}
        }
    }
end



return Block4