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
    self.score = 0
    self.animTime = 0
    self:loadConfig(TetrisPowerConf.TYPE_TIMEMODE, powerId, armyId)
    self:updateTime()
    self:updateScoreProgress()

    -- 设置关卡数
    if powerId == 1 then
        self.lbArmyNum:setString(armyId)
    else
        self.lbArmyNum:setString(59 + armyId)
    end
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
    self.bonusProb = self.conf.bonusProb
    if self.conf.probIndex ~= 0 then
        self.probArray = self.conf.probArray[self.conf.probIndex]
    end
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
-- 更新分数
-- @function [parent=#TetrisTimeModePanel] updateScore
function TetrisTimeModePanel:updateScoreProgress()
    self.lbResult:setString(math.floor(self.score * 100 / self.needScore) .. "%")
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
-- 获取随机数
-- @function [parent=#TetrisSinglePanel] nextInt
function TetrisTimeModePanel:nextInt(range, times)
    if self.randomCache[times] then
        return self.randomCache[times]
    end
    if self.probArray then
        self.randomCache[times] = RandomUtil:nextDoubleIndex(self.probArray)
    else
        self.randomCache[times] = RandomUtil:nextInt(range)
    end
    return self.randomCache[times]
end


--------------------------------
-- 更新下一个方块
-- @function [parent=#TetrisTimeModePanel] updateNextBlock
function TetrisTimeModePanel:updateNextBlock(nextBlock)
    if RandomUtil:nextDouble() < self.bonusProb then
        log:info("updateNextBlock add time or score")

        -- local label = ccui.Text:create()
        -- label:setFontSize(20)
        -- label:enableShadow({r = 0, g = 0, b = 0, a = 255}, {width = 1, height = -1}, 0)
        local index = RandomUtil:nextInt(#nextBlock.blocks)

        nextBlock.blocks[index].extraAttributes = true
        if RandomUtil:nextBoolean() then
            nextBlock.blocks[index].time = 10
            -- label:setString("时")
            -- label:setPosition(13.5, 13.5)

            local sprite = cc.Sprite:createWithSpriteFrameName("time_flag.png")
            sprite:setPosition(13.5, 13.5)
            sprite:setScale(0.8)
            nextBlock.blocks[index]:addChild(sprite)
        else
            nextBlock.blocks[index].score = 100

            local sprite = cc.Sprite:createWithSpriteFrameName("score_flag.png")
            sprite:setPosition(13.5, 13.5)
            -- label:setString("分")
            -- label:setPosition(13.5, 13.5)
            nextBlock.blocks[index]:addChild(sprite)

        end
    end

    return nextBlock
end

--------------------------------
-- 处理额外属性
-- @function [parent=#TetrisTimeModePanel] handleExtraAttributes
function TetrisTimeModePanel:handleExtraAttributes(attributes)
    if attributes.time then
        self.time = self.time - attributes.time

        local label = ccui.Text:create()
        label:setFontSize(32)
        label:setColor(cc.c3b(255, 255, 255))
        label:enableShadow({r = 0, g = 0, b = 0, a = 255}, {width = 1, height = -1}, 0)
        label:setString("+" .. attributes.time)

        local x, y = self.lbTimeSec:getPosition()
        label:setPosition(x + 50, y)
        self:addChild(label)

        local delayAction = cc.DelayTime:create(self.animTime)
        local action1 = cc.MoveTo:create(0.5, cc.p(x, y))
        local action2 = cc.FadeOut:create(0.5)
        self.animTime = self.animTime + 1
        local sequence = cc.Sequence:create(delayAction, action1, action2, cc.CallFunc:create(function() 
            label:removeFromParent()

            self.animTime = self.animTime - 1
            self:updateTime()
        end))
        label:runAction(sequence)
    else
        self.score = self.score + attributes.score
        if self.score >= self.needScore then
            self.pass = true
        end

        local label = ccui.Text:create()
        label:setFontSize(32)
        label:setColor(cc.c3b(255, 255, 255))
        label:enableShadow({r = 0, g = 0, b = 0, a = 255}, {width = 1, height = -1}, 0)
        label:setString("+" .. attributes.score)

        local x, y = self.lbResult:getPosition()
        local pos = self.lbResult:convertToWorldSpace(cc.vertex2F(0, 0))
        x, y = pos.x, pos.y
        label:setPosition(x + 50, y)
        self:addChild(label)

        local delayAction = cc.DelayTime:create(self.animTime)
        local action1 = cc.MoveTo:create(0.5, cc.p(x, y))
        local action2 = cc.FadeOut:create(0.5)
        self.animTime = self.animTime + 1
        local sequence = cc.Sequence:create(delayAction, action1, action2, cc.CallFunc:create(function() 
            label:removeFromParent()

            self.animTime = self.animTime - 1
            self:updateScore(0)
        end))
        label:runAction(sequence)
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
    self:updateTime()
end


return TetrisTimeModePanel

