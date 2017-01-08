--
-- User: wangys
-- BaseBlock 俄罗斯方块 - 方块5
--   |   |   |   |   |
--   |   | 4 |   |   |
--   | 1 | 2 | 3 |   |
--   |   |   |   |   |

--   |   |   |   |   |
--   |   | 1 |   |   |
--   |   | 2 | 4 |   |
--   |   | 3 |   |   |

--   |   |   |   |   |
--   |   |   |   |   |
--   | 3 | 2 | 1 |   |
--   |   | 4 |   |   |
--   |   |   |   |   |

--   |   |   |   |   |
--   |   | 3 |   |   |
--   | 4 | 2 |   |   |
--   |   | 1 |   |   |
--   |   |   |   |   |


local BaseBlock = import(".BaseBlock")

local Block5 = class("Block5", BaseBlock)



--------------------------------
-- 构造函数
-- @function [parent=#Block5] ctor
function Block5:ctor(angle, min, max, pic)
    BaseBlock.ctor(self, 5, angle, min, max, pic)
    self:fillBlockArray()
    self:refreshDisplay()
end

--------------------------------
-- 填充block结构
-- @function [parent=#Block5] fillBlockArray
function Block5:fillBlockArray()
    self.blockArray = {
        {
            {0, 0, 0, 0},
            {0, 1, 0, 0},
            {1, 1, 1, 0},
            {0, 0, 0, 0}
        },
        {
            {0, 0, 0, 0},
            {0, 1, 0, 0},
            {1, 1, 0, 0},
            {0, 1, 0, 0}
        },
        {
            {0, 0, 0, 0},
            {0, 0, 0, 0},
            {1, 1, 1, 0},
            {0, 1, 0, 0}
        },
        {
            {0, 0, 0, 0},
            {0, 1, 0, 0},
            {0, 1, 1, 0},
            {0, 1, 0, 0}
        }
    }
end


return Block5