--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisMultiPanel 俄罗斯方块
local TetrisMultiPanel = class("TetrisMultiPanel", BasePanel)
local Tetris = import (".Tetris")
local RandomUtil = require "core.util.RandomUtil"

--------------------------------
-- 创建方法
-- @function [parent=#TetrisMultiPanel] onCreate
function TetrisMultiPanel:onCreate(host)
    local layout = require("layout.TetrisScene_Net").create()
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
    self.lbPing = layout['lb_ping']
    self.randomCache = {}
    self.removeLineNums = 0
    self.pingSeq = 0
    self.pingTime = 0


    local targetBg = layout['tetris_panel_target']
    targetBg:setFlippedY(true)
    self.targetTetris = Tetris.new(targetBg, true, false, self)

    local bg = layout['tetris_panel_self']
    self.tetris = Tetris.new(bg, true, true, self)


    self:addChild(layout["root"])
    self.scoreText:setString("0")
    self.scoreHang:setString("0")
    self.lbPing:setString("")

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

    self.pingScheduler = scheduler.scheduleGlobal(handler(self, self.handlePing), 2)

    self.pushHandler = handler(self, self.handlePush)
    self.connHandler = handler(self, self.handleConnectEvent)

    -- 进行连接
    cmgr:addConnCallback(self.connHandler)
    -- 添加PushHandler
    cmgr:addPushCallback(actions.PUSH_FIGHT, self.pushHandler)

    cmgr:open(host, 8010)
    Tips.showSceneTips("正在连接服务器...", -1)
end

--------------------------------
-- 处理连接事件
-- @function [parent=#TetrisMultiPanel] handleConnectEvent
function TetrisMultiPanel:handleConnectEvent(event)
    if event.type == "conn" then
        if event.status == "fail" then
            Tips.showSceneTips("不能建立与服务器的连接(～ o ～)~zZ", 2)
            self:showHomeBtn(0, 0)
        elseif event.status == "succ" then
            Tips.showSceneTips("连接服务器成功", 1)
        end


    elseif event.type == "close" then
        if event.status == "succ" then
            Tips.showSceneTips("与服务器断开连接", -1)
        end
    end
end

--------------------------------
-- 获取玩家信息回调
-- @function [parent=#TetrisMultiPanel] onGetPlayerInfo
function TetrisMultiPanel:onGetPlayerInfo(response)
    if response.state == 1 then
        self.playerId = response.data.playerId
        cmgr:send(actions.quitFight)
        cmgr:send(actions.joinFight)
    end
end

--------------------------------
-- 处理推送
-- @function [parent=#TetrisMultiPanel] handlePush
function TetrisMultiPanel:handlePush(response)
    if tolua.isnull(self) then
        return
    end

    if response.data.schedule ~= nil then
        if response.data.schedule.def == nil then
            self.targetTetris.isAI = true
        end
        cmgr:send(actions.readyFight)
    elseif response.data.event then
        event = response.data.event
        self.frameNum = event.frameNum
        self.tetris:updateServerFrameNum(self.frameNum)
        if self.targetTetris then
            self.targetTetris:updateServerFrameNum(self.frameNum)
        end

        if not event.protos then
            return
        end
        for _, data in pairs(event.protos) do
            if data.protoId == protos.KEY_PRESS then
                if data.playerId == self.playerId then
                    self.tetris:addServerFrame(self.frameNum, data)
                else
                    self.targetTetris:addServerFrame(self.frameNum, data)
                end
            elseif data.protoId == protos.FIGHT_START then
                -- 战斗开始协议
                self:gameStart(data)
            elseif data.protoId == protos.REMOVE_LINES then
                -- 增加行数
                if not data.isAI and data.playerId == self.playerId then
                    self.targetTetris:addServerFrame(self.frameNum, data)
                else
                    self.tetris:addServerFrame(self.frameNum, data)
                end
            end
        end
    end
end

--------------------------------
-- 点击开始游戏
-- @function [parent=#TetrisMultiPanel] playGame
function TetrisMultiPanel:playGame()
    if not cmgr:isConnected() then
        Tips.showSceneTips("与服务器连接失败", 1)
        return
    end
    -- 登录用户
    cmgr:send(actions.getPlayerInfo, handler(self, self.onGetPlayerInfo))

    Tips.showSceneTips("等待其他玩家加入", -1)
end

--------------------------------
-- 游戏开始
-- @function [parent=#TetrisMultiPanel] gameStart
function TetrisMultiPanel:gameStart(data)
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
    self.tetris:gameStart()
    if self.targetTetris then
        self.targetTetris:gameStart()
    end
end

--------------------------------
-- 回合开始
-- @function [parent=#TetrisMultiPanel] roundStart
function TetrisMultiPanel:roundStart(oldNextBlock, newNextBlock)
    -- 移除之前的方块
    if oldNextBlock then
        self.nextBg:removeChild(oldNextBlock)
    end

    -- 显示下一个方块
    local offsetx, offsety = newNextBlock:getOffSet()
    newNextBlock:setPosition(cc.p(0, -offsety))
    self.nextBg:addChild(newNextBlock)

    -- 解除长按状态
    if self.tetris.btnDownLowLongPress then
        cmgr:send(actions.doUpdate, nil, protos.KEY_PRESS, self.tetris:getLocalFrameNum(), 52)
    end

    -- 按钮状态重置
    self.btnShift.ended = true
    self.btnLeft.ended = true
    self.btnRight.ended = true
    self.btnDownLow.ended = true
end

--------------------------------
-- 更新分数
-- @function [parent=#TetrisMultiPanel] roundStart
function TetrisMultiPanel:updateScore(removeLineNums)
    self.removeLineNums = self.removeLineNums + removeLineNums
    self.scoreHang:setString(self.removeLineNums)
    self.scoreText:setString(self.removeLineNums * 10)

    -- 通知服务器
    cmgr:send(actions.doUpdate, nil, protos.REMOVE_LINES, self.tetris:getLocalFrameNum(), removeLineNums)
end

--------------------------------
-- 清理
-- @function [parent=#TetrisMultiPanel] reset
function TetrisMultiPanel:reset() 
    self.tetris:reset()
    if self.targetTetris then
        self.targetTetris:reset()
    end
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
-- @function [parent=#TetrisMultiPanel] reset
function TetrisMultiPanel:notifyGameOver(isSelf)
    if isSelf then
        self.btnPlay:setVisible(true)

        self:showHomeBtn(0, 0)
    end
end

--------------------------------
-- 处理翻转
-- @function [parent=#TetrisMultiPanel] handleShift
function TetrisMultiPanel:handleShift(event, keyCode)
    self.tetris:handleShift(event, keyCode)
end

--------------------------------
-- 处理左移动
-- @function [parent=#TetrisMultiPanel] handleLeft
function TetrisMultiPanel:handleLeft(event, keyCode)
    self.tetris:handleLeft(event, keyCode)
end

--------------------------------
-- 处理右移动
-- @function [parent=#TetrisMultiPanel] handleRight
function TetrisMultiPanel:handleRight(event, keyCode)
    self.tetris:handleRight(event, keyCode)
end

--------------------------------
-- 处理极速下降
-- @function [parent=#TetrisMultiPanel] handleDown
function TetrisMultiPanel:handleDown(event, keyCode)
    self.tetris:handleDown(event, keyCode)
end

--------------------------------
-- 处理加速下降
-- @function [parent=#TetrisMultiPanel] handleDownLow
function TetrisMultiPanel:handleDownLow(event, keyCode)
    self.tetris:handleDownLow(event, keyCode)
end

--------------------------------
-- 获取随机数
-- @function [parent=#TetrisMultiPanel] nextInt
function TetrisMultiPanel:nextInt(range, times)
    if self.randomCache[times] then
        return self.randomCache[times]
    end
    self.randomCache[times] = RandomUtil:nextInt(range)
    return self.randomCache[times]
end

--------------------------------
-- 创建返回主页按钮
-- @function [parent=#TetrisMultiPanel] showHomeBtn
function TetrisMultiPanel:showHomeBtn(anchorX, anchorY)
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
-- 处理ping值
-- @function [parent=#TetrisMultiPanel] handlePing
function TetrisMultiPanel:handlePing()
    self.pingSeq = self.pingSeq + 1
    self.pingTime = cc.Util:getCurrentTime()
    cmgr:send(actions.ping, handler(self, self.handlePingCallback), self.pingSeq)
end

--------------------------------
-- 处理ping值服务器返回
-- @function [parent=#TetrisMultiPanel] handlePingCallback
function TetrisMultiPanel:handlePingCallback(response)
    if response.data.seq == self.pingSeq then
        local delay = cc.Util:getCurrentTime() - self.pingTime
        self.lbPing:setString("ping: " .. tostring(delay))
    end
end


--------------------------------
-- 卸载资源
-- @function [parent=#TetrisMultiPanel] onExit
function TetrisMultiPanel:onExit()
    -- 卸载资源
    log:info("TetrisMultiPanel onExit")
    cmgr:removePushCallback(self.pushHandler)
    cmgr:removeConnCallback(self.connHandler)
    local tipLayer = self:getScene():getLayer("tips")
    tipLayer:removeAllChildren()
    scheduler.unscheduleGlobal(self.pingScheduler)

    -- 移除定时器
    self.tetris:onExit()
    self.targetTetris:onExit()
end

return TetrisMultiPanel

