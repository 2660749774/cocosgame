--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisSinglePanel 俄罗斯方块
local TetrisSinglePanel = class("TetrisSinglePanel", BasePanel)
local Tetris = import (".Tetris")
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
    self.scoreText = self.layout['lb_score']
    -- self.scoreHang = self.layout['lb_hang']
    self.btnPlay = self.layout['btn_play']
    self.btnPause = self.layout['btn_pause']
    self.btnDown = self.layout['btn_down']
    self.btnDownLow = self.layout['btn_down_low']
    self.leftBg = self.layout['lb_left_bg']
    self.rightBg = self.layout['lb_right_bg']
    self.randomCache = {}
    self.removeLineNums = 0
    self.score = 0
    self.playType = 1

    -- 对齐
    app:alignLeft(self.leftBg)
    app:alignRight(self.rightBg)

    local bg = self.layout['tetris_panel']
    self.tetris = Tetris.new(bg, false, true, self)

    self:addChild(self.layout["root"])
    self.scoreText:setString("0")
    self.btnPlay:setVisible(false)
    -- self.scoreHang:setString("0")

    -- 添加事件
    self.btnShift:addClickEventListener(handler(self, self.handleShift))

    self.btnLeft:addClickEventListener(handler(self, self.handleLeft))
    self.btnLeft:addLongPressEventListener(handler(self, self.handleLeft), 0.2)

    self.btnRight:addClickEventListener(handler(self, self.handleRight))
    self.btnRight:addLongPressEventListener(handler(self, self.handleRight), 0.2)

    -- self.btnPlay:addClickEventListener(handler(self, self.playGame))
    self.btnPause:addClickEventListener(handler(self, self.handlePauseGame))

    self.btnDown:addClickEventListener(handler(self, self.handleDown))

    self.btnDownLow:addClickEventListener(handler(self, self.handleDownLow))
    self.btnDownLow:addLongPressEventListener(handler(self, self.handleDownLow), 0.2)

    -- 播放开始动画
    scheduler.performWithDelayGlobal(handler(self, self.playStartAnimation), 1.2)
end

--------------------------------
-- 播放开始动画
-- @function [parent=#TetrisSinglePanel] playGame
function TetrisSinglePanel:playStartAnimation()
    -- 播放动画
    local animationLayout = require("layout.TetrisStartCountAnimation").create()
    animationLayout['panel']:setAnchorPoint(0.5, 0.5)
    animationLayout['panel']:setPosition(display.cx, display.cy)
    self:getScene():addObject(animationLayout['root'], "modal")

    local animation = animationLayout['animation']
    animationLayout['root']:runAction(animation)
    animation:setLastFrameCallFunc(function()
        animationLayout['root']:removeFromParent()
        if self.playType == 1 then
            self:playGame()
        else
            self.tetris:resumeGame()
        end
    end)
    animation:gotoFrameAndPlay(0, false) 
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
    self.tetris:gameStart()
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
        local offsetx, offsety = newNextBlock:getOffSet()
        newNextBlock:setPosition(cc.p(0, -offsety))
        self.nextBg:addChild(newNextBlock)
    end

    -- 按钮状态重置
    self.btnShift.ended = true
    self.btnLeft.ended = true
    self.btnRight.ended = true
    self.btnDownLow.ended = true
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
    -- self.scoreHang:setString(self.removeLineNums)
    self.scoreText:setString(self.score)
end

--------------------------------
-- 清理
-- @function [parent=#TetrisSinglePanel] reset
function TetrisSinglePanel:reset() 
    self.tetris:reset()

    self.nextBg:removeAllChildren()
    self.randomCache = {}
    self.scoreText:setString("0")

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
    -- self.btnPlay:setVisible(true)

    -- self:showHomeBtn(0, 0)
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
-- 处理额外属性
-- @function [parent=#TetrisSinglePanel] handleExtraAttributes
function TetrisSinglePanel:handleExtraAttributes(attributes)

end


--------------------------------
-- 创建返回主页按钮
-- @function [parent=#TetrisSinglePanel] showHomeBtn
function TetrisSinglePanel:showHomeBtn(anchorX, anchorY)
    if self.btnHome ~= nil and not tolua.isnull(self.btnHome) then
        self.btnHome:removeFromParent()
    end

    local scene = self:getScene()
    self.btnHome = ccui.Button:create()
    self.btnHome:addTouchEventListener(self.btnHome.onTouch)
    self.btnHome:setAnchorPoint(anchorX, anchorY)
    self.btnHome:setTitleText("返回主页")
    self.btnHome:setTitleColor(cc.c3b(30, 255, 0))
    self.btnHome:setTitleFontSize(48)
    self.btnHome:addClickEventListener(
        function()
            scene:popPanel(true)
        end
    )
    local x, y = self.btnPlay:getPosition()
    self.btnHome:setPosition(x, y - 100)
    self:addChild(self.btnHome)
end

--------------------------------
-- 卸载资源
-- @function [parent=#TetrisSinglePanel] onExit
function TetrisSinglePanel:onExit()
    -- 卸载资源
    local tipLayer = self:getScene():getLayer("tips")
    tipLayer:removeAllChildren()
end

return TetrisSinglePanel

