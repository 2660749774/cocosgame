--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisTimeModePanel 俄罗斯方块
-- 规定时间内达到指定分数
local TetrisSinglePanel = import(".TetrisSinglePanel")
local TetrisTimeModePanel = class("TetrisTimeModePanel", TetrisSinglePanel)
local TetrisTimeModeConf = import("..data.TetrisTimeModeConf")
local Tetris = import (".Tetris")
local RandomUtil = require "core.util.RandomUtil"

--------------------------------
-- 创建方法
-- @function [parent=#TetrisTimeModePanel] onCreate
function TetrisTimeModePanel:onCreate(powerId, armyId)
    TetrisSinglePanel.onCreate(self, "layout.TetrisTimeMode")
    self.lbTime = self.layout['lb_time']
    self.lbLeftBlockNum = self.layout['lb_left_line']
    self.totalTime = 60
    self.totalBlockNum = 60
    self.blockNum = 0
    self.time = 0
    self.needScore = 0
    self:loadConfig(TetrisSinglePanel.TYPE_TIMEMODE, powerId, armyId)
    self:updateTime()
    self:updateBlockNum()
    self.layout['lb_needscore']:setString(self.needScore * 10)
end

--------------------------------
-- 载入配置
-- @function [parent=#TetrisTimeModePanel] loadConfig
function TetrisTimeModePanel:loadConfig(type, powerId, armyId)
    self.conf = TetrisTimeModeConf.loadConfig(powerId, armyId)
    self.totalBlockNum = self.conf.maxBlockNum
    self.totalTime = self.conf.maxTime
    self.needScore = self.conf.scoreNum
end

--------------------------------
-- 更新倒计时
-- @function [parent=#TetrisTimeModePanel] onCreate
function TetrisTimeModePanel:updateTime()
    local leftTime = math.round(self.totalTime - self.time)
    if leftTime <= 0 then
        self.tetris:gameOver()
        leftTime = 0
    end
    self.lbTime:setString(tostring(leftTime))
end

--------------------------------
-- 更新剩余方块数
-- @function [parent=#TetrisTimeModePanel] roundStart
function TetrisTimeModePanel:updateBlockNum()
    local blockNum = self.totalBlockNum - self.blockNum
    if blockNum <= 0 then
        self.tetris:gameOver()
        blockNum = 0
    end
    self.lbLeftBlockNum:setString(blockNum)
end

--------------------------------
-- 每秒帧事件
-- @function [parent=#TetrisTimeModePanel] doUpdate
function TetrisTimeModePanel:doUpdate(dt)
    self.time = self.time + dt
    self:updateTime()
end

--------------------------------
-- 更新分数
-- @function [parent=#TetrisTimeModePanel] updateScore
function TetrisTimeModePanel:updateScore(removeLineNums)
    TetrisSinglePanel.updateScore(self, removeLineNums)
    self.blockNum =  self.blockNum + 1
    self:updateBlockNum()

    if self.removeLineNums >= self.needScore then
        -- 胜利了
        Tips.showSceneTips("恭喜您获胜了！！！", 3)
        self.tetris:gameOver()
    end
end

--------------------------------
-- 重置
-- @function [parent=#TetrisTimeModePanel] reset
function TetrisTimeModePanel:reset()
    TetrisSinglePanel.reset(self)

    self.blockNum = 0
    self.time = 0
    self:updateBlockNum()
    self:updateTime()
end


return TetrisTimeModePanel

