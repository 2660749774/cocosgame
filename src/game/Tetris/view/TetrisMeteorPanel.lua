--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisMeteorPanel 俄罗斯方块
-- 指定块数内清理障碍
local TetrisSinglePanel = import(".TetrisSinglePanel")
local TetrisMeteorPanel = class("TetrisMeteorPanel", TetrisSinglePanel)
local TetrisPowerConf = import("..data.TetrisPowerConf")
local Tetris = import (".Tetris")
local RandomUtil = require "core.util.RandomUtil"

--------------------------------
-- 创建方法
-- @function [parent=#TetrisMeteorPanel] onCreate
function TetrisMeteorPanel:onCreate(powerId, armyId)
    TetrisSinglePanel.onCreate(self, "layout.TetrisMeteor")

    -- 对齐
    app:alignLeft(self.leftBg)
    app:alignRight(self.rightBg)

    self.powerId = powerId
    self.armyId = armyId
    self.lbLeftBlockNum = self.layout['lb_left_line']
    self.totalBlockNum = 0
    self.blockNum = 0

    self.lbResult = self.layout['lb_result']
    self.totalFangkuaiNum = 0 -- 总方块数量
    self.removeFangkuaiNum = 0 -- 已消除方块数量

    self:loadConfig(TetrisPowerConf.TYPE_METEOR, powerId, armyId)

    -- 设置方块
    local fangkuaiBg = self.layout['fangkuai_bg']
    fangkuaiBg:initWithSpriteFrameName("fangkuai9.png")
    local animationLayout = require("layout.TetrisMeteorAnimation").create()
    local meteor = animationLayout['root']
    local animation = animationLayout['animation']
    fangkuaiBg:addChild(meteor)
    meteor:runAction(animation)
    animation:gotoFrameAndPlay(0)

    self:updateBlockNum()
end

--------------------------------
-- 游戏开始
-- @function [parent=#TetrisMeteorPanel] gameStart
function TetrisMeteorPanel:gameStart(data)
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
    self.tetris:gameStart(0, self.conf)
end

--------------------------------
-- 载入配置
-- @function [parent=#TetrisMeteorPanel] loadConfig
function TetrisMeteorPanel:loadConfig(type, powerId, armyId)
    self.conf = TetrisPowerConf.loadDetailConfig(powerId, armyId)
    self.totalBlockNum = self.conf.maxBlockNum

    -- 统计方块数量
    local blockArray = self.conf.blockArray
    for i = 1, #blockArray do
        for j = 1, #blockArray[i] do
            if blockArray[i][j] == 2 then
                self.totalFangkuaiNum = self.totalFangkuaiNum + 1
            end
        end
    end
end

--------------------------------
-- 更新剩余方块数
-- @function [parent=#TetrisMeteorPanel] roundStart
function TetrisMeteorPanel:updateBlockNum()
    local blockNum = self.totalBlockNum - self.blockNum
    if blockNum <= 0 and self.removeFangkuaiNum ~= self.totalFangkuaiNum then
        self.tetris:gameOver()
        blockNum = 0
    end
    self.lbLeftBlockNum:setString(blockNum)
    self.lbResult:setString(self.removeFangkuaiNum .. "/" .. self.totalFangkuaiNum)
end

--------------------------------
-- 更新分数
-- @function [parent=#TetrisMeteorPanel] updateScore
function TetrisMeteorPanel:updateScore(removeLineNums)
    --TetrisSinglePanel.updateScore(self, removeLineNums)
    self.blockNum =  self.blockNum + 1

   
    -- 判断是否胜利
    local flyStarNum = 0
    local grids = self.tetris.grids
    for i = 1, #grids do
        for j = 1, #grids[i] do
            if grids[i][j] ~= nil and grids[i][j] ~= 0 then
                local block = grids[i][j]
                if block.confBlock ~= nil and block.hasStar then
                    flyStarNum = flyStarNum + 1
                end
            end
        end
    end

    self:updateBlockNum()
    if flyStarNum > 0 then
        return
    end
    
    -- 胜利了，该模式下胜利即3颗星星通关
    -- Tips.showSceneTips("恭喜您获胜了！！！", 3)
    self.pass = true
    self.tetris:gameOver()
    self:getScene():pushPanel("Tetris.view.TetrisPowerSucc", {self.powerId, self.armyId, 3, self.removeFangkuaiNum})
end

--------------------------------
-- 更新收集星星个数
-- @function [parent=#TetrisMeteorPanel] updateFlyStar
function TetrisMeteorPanel:updateFlyStar()
    self.removeFangkuaiNum = self.removeFangkuaiNum + 1
    self.lbResult:setString(self.removeFangkuaiNum .. "/" .. self.totalFangkuaiNum)
end

--------------------------------
-- 游戏结束
-- @function [parent=#TetrisClearStonePanel] notifyGameOver
function TetrisMeteorPanel:notifyGameOver()
    if self.pass then
        return
    end
    self:getScene():pushPanel("Tetris.view.TetrisPowerFail", {self.powerId, self.armyId, self.removeFangkuaiNum, self.totalFangkuaiNum, self})
end

--------------------------------
-- 重置
-- @function [parent=#TetrisMeteorPanel] reset
function TetrisMeteorPanel:reset()
    TetrisSinglePanel.reset(self)

    self.blockNum = 0
    self:updateBlockNum()
end


return TetrisMeteorPanel

