--
-- User: wangys
-- BaseBlock 俄罗斯方块 - 方块6
--   | 4 |   |   |   |
--   | 3 |   |   |   |
--   | 1 | 2 |   |   |
--   |   |   |   |   |

--   |   |   |   |   |
--   |   |   |   |   |
--   | 1 | 3 | 4 |   |
--   | 2 |   |   |   |

--   |   |   |   |   |
--   |   |   |   |   |
--   | 2 | 1 |   |   |
--   |   | 3 |   |   |
--   |   | 4 |   |   |

--   |   |   |   |   |
--   |   |   | 2 |   |
--   |4  | 3 | 1 |   |
--   |   |   |   |   |
--   |   |   |   |   |


local BaseBlock = import(".BaseBlock")

local Block6 = class("Block6", BaseBlock)


--------------------------------
-- 构造函数
-- @function [parent=#Block6 ctor
function Block6:ctor(angle, min, max, pic)
    BaseBlock.ctor(self, 6, angle, min, max, pic)
    self:fillBlockArray()
    self:refreshDisplay()
end

--------------------------------
-- 填充block结构
-- @function [parent=#Block6] fillBlockArray
function Block6:fillBlockArray()
    self.blockArray = {
        {
            {0, 1, 0, 0},
            {0, 1, 0, 0},
            {0, 1, 1, 0},
            {0, 0, 0, 0}
        },
        {
            {0, 0, 0, 0},
            {1, 1, 1, 0},
            {1, 0, 0, 0},
            {0, 0, 0, 0}
        },
        {
            {0, 1, 1, 0},
            {0, 0, 1, 0},
            {0, 0, 1, 0},
            {0, 0, 0, 0}
        },
        {
            {0, 0, 0, 0},
            {0, 0, 1, 0},
            {1, 1, 1, 0},
            {0, 0, 0, 0}
        }
    }
end



return Block6