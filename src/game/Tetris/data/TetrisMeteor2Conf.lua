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
function TetrisMeteor2Conf:ctor(confId, blockType, comboNum, starProb, scoreNum, maxTime)
    self.confId = confId
    self.maxTime = maxTime
    self.scoreNum = scoreNum
    self.comboNum = comboNum
    self.targetName = "收集星星"
    self.blockType = blockType
    self.starProb = starProb
    
    TetrisMeteor2Conf.configMap[confId] = self
end

TetrisMeteor2Conf.new(1, "fangkuai5", 3, 1, 3, 60)
TetrisMeteor2Conf.new(2, "fangkuai5", 3, 0.9, 9, 90)
TetrisMeteor2Conf.new(3, "fangkuai5", 3, 0.8, 15, 120)
TetrisMeteor2Conf.new(4, "fangkuai5", 3, 0.7, 21, 150)
TetrisMeteor2Conf.new(5, "fangkuai5", 3, 0.6, 21, 180)

--------------------------------
-- 获取配置
-- @function [parent=#TetrisMeteor2Conf] loadConfig
function TetrisMeteor2Conf.loadConfig(confId)
    return TetrisMeteor2Conf.configMap[confId]
end


return TetrisMeteor2Conf