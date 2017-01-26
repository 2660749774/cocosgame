--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisTimeModeConf 极速挑战模式

local TetrisTimeModeConf = class("TetrisTimeModeConf")

TetrisTimeModeConf.configMap = {}

--------------------------------
-- 构造函数
-- @function [parent=#TetrisTimeModeConf] ctor
function TetrisTimeModeConf:ctor(powerId, armyId, scoreNum, maxTime, maxBlockNum)
    self.scoreNum = scoreNum
    self.maxTime = maxTime
    self.maxBlockNum = maxBlockNum
    

    TetrisTimeModeConf.configMap[powerId] = {}
    TetrisTimeModeConf.configMap[powerId][armyId] = self
end

-- 第一章节第一关
TetrisTimeModeConf.new(1, 2, 10, 75, 35)

--------------------------------
-- 获取配置
-- @function [parent=#TetrisTimeModeConf] loadConfig
function TetrisTimeModeConf.loadConfig(powerId, armyId)
    return TetrisTimeModeConf.configMap[powerId][armyId]
end


return TetrisTimeModeConf