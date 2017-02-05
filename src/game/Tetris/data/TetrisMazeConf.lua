--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisMazeConf 方块迷阵

local TetrisMazeConf = class("TetrisMazeConf")

TetrisMazeConf.configMap = {}


-- block1
--   |   | 3 | 4 |
--   | 1 | 2 |   |
--   |   |   |   |

-- block2
--   | 3 | 4 |   |
--   | 1 | 2 |   |
--   |   |   |   |

-- block3
--   |   |   |   |   |
--   | 1 | 2 | 3 | 4 |
--   |   |   |   |   |
--   |   |   |   |   |

-- block4
--   |   | 4 |   |   |
--   |   | 3 |   |   |
--   | 1 | 2 |   |   |
--   |   |   |   |   |

-- block5
--   |   |   |   |   |
--   |   | 4 |   |   |
--   | 1 | 2 | 3 |   |
--   |   |   |   |   |

-- block6
--   | 4 |   |   |   |
--   | 3 |   |   |   |
--   | 1 | 2 |   |   |
--   |   |   |   |   |

-- block7
--   | 4 | 3 |   |
--   |   | 1 | 2 |
--   |   |   |   |

--------------------------------
-- 构造函数
-- @function [parent=#TetrisMazeConf] ctor
function TetrisMazeConf:ctor(powerId, armyId, blockType, maxBlockNum, blockArray, nextBlockArray)
    self.blockArray = blockArray
    self.nextBlockArray = nextBlockArray
    self.blockType = blockType
    self.maxBlockNum = maxBlockNum

    TetrisMazeConf.configMap[powerId] = {}
    TetrisMazeConf.configMap[powerId][armyId] = self
end

-- 第一章节第一关
TetrisMazeConf.new(1, 3, "fangkuai3", 2, {
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1},
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1}
}, {
    3, 5
})

--------------------------------
-- 获取配置
-- @function [parent=#TetrisMazeConf] loadConfig
function TetrisMazeConf.loadConfig(powerId, armyId)
    return TetrisMazeConf.configMap[powerId][armyId]
end


return TetrisMazeConf