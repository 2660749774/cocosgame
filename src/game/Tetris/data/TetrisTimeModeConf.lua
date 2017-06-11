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
function TetrisTimeModeConf:ctor(confId, scoreNum, maxTime, bonusProb, probIndex)
    self.confId = confId
    self.scoreNum = scoreNum
    self.maxTime = maxTime
    self.targetName = "极速挑战"
    self.bonusProb = bonusProb
    self.targetIntro = string.format("%s秒内获得%s积分", maxTime, scoreNum)
    self.starArray = {self.maxTime, math.floor(maxTime * 0.85), math.floor(maxTime * 0.7)}
    self.probIndex = probIndex or 0
    self.probArray = {
        {0.02, 0.20, 0.20, 0.18, 0.20, 0.18, 0.02},
        {0.08, 0.16, 0.16, 0.18, 0.16, 0.18, 0.08}
    }
    

    TetrisTimeModeConf.configMap[confId] = self
end

-- 第1章节第1关
TetrisTimeModeConf.new(1, 300, 60, 0.2, 1)
TetrisTimeModeConf.new(2, 350, 60, 0.2, 1)
TetrisTimeModeConf.new(3, 400, 60, 0.2, 1)
TetrisTimeModeConf.new(4, 450, 60, 0.2, 1)
TetrisTimeModeConf.new(5, 500, 60, 0.25, 2)
TetrisTimeModeConf.new(6, 550, 60, 0.25, 2)
TetrisTimeModeConf.new(7, 600, 60, 0.25, 2)
TetrisTimeModeConf.new(8, 650, 60, 0.25, 2)
TetrisTimeModeConf.new(9, 700, 60, 0.3)
TetrisTimeModeConf.new(10, 750, 60, 0.3)
TetrisTimeModeConf.new(11, 800, 60, 0.3)
TetrisTimeModeConf.new(12, 850, 60, 0.3)
TetrisTimeModeConf.new(13, 900, 60, 0.35)
TetrisTimeModeConf.new(14, 950, 60, 0.35)
TetrisTimeModeConf.new(15, 1000, 60, 0.35)
TetrisTimeModeConf.new(16, 1050, 60, 0.35)
TetrisTimeModeConf.new(17, 1100, 60, 0.4)
TetrisTimeModeConf.new(18, 1150, 60, 0.4)
TetrisTimeModeConf.new(19, 1200, 60, 0.4)
TetrisTimeModeConf.new(20, 1250, 60, 0.4)
TetrisTimeModeConf.new(21, 1300, 60, 0.4)
TetrisTimeModeConf.new(22, 1350, 60, 0.4)
TetrisTimeModeConf.new(23, 1400, 60, 0.4)
TetrisTimeModeConf.new(24, 1450, 60, 0.4)
TetrisTimeModeConf.new(25, 1500, 60, 0.4)

--------------------------------
-- 获取配置
-- @function [parent=#TetrisTimeModeConf] loadConfig
function TetrisTimeModeConf.loadConfig(confId)
    return TetrisTimeModeConf.configMap[confId]
end


return TetrisTimeModeConf