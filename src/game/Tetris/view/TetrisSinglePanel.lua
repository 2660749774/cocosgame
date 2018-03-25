--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisSinglePanel 俄罗斯方块
local TetrisSinglePanel = class("TetrisSinglePanel", BasePanel)
local Tetris = import (".TetrisNew")
local RandomUtil = require "core.util.RandomUtil"


--------------------------------
-- 创建方法
-- @function [parent=#TetrisSinglePanel] onCreate
function TetrisSinglePanel:onCreate(layout)
    self.layout = require(layout).create()
    self:fixLayout(self.layout)
    
    self.btnLeft = self.layout['btn_left']
    self.btnShift = self.layout['btn_shift']
    self.btnRight = self.layout['btn_right']
    self.nextBg = self.layout['next_bg']
    self.btnPause = self.layout['btn_pause']
    self.btnDown = self.layout['btn_down']
    self.btnDownLow = self.layout['btn_down_low']
    self.leftBg = self.layout['lb_left_bg']
    self.rightBg = self.layout['lb_right_bg']
    self.lbArmyNum = self.layout['lb_armynum']
    self.randomCache = {}
    self.removeLineNums = 0
    self.score = 0
    self.playType = 1
    self.buyTimes = 0

    -- 对齐
    app:alignLeft(self.leftBg)
    app:alignRight(self.rightBg)

    local bg = self.layout['tetris_panel']
    self.tetris = Tetris.new(bg, false, true, self)

    self:addChild(self.layout["root"])

    -- 添加事件
    self.btnShift.playSoundEffect = false
    self.btnShift:addClickEventListener(handler(self, self.handleShift))

    self.btnLeft:addClickEventListener(handler(self, self.handleLeft))
    self.btnLeft:addLongPressEventListener(handler(self, self.handleLeft), 0.2)

    self.btnRight:addClickEventListener(handler(self, self.handleRight))
    self.btnRight:addLongPressEventListener(handler(self, self.handleRight), 0.2)

    self.btnPause:addClickEventListener(handler(self, self.handlePauseGame))

    self.btnDown:addClickEventListener(handler(self, self.handleDown))

    self.btnDownLow:addClickEventListener(handler(self, self.handleDownLow))
    self.btnDownLow:addLongPressEventListener(handler(self, self.handleDownLow), 0.2)

    -- 播放开始动画
    scheduler.performWithDelayGlobal(handler(self, self.playStartAnimation), 1.2)

    -- 播放背景音乐
    amgr:playBgMusic({"power_bg1.mp3", "power_bg2.mp3", "power_bg3.mp3"}, true)
end

--------------------------------
-- 播放开始动画
-- @function [parent=#TetrisSinglePanel] playGame
function TetrisSinglePanel:playStartAnimation()
    -- 播放动画
    if self.playType == 1 then
        self:getScene():pushPanel("Tetris.view.TetrisPowerStartIntro", {self.powerId, self.armyId, function()
            self:playGame()
        end})
    else
        local animationLayout = require("layout.TetrisStartCountAnimation").create()
        animationLayout['panel']:setAnchorPoint(0.5, 0.5)
        animationLayout['panel']:setPosition(display.cx, display.cy)
        self:getScene():addObject(animationLayout['root'], "modal")

        local animation = animationLayout['animation']
        animationLayout['root']:runAction(animation)
        animation:setLastFrameCallFunc(function()
            animationLayout['root']:removeFromParent()
            self.tetris:resumeGame()
        end)
        animation:gotoFrameAndPlay(0, false) 
    end
    
end


--------------------------------
-- 点击开始游戏
-- @function [parent=#TetrisSinglePanel] playGame
function TetrisSinglePanel:playGame()
    self:reset()
    self:gameStart({randomseed=tonumber(tostring(os.time()):reverse():sub(1,6))})
end

--------------------------------
-- 暂停游戏
-- @function [parent=#TetrisSinglePanel] pauseGame
function TetrisSinglePanel:handlePauseGame()
    self:pauseGame()
    self:getScene():pushPanel("Tetris.view.TetrisPowerPause", {self})
end

function TetrisSinglePanel:pauseGame()
    self.tetris:pauseGame()
end

function TetrisSinglePanel:resumeGame()
    self.playType = 2
    scheduler.performWithDelayGlobal(handler(self, self.playStartAnimation), 0.5)
end

function TetrisSinglePanel:quitGame()
    log:info("quitGame")
    -- 退出游戏
    self:getScene():popPanel()
end

--------------------------------
-- 游戏开始
-- @function [parent=#TetrisSinglePanel] gameStart
function TetrisSinglePanel:gameStart(data)
    log:info("gameStart")
    -- Tips.showSceneTips("游戏开始！！！")

    -- 重置游戏
    self:reset()

    -- -- 随机下一块方块
    -- local nextBlock = self.tetris:createNextBlock()

    -- -- 处理居中
    -- local offsetx, offsety = nextBlock:getOffSet()
    -- nextBlock:setPosition(cc.p(0, -offsety))
    -- self.nextBg:addChild(nextBlock)

    -- 游戏开始
    -- self.tetris.isAI = false
    self.tetris:gameStart(0, nil, data.randomseed)
end

--------------------------------
-- 回合开始
-- @function [parent=#TetrisSinglePanel] roundStart
function TetrisSinglePanel:roundStart(oldNextBlock, newNextBlock)
    -- 移除之前的方块
    if oldNextBlock then
        self.nextBg:removeChild(oldNextBlock)
    end

    -- 显示下一个方块
    if newNextBlock then
        -- local offsetx, offsety = newNextBlock:getOffSet()
        -- newNextBlock:setPosition(cc.p(0, -offsety))
        self.nextBg:addChild(newNextBlock)
    end

    -- 按钮状态重置
    self.btnShift.ended = true
    self.btnLeft.ended = true
    self.btnRight.ended = true
    self.btnDownLow.ended = true
end

--------------------------------
-- 更新方块数
-- @function [parent=#TetrisSinglePanel] updateBlockNum
function TetrisSinglePanel:updateBlockNum()
end

--------------------------------
-- 更新时间
-- @function [parent=#TetrisSinglePanel] doUpdate
function TetrisSinglePanel:doUpdate(dt)
    return
end

--------------------------------
-- 更新分数
-- @function [parent=#TetrisSinglePanel] updateScore
function TetrisSinglePanel:updateScore(removeLineNums)
    if removeLineNums == 1 then
        self.score = self.score + 40
    elseif removeLineNums == 2 then
        self.score = self.score + 100
    elseif removeLineNums == 3 then
        self.score = self.score + 300
    elseif removeLineNums == 4 then
        self.score = self.score + 1200
    end
    self.removeLineNums = self.removeLineNums + removeLineNums
end

--------------------------------
-- 计算消除分数
-- @function [parent=#TetrisSinglePanel] calcPoints
function TetrisSinglePanel:calcPoints(removeLineNums)
    local score = 0
    if removeLineNums == 1 then
        score = score + 40
    elseif removeLineNums == 2 then
        score = score + 100
    elseif removeLineNums == 3 then
        score = score + 300
    elseif removeLineNums == 4 then
        score = score + 1200
    end

    return score
end

--------------------------------
-- 清理
-- @function [parent=#TetrisSinglePanel] reset
function TetrisSinglePanel:reset() 
    self.tetris:reset()

    self.nextBg:removeAllChildren()
    self.randomCache = {}

    if self.btnHome then
        if not tolua.isnull(self.btnHome) then
            self.btnHome:removeFromParent()
        end
        self.btnHome = nil
    end
end

--------------------------------
-- 通知比赛结束
-- @function [parent=#TetrisSinglePanel] reset
function TetrisSinglePanel:notifyGameOver(isSelf)
end

--------------------------------
-- 重新开始
-- @function [parent=#TetrisSinglePanel] restartGame
function TetrisSinglePanel:restartGame()
    self.playType = 1
    scheduler.performWithDelayGlobal(handler(self, self.playStartAnimation), 0.5)
end

--------------------------------
-- 处理翻转
-- @function [parent=#TetrisSinglePanel] handleShift
function TetrisSinglePanel:handleShift(event, keyCode)
    self.tetris:handleShift(event, keyCode)

    -- 播放音效
    amgr:playEffect("rotation.wav")
end

--------------------------------
-- 处理左移动
-- @function [parent=#TetrisSinglePanel] handleLeft
function TetrisSinglePanel:handleLeft(event, keyCode)
    self.tetris:handleLeft(event, keyCode)
end

--------------------------------
-- 处理右移动
-- @function [parent=#TetrisSinglePanel] handleRight
function TetrisSinglePanel:handleRight(event, keyCode)
    self.tetris:handleRight(event, keyCode)
end

--------------------------------
-- 处理极速下降
-- @function [parent=#TetrisSinglePanel] handleDown
function TetrisSinglePanel:handleDown(event, keyCode)
    self.tetris:handleDown(event, keyCode)

    -- 播放下落音效
    amgr:playEffect("block_down.wav")
end

--------------------------------
-- 处理加速下降
-- @function [parent=#TetrisSinglePanel] handleDownLow
function TetrisSinglePanel:handleDownLow(event, keyCode)
    self.tetris:handleDownLow(event, keyCode)
end

--------------------------------
-- 获取随机数
-- @function [parent=#TetrisSinglePanel] nextInt
function TetrisSinglePanel:nextInt(range, times)
    if self.randomCache[times] then
        return self.randomCache[times]
    end
    self.randomCache[times] = RandomUtil:nextInt(range)
    return self.randomCache[times]
end

--------------------------------
-- 获取購買花費
-- @function [parent=#TetrisSinglePanel] calcBuyCost
function TetrisSinglePanel:calcBuyCost()
    return 10 + self.buyTimes * 5
end

--------------------------------
-- 更新下一个Block
-- @function [parent=#TetrisSinglePanel] updateNextBlock
function TetrisSinglePanel:updateNextBlock(nextBlock)
    return nextBlock
end

--------------------------------
-- 检查移除的行
-- @function [parent=#TetrisSinglePanel] checkRemoveLines
function TetrisSinglePanel:checkRemoveLines(removeBlocks)
    return
end

--------------------------------
-- 更新显示
-- @function [parent=#TetrisSinglePanel] updateGridView
function TetrisSinglePanel:updateGridView(grids)
    return
end

--------------------------------
-- 处理额外属性
-- @function [parent=#TetrisSinglePanel] handleExtraAttributes
function TetrisSinglePanel:handleExtraAttributes(attributes)

end

--------------------------------
-- 卸载资源
-- @function [parent=#TetrisSinglePanel] onExit
function TetrisSinglePanel:onExit()
    -- 卸载资源
    local tipLayer = self:getScene():getLayer("tips")
    tipLayer:removeAllChildren()

    if self.tetris then
        self.tetris:onExit()
    end
end

return TetrisSinglePanel

