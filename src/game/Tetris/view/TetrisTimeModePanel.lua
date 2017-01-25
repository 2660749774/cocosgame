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
    self.totalTime = 60
    self.time = 0
    self:updateTime()
end

--------------------------------
-- 更新倒计时
-- @function [parent=#TetrisTimeModePanel] onCreate
function TetrisTimeModePanel:updateTime()
    local remindTime = math.round(self.totalTime - self.time)
    if remindTime <= 0 then
        self.tetris:gameOver()
        remindTime = 0
    end
    self.lbTime:setString(tostring(remindTime))
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

