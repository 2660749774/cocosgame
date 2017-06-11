--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisMeteor2Panel 俄罗斯方块
-- 收集指定颗数星星

local TetrisSinglePanel = import(".TetrisSinglePanel")
local TetrisMeteor2Panel = class("TetrisMeteor2Panel", TetrisSinglePanel)
local TetrisPowerConf = import("..data.TetrisPowerConf")
local Tetris = import (".Tetris")
local RandomUtil = require "core.util.RandomUtil"

--------------------------------
-- 创建方法
-- @function [parent=#TetrisMeteor2Panel] onCreate
function TetrisMeteor2Panel:onCreate(powerId, armyId)
    TetrisSinglePanel.onCreate(self, "layout.TetrisMeteor2")

    -- 对齐
    app:alignLeft(self.leftBg)
    app:alignRight(self.rightBg)

    self.powerId = powerId
    self.armyId = armyId
    self.lbTimeMinute = self.layout['lb_time_minute']
    self.lbTimeSec = self.layout['lb_time_sec']
    self.totalTime = 60 -- 总时间
    self.time = 0

    self.lbResult = self.layout['lb_result']
    self.needScore = 0 -- 需要的分数
    self.scoreNum = 0 -- 当前的分数
    self.displayScore = 0 -- 显示分数

    self:loadConfig(TetrisPowerConf.TYPE_METEOR2, powerId, armyId)

    -- 设置方块
    -- local fangkuaiBg = self.layout['fangkuai_bg']
    -- fangkuaiBg:setTexture("tetris/fangkuai9.png")
    -- local animationLayout = require("layout.TetrisMeteorAnimation").create()
    -- local meteor = animationLayout['root']
    -- local animation = animationLayout['animation']
    -- fangkuaiBg:addChild(meteor)
    -- meteor:runAction(animation)
    -- animation:gotoFrameAndPlay(0)

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
-- @function [parent=#TetrisMeteor2Panel] loadConfig
function TetrisMeteor2Panel:loadConfig(type, powerId, armyId)
    self.conf = TetrisPowerConf.loadDetailConfig(powerId, armyId)
    self.totalTime = self.conf.maxTime
    self.needScore = self.conf.scoreNum
    self.comboNum = self.conf.comboNum
    self.starProb = self.conf.starProb
end

--------------------------------
-- 更新倒计时
-- @function [parent=#TetrisTimeModePanel] onCreate
function TetrisMeteor2Panel:updateTime()
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
function TetrisMeteor2Panel:doUpdate(dt)
    self.time = self.time + dt
    self:updateTime()
end

--------------------------------
-- 更新分数
-- @function [parent=#TetrisMeteor2Panel] updateScoreProgress
function TetrisMeteor2Panel:updateScoreProgress(anim)
    self.lbResult:setString(self.displayScore .. "/" .. self.needScore)

    if anim then
        local action1 = cc.ScaleTo:create(0.5, 2)
        local action2 = cc.ScaleTo:create(0.2, 1)
        local sequence = cc.Sequence:create(action1, delayAction, action2)
        self.lbResult:runAction(sequence)
    end
end

--------------------------------
-- 更新下一个方块
-- @function [parent=#TetrisMeteor2Panel] updateNextBlock
function TetrisMeteor2Panel:updateNextBlock(nextBlock)
    if RandomUtil:nextDouble() < self.starProb then
        local addNum = RandomUtil:nextInt(2)
        for i = 1, addNum do
            if addNum > #nextBlock.blocks then
                break
            end

            -- 添加星星
            local index = RandomUtil:nextInt(#nextBlock.blocks)
            local oldSprite = nextBlock.blocks[index]
            while (oldSprite.hasStar) do
                index = RandomUtil:nextInt(#nextBlock.blocks)
                oldSprite = nextBlock.blocks[index]
            end

            local sprite = cc.Sprite:create("tetris/fangkuai9.png")
            sprite:setAnchorPoint(0, 0)
            sprite:setPosition(oldSprite:getPosition())
            sprite.hasStar = true
            sprite.pic = "tetris/fangkuai9.png"
            
            -- 添加动画
            -- local animationLayout = require("layout.TetrisMeteorAnimation").create()
            -- local meteor = animationLayout['root']
            -- local animation = animationLayout['animation']
            -- sprite.animationObj = meteor
            -- sprite:addChild(meteor)
            -- meteor:runAction(animation)
            -- animation:gotoFrameAndPlay(0)

            oldSprite:removeFromParent()
            nextBlock:addChild(sprite)
            nextBlock.blocks[index] = sprite
        end
    end

    return nextBlock
end

--------------------------------
-- 检查移除的行
-- @function [parent=#TetrisSinglePanel] checkRemoveLines
function TetrisMeteor2Panel:checkRemoveLines(removeBlocks)
    local colsBlockNum = #self.tetris.grids[1]
    local rows = 1
    local cols = 1
    local grids = {}
    for _, block in pairs(removeBlocks) do
        if grids[rows] == nil then
            grids[rows] = {}
        end

        table.insert(grids[rows], block)
        cols = cols + 1
        if cols > colsBlockNum then
            rows = rows + 1
            cols = 1
        end
    end

    -- 分数记录器
    local sprites = {}
    local scoreSprites = {}
    local concatNum = self.comboNum

    -- 横向搜索
    for i = 1, #grids do
        for j = 1, #grids[i] do
            local block = grids[i][j]
            if block.hasStar then
                table.insert(sprites, block)
            else
                if #sprites >= concatNum then
                    for _, block in pairs(sprites) do
                        scoreSprites[block] = 1
                    end
                end
                sprites = {}
            end
        end
        -- 再次检查下
        if #sprites >= concatNum then
            for _, block in pairs(sprites) do
                scoreSprites[block] = 1
            end
        end
        sprites = {}
    end

    -- 最後檢查下
    if #sprites >= concatNum then
        for _, block in pairs(sprites) do
            scoreSprites[block] = 1
        end
    end

    -- 纵向搜索
    sprites = {}
    if #grids >= concatNum then
        for i = 1, colsBlockNum do
            for j = 1, #grids do
                local block = grids[j][i]
                if block.hasStar then
                    table.insert(sprites, block)
                else
                    if #sprites >= concatNum then
                        for _, block in pairs(sprites) do
                            scoreSprites[block] = 1
                        end
                    end
                    sprites = {}
                end
            end
            -- 再次检查下
            if #sprites >= concatNum then
                for _, block in pairs(sprites) do
                    scoreSprites[block] = 1
                end
            end
            sprites = {}
        end
    end

    -- 最後檢查下
    if #sprites >= concatNum then
        for _, block in pairs(sprites) do
            scoreSprites[block] = 1
        end
    end

    -- 没有得分的星星方块处理
    for _, block in pairs(removeBlocks) do
        if block.hasStar and scoreSprites[block] == nil then
            block.hasStar = false
        elseif block.hasStar and scoreSprites[block] ~= nil then
            -- 得分
            self.scoreNum = self.scoreNum + 1
        end
    end

    if self.scoreNum >= self.needScore then
        self.pass = true
    end
    -- log:info("realScore:%s", self.scoreNum)
end

--------------------------------
-- 更新格子视图
-- @function [parent=#TetrisMeteor2Panel] updateGridView
function TetrisMeteor2Panel:updateGridView(grids)
    -- 分数记录器
    local sprites = {}
    local scoreSprites = {}
    local allSprites = {}
    local concatNum = self.comboNum
    local colsBlockNum = #grids[1]

    -- 横向搜索
    for i = 1, #grids do
        for j = 1, #grids[i] do
            local block = grids[i][j]
            if block and block ~= 0 and block.hasStar then
                table.insert(allSprites, block)
                table.insert(sprites, block)
            else
                if #sprites >= concatNum then
                    for _, block in pairs(sprites) do
                        scoreSprites[block] = 1
                    end
                end
                sprites = {}
            end
        end
        -- 再次检查下
        if #sprites >= concatNum then
            for _, block in pairs(sprites) do
                scoreSprites[block] = 1
            end
        end
        sprites = {}
    end

    -- 最後檢查下
    if #sprites >= concatNum then
        for _, block in pairs(sprites) do
            scoreSprites[block] = 1
        end
    end

    -- 纵向搜索
    sprites = {}
    if #grids >= concatNum then
        for i = 1, colsBlockNum do
            for j = 1, #grids do
                local block = grids[j][i]
                if block and block ~= 0 and block.hasStar then
                    table.insert(sprites, block)
                else
                    if #sprites >= concatNum then
                        for _, block in pairs(sprites) do
                            scoreSprites[block] = 1
                        end
                    end
                    sprites = {}
                end
            end
            -- 再次检查下
            if #sprites >= concatNum then
                for _, block in pairs(sprites) do
                    scoreSprites[block] = 1
                end
            end
            sprites = {}
        end
    end

    -- 最後檢查下
    if #sprites >= concatNum then
        for _, block in pairs(sprites) do
            scoreSprites[block] = 1
        end
    end

    -- 没有得分的星星方块处理
    for _, block in pairs(allSprites) do
        if block.animationObj and scoreSprites[block] == nil then
            block.animationObj:removeFromParent()
            block.animationObj = nil
        elseif block.hasStar and scoreSprites[block] ~= nil and block.animationObj == nil then
            -- 添加动画
            local animationLayout = require("layout.TetrisMeteorAnimation").create()
            local meteor = animationLayout['root']
            local animation = animationLayout['animation']
            block.animationObj = meteor
            block:addChild(meteor)
            meteor:runAction(animation)
            animation:gotoFrameAndPlay(0)
        end
    end
end

--------------------------------
-- 更新收集星星个数
-- @function [parent=#TetrisMeteor2Panel] updateFlyStar
function TetrisMeteor2Panel:updateFlyStar()
    self.displayScore = self.displayScore + 1
    self:updateScoreProgress(true)

    -- log:info("displayScore:%s, realScore:%s", self.displayScore, self.scoreNum)
    if self.displayScore >= self.needScore then
        -- 胜利了，该模式下胜利即3颗星星通关
        -- Tips.showSceneTips("恭喜您获胜了！！！", 3)
        self.pass = true
        self.tetris:gameOver()
        self:getScene():pushPanel("Tetris.view.TetrisPowerSucc", {self.powerId, self.armyId, 3, self.removeFangkuaiNum})
    end
end

--------------------------------
-- 游戏结束
-- @function [parent=#TetrisClearStonePanel] notifyGameOver
function TetrisMeteor2Panel:notifyGameOver()
    if self.pass then
        return
    end
    self:getScene():pushPanel("Tetris.view.TetrisPowerFail", {self.powerId, self.armyId, self.scoreNum, self.needScore, self})
end

--------------------------------
-- 重置
-- @function [parent=#TetrisMeteor2Panel] reset
function TetrisMeteor2Panel:reset()
    TetrisSinglePanel.reset(self)

    self.scoreNum = 0
    self.time = 0
    self:updateTime()
    self:updateScoreProgress()
end


return TetrisMeteor2Panel

