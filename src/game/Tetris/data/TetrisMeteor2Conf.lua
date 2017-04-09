--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisMeteor2Conf 星星收集模式

local TetrisMeteor2Conf = class("TetrisMeteor2Conf")

TetrisMeteor2Conf.configMap = {}

--------------------------------
-- 构造函数
-- @function [parent=#TetrisMeteor2Conf] ctor
function TetrisMeteor2Conf:ctor(confId, blockType, comboNum, scoreNum, maxTime)
    self.confId = confId
    self.maxTime = maxTime
    self.scoreNum = scoreNum
    self.comboNum = comboNum
    self.targetName = "收集星星"
    self.blockType = blockType
    
    TetrisMeteor2Conf.configMap[confId] = self
end

-- 第一章节第一关
TetrisMeteor2Conf.new(1, "fangkuai5", 3, 10, 100)

--------------------------------
-- 获取配置
-- @function [parent=#TetrisMeteor2Conf] loadConfig
function TetrisMeteor2Conf.loadConfig(confId)
    return TetrisMeteor2Conf.configMap[confId]
end


return TetrisMeteor2Conf