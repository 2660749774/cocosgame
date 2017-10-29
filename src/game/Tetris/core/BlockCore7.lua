--
-- User: wangys
-- BaseBlock 俄罗斯方块 - 方块1
--   |   | 3 | 4 |
--   | 1 | 2 |   |
--   |   |   |   |

--   |   | 1 |   |
--   |   | 2 | 3 |
--   |   |   | 4 |

--   |   |   |   |
--   |   | 2 | 1 |
--   | 4 | 3 |   |


--   | 4 |   |   |
--   | 3 | 2 |   |
--   |   | 1 |   |


local BlockCore = import(".BlockCore")

local BlockCore7 = class("BlockCore7", BlockCore)


--------------------------------
-- 构造函数
-- @function [parent=#BlockCore7] ctor
function BlockCore7:ctor(x, y, idx)
    BlockCore.ctor(self, 7, x, y, idx)
    self:initShape()
end

--------------------------------
-- 填充block结构
-- @function [parent=#BlockCore7] initShape
function BlockCore7:initShape()
    self.shapes = {
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

return BlockCore7