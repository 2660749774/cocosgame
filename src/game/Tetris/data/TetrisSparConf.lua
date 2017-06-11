--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisSparConf 收集晶石

local TetrisSparConf = class("TetrisSparConf")

TetrisSparConf.configMap = {}


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
-- @function [parent=#TetrisSparConf] ctor
function TetrisSparConf:ctor(confId, blockType, collectBlockNum, maxTime, blockProb, blockArray)
    self.confId = confId
    self.blockArray = blockArray
    self.blockType = blockType
    self.maxTime = maxTime
    self.collectBlockNum = collectBlockNum
    self.blockProb = blockProb
    self.targetName = "能量石"

    TetrisSparConf.configMap[confId] = self
end

-- 第1章节第1关
TetrisSparConf.new(1, "fangkuai4", 20, 100, 1, {
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
})


--------------------------------
-- 获取配置
-- @function [parent=#TetrisSparConf] loadConfig
function TetrisSparConf.loadConfig(confId)
    return TetrisSparConf.configMap[confId]
end


return TetrisSparConf