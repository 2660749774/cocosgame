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
local Tetris = import (".Tetris")
local RandomUtil = require "core.util.RandomUtil"

--------------------------------
-- 创建方法
-- @function [parent=#TetrisTimeModePanel] onCreate
function TetrisTimeModePanel:onCreate()
    TetrisSinglePanel.onCreate(self, "layout.TetrisTimeMode")
    self.lbTime = self.layout['lb_time']
    self.lbLeftBlockNum = self.layout['lb_left_line']
    self.totalTime = 60
    self.totalBlockNum = 60
    self.blockNum = 0
    self.time = 0
    self:updateTime()
    self:updateBlockNum()
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
-- 回合开始
-- @function [parent=#TetrisTimeModePanel] roundStart
function TetrisTimeModePanel:roundStart(oldNextBlock, newNextBlock)
    TetrisSinglePanel.roundStart(self, oldNextBlock, newNextBlock)
    self.blockNum =  self.blockNum + 1
    self:updateBlockNum()
end

--------------------------------
-- 每秒帧事件
-- @function [parent=#TetrisTimeModePanel] doUpdate
function TetrisTimeModePanel:doUpdate(dt)
    log:info("TetrisTimeModePanel doUpdate %s", dt)
    self.time = self.time + dt
    self:updateTime()
end

return TetrisTimeModePanel

