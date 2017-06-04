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
    self.lbLeftBlockNum = self.layout['lb_left_line']
    self.totalBlockNum = 0
    self.blockNum = 0

    self.lbResult = self.layout['lb_result']
    self.totalFangkuaiNum = 0 -- 需要收集方块数量
    self.collectFangkuaiNum = 0 -- 已收集方块数量
    self.displayFangkuaiNum = 0 -- 显示已收集方块数量
    self:loadConfig(TetrisPowerConf.TYPE_SPAR, powerId, armyId)

    -- 设置方块
    local pic = string.format("tetris/%s.png", self.conf.blockType)
    local fangkuaiBg = self.layout['fangkuai_bg']
    fangkuaiBg:setTexture(pic)

    self:updateBlockNum()
end

--------------------------------
-- 游戏开始
-- @function [parent=#TetrisSparPanel] gameStart
function TetrisSparPanel:gameStart(data)
    log:info("gameStart")
    -- Tips.showSceneTips("游戏开始！！！")

    -- 重置游戏
    self.btnPlay:setVisible(false)
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
    self.totalBlockNum = self.conf.maxBlockNum
    self.totalFangkuaiNum = self.conf.collectBlockNum
    self.blockProb = self.conf.blockProb
end


--------------------------------
-- 更新下一个方块
-- @function [parent=#TetrisSparPanel] updateNextBlock
function TetrisSparPanel:updateNextBlock(nextBlock)
    if RandomUtil:nextDouble() < self.blockProb then
        local label = ccui.Text:create()
        label:setFontSize(20)
        label:enableShadow({r = 0, g = 0, b = 0, a = 255}, {width = 1, height = -1}, 0)
        local index = RandomUtil:nextInt(#nextBlock.blocks)

        nextBlock.blocks[index].downBlock = true
        nextBlock.blocks[index].pic = nextBlock.pic
        log:info("add downblock sprite:%s, downblock:%s", nextBlock.blocks[index], nextBlock.blocks[index].downBlock)
        -- nextBlock.blocks[index].extraAttributes = true
        label:setString("晶")
        label:setPosition(13.5, 13.5)
        nextBlock.blocks[index]:addChild(label)
    end

    return nextBlock
end

--------------------------------
-- 更新剩余方块数
-- @function [parent=#TetrisSparPanel] roundStart
function TetrisSparPanel:updateBlockNum()
    local blockNum = self.totalBlockNum - self.blockNum
    if blockNum <= 0 then
        self.tetris:gameOver()
        blockNum = 0
    end
    self.lbLeftBlockNum:setString(blockNum)
    self.lbResult:setString(self.displayFangkuaiNum .. "/" .. self.totalFangkuaiNum)
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
-- 更新分数
-- @function [parent=#TetrisSparPanel] updateScore
function TetrisSparPanel:updateScore(removeLineNums)
    self.blockNum =  self.blockNum + 1
    self:updateBlockNum()
end

--------------------------------
-- 更新额外属性
-- @function [parent=#TetrisSparPanel] handleExtraAttributes
function TetrisSparPanel:handleExtraAttributes(attributes)
    self.collectFangkuaiNum = self.collectFangkuaiNum + 1
    if self.collectFangkuaiNum >= self.totalFangkuaiNum then
        self.pass = true
    end
    log:info("realSocre:%s", self.collectFangkuaiNum)
end

--------------------------------
-- 更新收集星星个数
-- @function [parent=#TetrisSparPanel] updateFlyStar
function TetrisSparPanel:updateFlyStar()
    self.displayFangkuaiNum = self.displayFangkuaiNum + 1

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

    local action1 = cc.MoveTo:create(0.5, cc.p(x, y))
    local action2 = cc.FadeOut:create(0.5)
    local sequence = cc.Sequence:create(action1, action2, cc.CallFunc:create(function() 
        label:removeFromParent()
        self:updateBlockNum()
    end))
    label:runAction(sequence)

    log:info("displayScore:%s, realScore:%s", self.displayFangkuaiNum, self.collectFangkuaiNum)
    if self.displayFangkuaiNum >= self.totalFangkuaiNum then
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

    self.blockNum = 0
    self.collectFangkuaiNum = 0
    self:updateBlockNum()
end


return TetrisSparPanel

