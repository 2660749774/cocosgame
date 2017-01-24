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
function TetrisSinglePanel:onCreate()
    local layout = require("layout.TetrisScene").create()
    self:fixLayout(layout)
    
    self.btnLeft = layout['btn_left']
    self.btnShift = layout['btn_shift']
    self.btnRight = layout['btn_right']
    self.nextBg = layout['next_bg']
    self.scoreText = layout['lb_score']
    self.scoreHang = layout['lb_hang']
    self.btnPlay = layout['btn_play']
    self.btnDown = layout['btn_down']
    self.btnDownLow = layout['btn_down_low']
    self.randomCache = {}
    self.removeLineNums = 0

    local bg = layout['tetris_bg']
    self.tetris = Tetris.new(bg, false, true, self)

    self:addChild(layout["root"])
    self.scoreText:setString("0")
    self.scoreHang:setString("0")

    -- 添加事件
    self.btnShift:addClickEventListener(handler(self, self.handleShift))

    self.btnLeft:addClickEventListener(handler(self, self.handleLeft))
    self.btnLeft:addLongPressEventListener(handler(self, self.handleLeft), 0.2)

    self.btnRight:addClickEventListener(handler(self, self.handleRight))
    self.btnRight:addLongPressEventListener(handler(self, self.handleRight), 0.2)

    self.btnPlay:addClickEventListener(handler(self, self.playGame))

    self.btnDown:addClickEventListener(handler(self, self.handleDown))

    self.btnDownLow:addClickEventListener(handler(self, self.handleDownLow))
    self.btnDownLow:addLongPressEventListener(handler(self, self.handleDownLow), 0.2)
end


--------------------------------
-- 点击开始游戏
-- @function [parent=#TetrisSinglePanel] playGame
function TetrisSinglePanel:playGame()
    self:gameStart({randomseed=tonumber(tostring(os.time()):reverse():sub(1,6))})
end

--------------------------------
-- 游戏开始
-- @function [parent=#TetrisSinglePanel] gameStart
function TetrisSinglePanel:gameStart(data)
    log:info("gameStart")
    Tips.showSceneTips("游戏开始！！！")

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
    local offsetx, offsety = newNextBlock:getOffSet()
    newNextBlock:setPosition(cc.p(0, -offsety))
    self.nextBg:addChild(newNextBlock)

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
    self.removeLineNums = self.removeLineNums + removeLineNums
    self.scoreHang:setString(self.removeLineNums)
    self.scoreText:setString(self.removeLineNums * 10)
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
    self.btnPlay:setVisible(true)

    self:showHomeBtn(0, 0)
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

