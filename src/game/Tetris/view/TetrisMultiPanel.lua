--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisMultiPanel 俄罗斯方块
local TetrisMultiPanel = class("TetrisMultiPanel", BasePanel)
local Tetris = import (".Tetris")

--------------------------------
-- 创建方法
-- @function [parent=#TetrisMultiPanel] onCreate
function TetrisMultiPanel:onCreate(scheduleData)
    local layout = require("layout.TetrisScene_Net").create()
    self:fixLayout(layout)
    
    -- 按钮相关
    self.btnLeft = layout['btn_left']
    self.btnShift = layout['btn_shift']
    self.btnRight = layout['btn_right']
    self.btnDown = layout['btn_down']
    self.btnDownLow = layout['btn_down_low']
    self.random = require("core.util.Random").new()

    -- 信息部分
    self.scheduleData = scheduleData
    self.playerInfo = {}
    self.targetPlayerInfo = {}
    
    self:initPlayerInfo(layout, self.playerInfo, "_self")
    self:initPlayerInfo(layout, self.targetPlayerInfo, "_target")
    app:alignLeft(layout['player_panel_self'])
    app:alignRight(layout['player_panel_target'])
   
    -- ping相关
    self.lbPing = layout['lb_ping']
    self.randomCache = {}
    self.removeLineNums = 0
    self.pingSeq = 0
    self.pingTime = 0
    self.host = host

    -- 初始化游戏块
    local targetBg = layout['tetris_panel_target']
    self.targetTetris = Tetris.new(targetBg, true, false, self)

    local bg = layout['tetris_panel_self']
    self.tetris = Tetris.new(bg, true, true, self)

    -- 重置一下
    self:reset(true)

    self:addChild(layout["root"])

    -- 添加事件
    self.btnShift:addClickEventListener(handler(self, self.handleShift))

    self.btnLeft:addClickEventListener(handler(self, self.handleLeft))
    self.btnLeft:addLongPressEventListener(handler(self, self.handleLeft), 0.2)

    self.btnRight:addClickEventListener(handler(self, self.handleRight))
    self.btnRight:addLongPressEventListener(handler(self, self.handleRight), 0.2)

    self.btnDown:addClickEventListener(handler(self, self.handleDown))

    self.btnDownLow:addClickEventListener(handler(self, self.handleDownLow))
    self.btnDownLow:addLongPressEventListener(handler(self, self.handleDownLow), 0.2)

    self.pingScheduler = scheduler.scheduleGlobal(handler(self, self.handlePing), 2)

    self.pushHandler = handler(self, self.handlePush)

    -- 添加PushHandler
    cmgr:addPushCallback(actions.PUSH_FIGHT, self.pushHandler)

    -- 播放开始动画
    scheduler.performWithDelayGlobal(handler(self, self.playStartAnimation), 1.2)

    -- 播放背景音乐
    amgr:playBgMusic({"power_bg1.mp3", "power_bg2.mp3", "power_bg3.mp3"}, true)
end

--------------------------------
-- 播放开始动画
-- @function [parent=#TetrisMultiPanel] playStartAnimation
function TetrisMultiPanel:playStartAnimation()
    -- 播放开始动画
    self:getScene():pushPanel("Tetris.view.TetrisPvpStartIntro", {self.scheduleData, function()
        self:playGame()
    end})
end

--------------------------------
-- 初始化玩家数据
-- @function [parent=#TetrisMultiPanel] initPlayerInfo
function TetrisMultiPanel:initPlayerInfo(layout, playerInfo, suffix)
    playerInfo.lbPlayerName = layout['lb_player_name' .. suffix]
    playerInfo.lbPlayerScore = layout['lb_player_score' .. suffix]

    playerInfo.lbScore = layout['lb_score' .. suffix]
    playerInfo.score = 0

    playerInfo.nextBg = layout['next_bg' .. suffix]
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
        -- self:updatePlayerInfo(self.playerInfo, response.data)

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

    if response.data.event then
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
            elseif data.protoId == protos.DEAD then
                -- 比赛结束
                self:gameOver(data)
            end
        end
    elseif response.data.result then
        -- 结果更新
        self:showFightResult(response.data.result)
    end
end

--------------------------------
-- 点击开始游戏
-- @function [parent=#TetrisMultiPanel] playGame
function TetrisMultiPanel:playGame()
    local udpConv = nil
    if self.scheduleData.att.isHost then
        self:updatePlayerInfo(self.playerInfo, self.scheduleData.att)
        self:updatePlayerInfo(self.targetPlayerInfo, self.scheduleData.def)
        udpConv = self.scheduleData.att.udpConv
        self.playerId = self.scheduleData.att.playerId
        self.targetId = self.scheduleData.def.playerId
        self.targetTetris.isAI = self.scheduleData.def.isAI
    else
        self:updatePlayerInfo(self.playerInfo, self.scheduleData.def)
        self:updatePlayerInfo(self.targetPlayerInfo, self.scheduleData.att)
        udpConv = self.scheduleData.def.udpConv
        self.playerId = self.scheduleData.def.playerId
        self.targetId = self.scheduleData.att.playerId
        self.targetTetris.isAI = self.scheduleData.att.isAI
    end

    -- 建立udp连接
    if (udpConv) then
        ucmgr:open(udpConv, cmgr.host, 8010)
        -- 添加PushHandler
        ucmgr:addPushCallback(actions.PUSH_FIGHT, self.pushHandler)
    end

    -- 准备好了
    cmgr:send(actions.readyFight)
end

--------------------------------
-- 游戏开始
-- @function [parent=#TetrisMultiPanel] gameStart
function TetrisMultiPanel:gameStart(data)
    log:info("gameStart")
    -- Tips.showSceneTips("游戏开始！！！")

    -- 重置游戏
    self:reset(false)

    -- 初始化随机数
    self.random:randomseed(data.randomseed)
    -- RandomUtil:setRandomseed(data.randomseed)

    -- 游戏开始
    self.tetris:gameStart()
    if self.targetTetris then
        self.targetTetris:gameStart()
    end
end

--------------------------------
-- 游戏结束
-- @function [parent=#TetrisMultiPanel] gameOver
function TetrisMultiPanel:gameOver(data)
    log:info("gameOver playerId:%s", data.playerId)
    self.targetTetris:gameOver()
    Tips.showSceneTips("等待结果更新", -1)
end

--------------------------------
-- 展示赛果
-- @function [parent=#TetrisMultiPanel] showFightResult
function TetrisMultiPanel:showFightResult(data)
    -- 移除网络监听
    cmgr:removePushCallback(self.pushHandler)
    if ucmgr then
        ucmgr:removePushCallback(self.pushHandler)
        ucmgr:close()
    end

    -- 清理Tips
    Tips.clearTips()

    if (data.playerId == self.playerId) then
        self.scheduleData.winId = self.targetId
    else
        self.scheduleData.winId = self.playerId
    end
    local callback = function() 
        self:getScene():pushPanel("Tetris.view.TetrisPvpResult", {self.scheduleData, data})
    end
    self:getScene():pushPanel("Tetris.view.TetrisPvpEndIntro", {data.myInfo.win, callback})
end

--------------------------------
-- 回合开始
-- @function [parent=#TetrisMultiPanel] roundStart
function TetrisMultiPanel:roundStart(oldNextBlock, newNextBlock, isSelf)
    if isSelf then
        self:doRoundStart(self.playerInfo, oldNextBlock, newNextBlock)

        -- 解除长按状态
        if self.tetris.btnDownLowLongPress then
            cmgr:send(actions.doUpdate, nil, protos.KEY_PRESS, self.tetris:getLocalFrameNum(), 52)
        end

        -- 按钮状态重置
        self.btnShift.ended = true
        self.btnLeft.ended = true
        self.btnRight.ended = true
        self.btnDownLow.ended = true
    else
        self:doRoundStart(self.targetPlayerInfo, oldNextBlock, newNextBlock)
    end
end

--------------------------------
-- 处理回合开始
-- @function [parent=#TetrisMultiPanel] doRoundStart
function TetrisMultiPanel:doRoundStart(playerInfo, oldNextBlock, newNextBlock)
    -- 移除之前的方块
    if oldNextBlock then
        playerInfo.nextBg:removeChild(oldNextBlock)
    end

    -- 显示下一个方块
    local offsetx, offsety = newNextBlock:getOffSet()
    -- log:info("Show Next, offsetx:%s, offsety:%s", offsetx, offsety)
    if newNextBlock.blockType == 3 then
        -- 长条特殊处理
        newNextBlock:setPosition(cc.p(27 * 0.6, -offsety * 0.6 + 27))
    else
        newNextBlock:setPosition(cc.p(27 - offsetx * 0.6, -offsety * 0.6 + 27))
    end
    newNextBlock:setScale(0.6)
    playerInfo.nextBg:addChild(newNextBlock)
end

--------------------------------
-- 更新分数
-- @function [parent=#TetrisMultiPanel] updateScore
function TetrisMultiPanel:updateScore(removeLineNums, isSelf)
    if removeLineNums > 0 then
        log:info("updateScore:%s %s", removeLineNums, isSelf)
    end
    if isSelf then
        self:updatePlayerScore(self.playerInfo, removeLineNums)
    else
        self:updatePlayerScore(self.targetPlayerInfo, removeLineNums)
    end 
end

--------------------------------
-- 更新分数
-- @function [parent=#TetrisMultiPanel] updatePlayerScore
function TetrisMultiPanel:updatePlayerScore(playerInfo, removeLineNums)
    if removeLineNums == 1 then
        playerInfo.score = playerInfo.score + 40
    elseif removeLineNums == 2 then
        playerInfo.score = playerInfo.score + 100
    elseif removeLineNums == 3 then
        playerInfo.score = playerInfo.score + 300
    elseif removeLineNums == 4 then
        playerInfo.score = playerInfo.score + 1200
    end
    playerInfo.lbScore:setString(playerInfo.score)
end 

--------------------------------
-- 更新玩家信息
-- @function [parent=#TetrisMultiPanel] updatePlayerScore
function TetrisMultiPanel:updatePlayerInfo(playerInfo, data)
    playerInfo.lbPlayerName:setString(data.playerName)
    playerInfo.lbPlayerScore:setString("分数" .. data.score)
end

--------------------------------
-- 清理
-- @function [parent=#TetrisMultiPanel] reset
function TetrisMultiPanel:reset(resetName) 
    self.tetris:reset()
    if self.targetTetris then
        self.targetTetris:reset()
    end

    self:resetPlayerInfo(self.playerInfo, resetName)
    self:resetPlayerInfo(self.targetPlayerInfo, resetName)
    self.randomCache = {}
    self.lbPing:setString("")
    if self.btnHome then
        if not tolua.isnull(self.btnHome) then
            self.btnHome:removeFromParent()
        end
        self.btnHome = nil
    end
end


--------------------------------
-- 重置玩家数据
-- @function [parent=#TetrisMultiPanel] reset
function TetrisMultiPanel:resetPlayerInfo(playerInfo, resetName)
    if resetName then
        playerInfo.lbPlayerName:setString("")
        playerInfo.lbPlayerScore:setString("")
    end
    playerInfo.nextBg:removeAllChildren()
    playerInfo.lbScore:setString(0)
    playerInfo.score = 0
end

--------------------------------
-- 通知比赛结束
-- @function [parent=#TetrisMultiPanel] reset
function TetrisMultiPanel:notifyGameOver(isSelf)
    if isSelf then
        self.tetris:sendPack(actions.doUpdate, protos.DEAD, self.playerId)
    else
        self.tetris:sendPack(actions.doUpdate, protos.DEAD, self.targetId)
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
    self.randomCache[times] = self.random:nextInt(range)
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
    local x, y = display.cx, display.cy
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
    else
        self.lbPing:setString("ping lost")
    end

    if self.tetris.fixScheduler then
        self.lbPing:setString(self.lbPing:getString() .. ", delay: " .. self.tetris.fixScheduler.delay)
    end
end

--------------------------------
-- 卸载资源
-- @function [parent=#TetrisMultiPanel] onExit
function TetrisMultiPanel:onExit()
    -- 卸载资源
    log:info("TetrisMultiPanel onExit")
    local tipLayer = self:getScene():getLayer("tips")
    tipLayer:removeAllChildren()
    scheduler.unscheduleGlobal(self.pingScheduler)

    -- 移除定时器
    self.tetris:onExit()
    self.targetTetris:onExit()
end

return TetrisMultiPanel

