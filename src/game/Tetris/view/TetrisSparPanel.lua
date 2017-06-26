--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2017/6/4
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisSparPanel 俄罗斯方块
-- 收集晶石
local TetrisSinglePanel = import(".TetrisSinglePanel")
local TetrisSparPanel = class("TetrisSparPanel", TetrisSinglePanel)
local TetrisPowerConf = import("..data.TetrisPowerConf")
local Tetris = import (".Tetris")
local RandomUtil = require "core.util.RandomUtil"

--------------------------------
-- 创建方法
-- @function [parent=#TetrisSparPanel] onCreate
function TetrisSparPanel:onCreate(powerId, armyId)
    TetrisSinglePanel.onCreate(self, "layout.TetrisSpar")

    -- 对齐
    app:alignLeft(self.leftBg)
    app:alignRight(self.rightBg)

    self.powerId = powerId
    self.armyId = armyId
    self.lbTimeMinute = self.layout['lb_time_minute']
    self.lbTimeSec = self.layout['lb_time_sec']
    self.totalTime = 60 -- 总时间
    self.time = 0
    self.animTime = 0
    

    self.lbResult = self.layout['lb_result']
    self.totalFangkuaiNum = 0 -- 需要收集方块数量
    self.collectFangkuaiNum = 0 -- 已收集方块数量
    self.displayFangkuaiNum = 0 -- 显示已收集方块数量
    self:loadConfig(TetrisPowerConf.TYPE_SPAR, powerId, armyId)
    self.layout['root']:runAction(self.layout['animation'])
    self.layout['animation']:gotoFrameAndPlay(0, true)

    -- 设置方块
    -- local fangkuaiBg = self.layout['fangkuai_bg']
    -- fangkuaiBg:setTexture("tetris/fangkuai11.png")
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
-- 游戏开始
-- @function [parent=#TetrisSparPanel] gameStart
function TetrisSparPanel:gameStart(data)
    log:info("gameStart")
    -- Tips.showSceneTips("游戏开始！！！")

    -- 重置游戏
    self:reset()

    -- 初始化随机数
    RandomUtil:setRandomseed(data.randomseed)

    -- 随机下一块方块
    local nextBlock = self.tetris:createNextBlock()

    -- 处理居中
    local offsetx, offsety = nextBlock:getOffSet()
    nextBlock:setPosition(cc.p(0, -offsety))
    self.nextBg:addChild(nextBlock)

    -- 游戏开始
    self.tetris.isAI = false
    self.tetris:gameStart(self.conf)
end

--------------------------------
-- 载入配置
-- @function [parent=#TetrisSparPanel] loadConfig
function TetrisSparPanel:loadConfig(type, powerId, armyId)
    self.conf = TetrisPowerConf.loadDetailConfig(powerId, armyId)
    self.totalTime = self.conf.maxTime
    self.totalFangkuaiNum = self.conf.collectBlockNum
    self.blockProb = self.conf.blockProb
end


--------------------------------
-- 更新下一个方块
-- @function [parent=#TetrisSparPanel] updateNextBlock
function TetrisSparPanel:updateNextBlock(nextBlock)
    if RandomUtil:nextDouble() < self.blockProb then
        -- 添加晶石
        local index = RandomUtil:nextInt(#nextBlock.blocks)
        local oldSprite = nextBlock.blocks[index]

        local sprite = cc.Sprite:createWithSpriteFrameName("fangkuai11.png")
        sprite:setAnchorPoint(0, 0)
        sprite:setPosition(oldSprite:getPosition())
        sprite.downBlock = true
        sprite.pic = "fangkuai11.png"
        nextBlock.blocks[index] = sprite

        oldSprite:removeFromParent()
        nextBlock:addChild(sprite)
    end

    return nextBlock
end

--------------------------------
-- 更新剩余方块数
-- @function [parent=#TetrisSparPanel] updateScoreProgress
function TetrisSparPanel:updateScoreProgress(anim)
    self.lbResult:setString(self.displayFangkuaiNum .. "/" .. self.totalFangkuaiNum)

    if anim then
        local action1 = cc.ScaleTo:create(0.5, 2)
        local action2 = cc.ScaleTo:create(0.2, 1)
        local sequence = cc.Sequence:create(action1, delayAction, action2)
        self.lbResult:runAction(sequence)
    end
end

--------------------------------
-- 游戏结束
-- @function [parent=#TetrisSparPanel] notifyGameOver
function TetrisSparPanel:notifyGameOver()
    if self.pass then
        return
    end
    self:getScene():pushPanel("Tetris.view.TetrisPowerFail", {self.powerId, self.armyId, self.collectFangkuaiNum, self.totalFangkuaiNum, self})
end

--------------------------------
-- 更新倒计时
-- @function [parent=#TetrisTimeModePanel] onCreate
function TetrisSparPanel:updateTime()
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
-- 每秒帧事件
-- @function [parent=#TetrisTimeModePanel] doUpdate
function TetrisSparPanel:doUpdate(dt)
    self.time = self.time + dt
    self:updateTime()
end

--------------------------------
-- 更新额外属性
-- @function [parent=#TetrisSparPanel] handleExtraAttributes
function TetrisSparPanel:handleExtraAttributes(attributes)
    self.collectFangkuaiNum = self.collectFangkuaiNum + 1
    if self.collectFangkuaiNum >= self.totalFangkuaiNum then
        self.pass = true
    end
    -- log:info("realScore:%s", self.collectFangkuaiNum)
end

--------------------------------
-- 更新收集星星个数
-- @function [parent=#TetrisSparPanel] updateFlyStar
function TetrisSparPanel:updateFlyStar()
    -- 播放动画
    local label = ccui.Text:create()
    label:setFontSize(32)
    label:setColor(cc.c3b(255, 255, 255))
    label:enableShadow({r = 0, g = 0, b = 0, a = 255}, {width = 1, height = -1}, 0)
    label:setString("+".. 1)

    local x, y = self.lbResult:getPosition()
    local pos = self.lbResult:convertToWorldSpace(cc.vertex2F(0, 0))
    x, y = pos.x, pos.y
    label:setPosition(x + 50, y)
    self:addChild(label)

    local delayAction = cc.DelayTime:create(self.animTime)
    local action1 = cc.MoveTo:create(0.5, cc.p(x, y))
    local action2 = cc.FadeOut:create(0.5)
    self.animTime = self.animTime + 1 -- 延迟时间 + 1
    local sequence = cc.Sequence:create(delayAction, action1, action2, cc.CallFunc:create(function() 
        -- 移除自身
        label:removeFromParent()

        -- 增加分数，更新分数显示
        self.displayFangkuaiNum = self.displayFangkuaiNum + 1
        self:updateScoreProgress(true)
        self.animTime = self.animTime - 1
    end))
    label:runAction(sequence)

    -- log:info("displayScore:%s, realScore:%s", self.displayFangkuaiNum, self.collectFangkuaiNum)
    if self.collectFangkuaiNum >= self.totalFangkuaiNum then
        -- 胜利了，该模式下胜利即3颗星星通关
        -- Tips.showSceneTips("恭喜您获胜了！！！", 3)
        self.pass = true
        self.tetris:gameOver()
        self:getScene():pushPanel("Tetris.view.TetrisPowerSucc", {self.powerId, self.armyId, 3, self.collectFangkuaiNum})
    end
end

--------------------------------
-- 重置
-- @function [parent=#TetrisSparPanel] reset
function TetrisSparPanel:reset()
    TetrisSinglePanel.reset(self)

    self.collectFangkuaiNum = 0
    self.time = 0
    self:updateScoreProgress()
end


return TetrisSparPanel

