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

local BlockCore5 = class("BlockCore5", BlockCore)


--------------------------------
-- 构造函数
-- @function [parent=#BlockCore5] ctor
function BlockCore5:ctor(x, y, idx)
    BlockCore.ctor(self, x, y, idx)
    self:initShape()
end

--------------------------------
-- 填充block结构
-- @function [parent=#BlockCore5] initShape
function BlockCore5:initShape()
    self.shapes = {
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

return BlockCore5