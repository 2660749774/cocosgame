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
local TetrisPowerConf = import("..data.TetrisPowerConf")
local Tetris = import (".Tetris")
local RandomUtil = require "core.util.RandomUtil"

--------------------------------
-- 创建方法
-- @function [parent=#TetrisTimeModePanel] onCreate
function TetrisTimeModePanel:onCreate(powerId, armyId)
    TetrisSinglePanel.onCreate(self, "layout.TetrisTimeMode")

    self.powerId = powerId
    self.armyId = armyId
    self.lbTimeMinute = self.layout['lb_time_minute']
    self.lbTimeSec = self.layout['lb_time_sec']
    self.lbResult = self.layout['lb_result']
    self.pgResult = self.layout['pg_result']
    self.pgResult:loadSlidBallTextureNormal('', 0)
    self.pgResult:loadSlidBallTexturePressed('', 0)
    self.pgResult:loadSlidBallTextureDisabled('', 0)
    self.pgResult:setPercent(0)
    self.totalTime = 60
    -- self.totalBlockNum = 60
    -- self.blockNum = 0
    self.time = 0
    self.needScore = 0
    self:loadConfig(TetrisPowerConf.TYPE_TIMEMODE, powerId, armyId)
    self:updateTime()
    self:updateScoreProgress()
end

--------------------------------
-- 载入配置
-- @function [parent=#TetrisTimeModePanel] loadConfig
function TetrisTimeModePanel:loadConfig(type, powerId, armyId)
    self.conf = TetrisPowerConf.loadDetailConfig(powerId, armyId)
    -- self.totalBlockNum = self.conf.maxBlockNum
    self.totalTime = self.conf.maxTime
    self.needScore = self.conf.scoreNum
    self.starArray = self.conf.starArray
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

    local minute = math.floor(leftTime / 60)
    local sec = math.floor(leftTime % 60)
    self.lbTimeMinute:setString(string.format("%02d", minute))
    self.lbTimeSec:setString(string.format("%02d", sec))
end

--------------------------------
-- 更新剩余方块数
-- @function [parent=#TetrisTimeModePanel] updateBlockNum
function TetrisTimeModePanel:updateBlockNum()
    -- local blockNum = self.totalBlockNum - self.blockNum
    -- if blockNum <= 0 then
    --     self.tetris:gameOver()
    --     blockNum = 0
    -- end
    -- self.lbLeftBlockNum:setString(blockNum)
end

--------------------------------
-- 更新分数
-- @function [parent=#TetrisTimeModePanel] updateScore
function TetrisTimeModePanel:updateScoreProgress()
    self.lbResult:setString(tostring(self.score))
    self.pgResult:setPercent(math.floor(self.score * 100 / self.needScore))
end


--------------------------------
-- 游戏结束
-- @function [parent=#TetrisMazePanel] notifyGameOver
function TetrisTimeModePanel:notifyGameOver()
    if self.pass then
        return
    end
    self:getScene():pushPanel("Tetris.view.TetrisPowerFail", {self.powerId, self.armyId, self.score, self.needScore, self})
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
    -- self.blockNum =  self.blockNum + 1
    self:updateScoreProgress()

    if self.score >= self.needScore then
        local useTime = self.time
        local starArray = self.starArray
        local star = 1
        for i=3, 1, -1 do
            log:info("cmp score star:%s, need:%s, value:%s", i, starArray[i], useTime)
            if useTime <= starArray[i] then
                star = i
                break
            end
        end
        -- 胜利了
        -- Tips.showSceneTips("恭喜您获胜了！！！", 3)
        self.pass = true
        self.tetris:gameOver()
        self:getScene():pushPanel("Tetris.view.TetrisPowerSucc", {self.powerId, self.armyId, star, self.score})
    end
end

--------------------------------
-- 重置
-- @function [parent=#TetrisTimeModePanel] reset
function TetrisTimeModePanel:reset()
    TetrisSinglePanel.reset(self)

    self.score = 0
    self.blockNum = 0
    self.time = 0
    self:updateBlockNum()
    self:updateTime()
end


return TetrisTimeModePanel

