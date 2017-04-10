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
function TetrisTimeModeConf:ctor(confId, scoreNum, maxTime)
    self.confId = confId
    self.scoreNum = scoreNum
    self.maxTime = maxTime
    self.targetName = "挑战最高分"
    self.targetIntro = string.format("%s秒内获得%s积分", maxTime, scoreNum)
    self.starArray = {self.maxTime, math.floor(maxTime * 0.85), math.floor(maxTime * 0.7)}
    

    TetrisTimeModeConf.configMap[confId] = self
end

-- 第1章节第1关
TetrisTimeModeConf.new(1, 300, 60)

-- 第1章节第2关
TetrisTimeModeConf.new(2, 350, 60)

-- 第1章节第3关
TetrisTimeModeConf.new(3, 400, 60)

-- 第1章节第4关
TetrisTimeModeConf.new(4, 450, 60)

-- 第1章节第5关
TetrisTimeModeConf.new(5, 500, 60)

--------------------------------
-- 获取配置
-- @function [parent=#TetrisTimeModeConf] loadConfig
function TetrisTimeModeConf.loadConfig(confId)
    return TetrisTimeModeConf.configMap[confId]
end


return TetrisTimeModeConf