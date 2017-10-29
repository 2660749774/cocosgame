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

local BlockCore6 = class("BlockCore6", BlockCore)


--------------------------------
-- 构造函数
-- @function [parent=#BlockCore6] ctor
function BlockCore6:ctor(x, y, idx)
    BlockCore.ctor(self, 6, x, y, idx)
    self:initShape()
end

--------------------------------
-- 填充block结构
-- @function [parent=#BlockCore6] initShape
function BlockCore6:initShape()
    self.shapes = {
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

return BlockCore6