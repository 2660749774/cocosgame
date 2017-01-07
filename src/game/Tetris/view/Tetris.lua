--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2016/12/31
-- Time: 15:16
-- To change this template use File | Settings | File Templates.
-- Tetris 俄罗斯方块
local Tetris = class("Tetris")
local Block1 = import(".Block1")
local Block2 = import(".Block2")
local Block3 = import(".Block3")
local Block4 = import(".Block4")
local Block5 = import(".Block5")
local Block6 = import(".Block6")
local Block7 = import(".Block7")

--------------------------------
-- 创建方法
-- @function [parent=#Tetris] onCreate
function Tetris:ctor(bg, isNet, isSelf, parent)
    self.bg = bg
    self.isNet = isNet
    self.parent = parent
    self.isSelf = isSelf
   
    self.grids = {}
    self.id = 0
    self.blockMap = {}
    self.checkDownCount = 0 -- 计数器
    self.blockWidth = 27
    self.fixPixel = 3
    self.gameOver = false
    self.hang = 0
    self.removeLineNums = 0
    self.disableDown = false
    self.randomTimes = 1
    self.block = nil
    self.nextBlock = nil
end

--------------------------------
-- 每一帧运行
-- @function [parent=#Tetris] playGame
function Tetris:doUpdate()
    -- if self.isSelf then
        log:info("doUpdate frameNum:%s, timeScale:%s, isSelf:%s, updateTime:%s, fixTime:%s", self:getLocalFrameNum(), self.fixScheduler.timeScale, self.isSelf, self.fixScheduler.updateTime, self.fixScheduler.fixTime)
    -- end
    if self.gameOver or self.disableDown then
        return
    end

    if self.block ~= nil then
        local x, y = self.block:getPosition()
        if self.block:checkDown(self.grids) then
            self.checkDownCount = self.checkDownCount + 1
            if self.checkDownCount == 2 then
                -- 处理向下
                self:_handleDown(self.block, false)
                self.checkDownCount = 0
            end
        else
            self.block:setPosition(cc.p(x, y - self.blockWidth))
            self.checkDownCount = 0
        end
    end
end

--------------------------------
-- 处理推送
-- @function [parent=#Tetris] getPlayerInfo
function Tetris:handleServerFrame(eventList)
    for _, data in pairs(eventList) do
        if data.protoId == protos.KEY_PRESS then
            data.keyCode = tonumber(data.args)
            if data.keyCode == 1 or data.keyCode == 11 or data.keyCode == 12 then
                self:handleLeft(nil, data.keyCode)
            elseif data.keyCode == 2 or data.keyCode == 21 or data.keyCode == 22 then
                self:handleRight(nil, data.keyCode)
            elseif data.keyCode == 3 then
                self:handleShift(nil, data.keyCode)
            elseif data.keyCode == 4 then
                self:handleDown(nil, data.keyCode)
            elseif data.keyCode == 5 or data.keyCode == 51 or data.keyCode == 52 then
                self:handleDownLow(nil, data.keyCode)
            elseif data.keyCode == 100 then
                -- 回合开始
                self:roundStart()
            end
        elseif data.protoId == protos.REMOVE_LINES then
            log:showTable(data)
            self:addLines(data.args)
        end
    end
end

--------------------------------
-- 更新服务器帧数
-- @function [parent=#Tetris] updateServerFrameNum
function Tetris:updateServerFrameNum(frameNum)
    if self.fixScheduler then
        self.fixScheduler:updateServerFrameNum(frameNum)
    end
end

--------------------------------
-- 添加服务器网络帧内容
-- @function [parent=#Tetris] addServerFrame
function Tetris:addServerFrame(frameNum, event)
    self.fixScheduler:addServerFrame(frameNum, event)
end

--------------------------------
-- 获取本地帧号
-- @function [parent=#Tetris] getLocalFrameNum
function Tetris:getLocalFrameNum()
    return self.fixScheduler.frameNum
end


--------------------------------
-- 下一个方块
-- @function [parent=#Tetris] roundStart
function Tetris:roundStart() 
    -- log:info("roundStart begin")
    local oldNextBlock = self.nextBlock

    -- 创建方块
    self.block = self:createBlock(self.nextBlock.blockType, self.nextBlock.angle, self.nextBlock.pic)
    if self.isNet then
        self.block:setPosition(cc.p(165, 489))
    else
        self.block:setPosition(cc.p(165, 759))
    end
    self.bg:addChild(self.block)

    -- 随机下一块方块
    self:createNextBlock()

    -- 充值下一个方块状态
    if self.isSelf then
        self.parent:roundStart(oldNextBlock, self.nextBlock)
    else
        if oldNextBlock then
            oldNextBlock:removeFromParent()
        end
        self.nextBlock:setVisible(false)
        self.bg:addChild(self.nextBlock)
    end

    -- 重置按钮状态
    if self.downScheduler then
        self.fixScheduler:unscheduleTask(self.downScheduler)
        self.downScheduler = nil
    end
    if self.btnDownLowLongPress then
        if not self.isNet then
            self:handleDownLow(nil, 52)
        end
        self.btnDownLowLongPress = false
    end

    -- 充值加速器状态
    self.fixScheduler:setTimeScale(1)
    self.disableDown = false
end

--------------------------------
-- 游戏开始
-- @function [parent=#Tetris] gameStart
function Tetris:gameStart() 
    -- log:info("[Tetris]gameStart")

    -- 随机下一块方块
    if nil == self.nextBlock then
        self:createNextBlock()
    end

    -- 设置定时器
    self.fixScheduler = require "core.fixscheduler".new(0.05)
    self.fixScheduler:addServerFrameHandler(handler(self, self.handleServerFrame))
    if not self.isNet then
        self.fixScheduler:updateServerFrameNum(-1)
    end
    self.updateTask = self.fixScheduler:scheduleTask(handler(self, self.doUpdate), 1)

    -- 回合开始
    self:roundStart()
end

--------------------------------
-- 清理重置
-- @function [parent=#Tetris] reset
function Tetris:reset() 
    -- 停止定时任务
    if self.updateTask then
        self.fixScheduler:destroy()
        self.fixScheduler:unscheduleTask(self.updateTask)
        self.updateTask = nil
        self.fixScheduler = nil
    end

    -- 移除所有方块内容
    self.bg:removeAllChildren()

    -- 重置变量
    self.grids = {}
    self.id = 0
    self.blockMap = {}
    self.checkDownCount = 0 -- 计数器
    self.blockWidth = 27
    self.fixPixel = 3
    self.gameOver = false
    self.hang = 0
    self.removeLineNums = 0
    self.disableDown = false
    self.randomTimes = 1
    self.block = nil
    self.nextBlock = nil

    -- 初始化grid
    if self.isNet then
        self:initGrid(378, 540)
    else
        self:initGrid(378, 810)
    end
end

--------------------------------
-- 初始化Grid
-- @function [parent=#Tetris] initGrid
function Tetris:initGrid(width, height)
    local x = width / self.blockWidth
    local y = height / self.blockWidth

    for i = 1, y do
        for j = 1, x do
            if self.grids[i] == nil then
                self.grids[i] = {}
            end
            table.insert(self.grids[i], 0)
        end
    end
end


--------------------------------
-- 处理翻转
-- @function [parent=#Tetris] handleShift
function Tetris:handleShift(event, keyCode)
    if self.block == nil then
        return
    else
        -- 发送玩家按钮事件
        if event ~= nil and self.isNet then
            cmgr:send(actions.doUpdate, nil, protos.KEY_PRESS, self:getLocalFrameNum(), 3)
            return
        end

        -- 更新位置
        local x, y = self.block:getPosition()
        self.block:doRotation(self.grids)
        return
    end
end

--------------------------------
-- 处理左移动
-- @function [parent=#Tetris] handleLeft
function Tetris:handleLeft(event, keyCode)
    if self.block == nil then
        return
    end

    -- 发送按钮事件
    if event ~= nil then
        keyCode = 1
        if event.type == "longPress" then
            if event.longPress then
                keyCode = 11
            else
                keyCode = 12
            end
        end

        if self.isNet then
            cmgr:send(actions.doUpdate, nil, protos.KEY_PRESS, self:getLocalFrameNum(), keyCode)
            return
        end
    end

    -- 更新控制信息
    if keyCode == 11 then
        self.disableDown = true
    elseif keyCode == 12 then
        self.disableDown = false
    end

    -- 设置位置
    local x, y = self.block:getPosition()
    self.block:handleLeft(self.grids)
end

--------------------------------
-- 处理右移动
-- @function [parent=#Tetris] handleRight
function Tetris:handleRight(event, keyCode)
    if self.block == nil then
        return
    end

    -- 发送按钮事件
    if event ~= nil then
        keyCode = 2
        if event.type == "longPress" then
            if event.longPress then
                keyCode = 21
            else
                keyCode = 22
            end
        end

        if self.isNet then
            cmgr:send(actions.doUpdate, nil, protos.KEY_PRESS, self:getLocalFrameNum(), keyCode)
            return
        end
    end

    -- 更新控制信息
    if keyCode == 21 then
        self.disableDown = true
    elseif keyCode == 22 then
        self.disableDown = false
    end

    -- 更新位置信息
    local x, y = self.block:getPosition()
    self.block:handleRight(self.grids)
end

--------------------------------
-- 处理极速下降
-- @function [parent=#Tetris] handleDown
function Tetris:handleDown(event, keyCode)
    if self.block == nil then
        return
    end

    if nil ~= event and self.isNet then
        cmgr:send(actions.doUpdate, nil, protos.KEY_PRESS, self:getLocalFrameNum(), 4)
        return
    end

    self:_handleDown(self.block, false)
    self:shake(self.bg, 0.05)
end

--------------------------------
-- 处理加速下降
-- @function [parent=#Tetris] handleDownLow
function Tetris:handleDownLow(event, keyCode)
    -- 发送按钮事件
    if event ~= nil then
        keyCode = 5
        -- log:info("handleDownLow event type:%s, longPress:%s", event.type, event.longPress)
        if event.type == "longPress" then
            if event.longPress then
                keyCode = 51
            else
                keyCode = 52
            end
        end

        if self.isNet then
            cmgr:send(actions.doUpdate, nil, protos.KEY_PRESS, self:getLocalFrameNum(), keyCode)
            return
        end
    end

    -- log:info("handleDownLow keyCode:%s", keyCode)
    -- 更新控制信息
    if keyCode == 5 then
        if self.downScheduler ~= nil then
            self.fixScheduler:unscheduleTask(self.downScheduler)
        end

        -- 加速
        self.fixScheduler:setTimeScale(25, 5)
        self.downInterval = 0
        self.btnDownLowLongPress = false
        
        -- 计时间
        -- self.downScheduler = self.fixScheduler:scheduleTask(function() 
        --     if not self.btnDownLowLongPress and self.downScheduler then
        --         self.fixScheduler:unscheduleTask(self.downScheduler)
        --         self.downScheduler = nil

        --         if self.isNet then
        --             cmgr:send(actions.doUpdate, nil, protos.KEY_PRESS, self:getLocalFrameNum(), 52)
        --         else
        --             self.fixScheduler:setTimeScale(1)
        --         end
        --     end
        -- end, 5)
    elseif keyCode == 51 then
        if self.btnDownLowLongPress then
            return
        end

        -- 加速
        self.btnDownLowLongPress = true
        self.fixScheduler:setTimeScale(25, -1)
        self.downInterval = 0
    elseif keyCode == 52 then
        if self.downScheduler then
            self.fixScheduler:unscheduleTask(self.downScheduler)
            self.downScheduler = nil
            self.downInterval = 0
        end
        self.btnDownLowLongPress = false
        self.fixScheduler:setTimeScale(1)
    end
end

--------------------------------
-- 处理向下
-- @function [parent=#Tetris] _handleDown
function Tetris:_handleDown(block, simulate)
    if block == nil then
        return
    end

    -- 处理掉了
    if not block:handleDown(self.grids, simulate) and not simulate then
        if self.isNet then
            Tips.showTips("Game Over!", self.bg, 1)
        else
            Tips.showSceneTips("Game Over!", 1)
        end
        self.gameOver = true
        self.parent:notifyGameOver(self.isSelf)
    elseif not simulate then
        -- 消除判断
        local maxLine = -1
        local removeLines = {}
        for i = 1, #self.grids do
            -- log:info("remove check, width:%s", #self.grids[i])
            local canRemove = true
            for j = 1, #self.grids[i] do
                -- log:info("remove check, y:%s , x:%s, block:%s", i, j, self.grids[i][j])
                if self.grids[i][j] == 0 then
                    canRemove = false
                    break
                end
            end
            if canRemove then
                table.insert(removeLines, i)
                maxLine = i
            end
        end

        -- 消除处理
        local removeBlocks = {}
        for _, line in pairs(removeLines) do
            for i = 1, #self.grids[line] do
                -- log:info("remove block, y:%s , x:%s, block:%s", line, i, self.grids[line][i])
                table.insert(removeBlocks, self.grids[line][i])
                self.grids[line][i] = 0
            end
        end

        self.maxLine = maxLine
        self.removeLineNums = #removeLines
        self.callbackNums = #removeBlocks
        self.callbackCount = 0

        -- 闪烁效果
        if #removeBlocks > 0 then
            self.fixScheduler:setTimeScale(1)
            local action = cc.Blink:create(0.5, 3)
            for _, block in pairs(removeBlocks) do
                local sequence = cc.Sequence:create(action:clone(), 
                                                    cc.CallFunc:create(handler(self, self.removeCallBack), {sender = block}))
                block:runAction(sequence)
            end
        end

        if #removeBlocks == 0 then
            self:removeCallBack()
        end
    end

    
end

--------------------------------
-- 处理移除回调
-- @function [parent=#Tetris] removeCallBack
function Tetris:removeCallBack(sender)
    if sender then
        sender:removeFromParent()
    end

    self.callbackCount = self.callbackCount + 1
    if self.callbackCount < self.callbackNums then
        return
    end

    -- 处理上面的方块
    if self.maxLine ~= -1 then
        local removeLineNums = self.removeLineNums
        for i = self.maxLine + 1, #self.grids do
            for j = 1, #self.grids[i] do
                -- log:info("reset block, y:%s , x:%s, block:%s", i, j, self.grids[i][j])
                if self.grids[i][j] ~= 0 then
                    local block = self.grids[i][j]
                    local x, y = block:getPosition()
                    block:setPosition(cc.p(x, y - self.blockWidth * removeLineNums))
                    self.grids[i][j] = 0
                    self.grids[i - removeLineNums][j] = block
                end
            end           
        end
    end

    -- 告知服务器
    if self.removeLineNums > 0 and self.isSelf then
        self.parent:updateScore(self.removeLineNums)
    end

    -- 更新统计数据
    self.hang = self.hang + self.removeLineNums
    self.maxLine = -1
    self.removeLineNums = 0

    -- 随机下一个
    -- log:info("call roundStart")
    -- if self.isNet then
    --     self.disableDown = true
    --     cmgr:send(actions.doUpdate, nil, protos.KEY_PRESS, self:getLocalFrameNum(), 100)
    -- else
        self:roundStart()
    -- end
    -- self:roundStart()
end

--------------------------------
-- 增加行数
-- @function [parent=#Tetris] addLines
function Tetris:addLines(lines)
    local num = #lines

    -- 处理上面的方块
    for i = #self.grids, 1, -1 do
        for j = 1, #self.grids[i] do
            if self.grids[i][j] ~= 0 then
                local block = self.grids[i][j]
                if not ((i + num) > #self.grids) then
                    local x, y = block:getPosition()
                    block:setPosition(cc.p(x, y + self.blockWidth * num))
                    self.grids[i][j] = 0
                    self.grids[i + num][j] = block
                elseif not tolua.isnull(block) then
                    block:removeFromParent()
                end
            end
        end           
    end

    -- 添加新的方块
    local index = 1
    for index, line in pairs(lines) do
        for i=1, #line do
            local value = line[i]
            if value == 1 then
                local sprite = cc.Sprite:create("tetris/fangkuai.png")
                local x = (i - 1) * self.blockWidth + self.fixPixel
                local y = (index - 1) * self.blockWidth + self.fixPixel
                sprite:setPosition(cc.p(x, y))
                sprite:setAnchorPoint(cc.p(0, 0))
                self.bg:addChild(sprite)
                self.grids[index][i] = sprite
            end
        end
        index = index + 1
    end
end

--------------------------------
-- 创建一个随机方块
-- @function [parent=#Tetris] createRandomBlock
function Tetris:createBlock(type, angle, pic)
    local block = nil
    if type == 1 then
        block = Block1:create(angle, 3, 300, pic)
    elseif type == 2 then
        block = Block2:create(angle, 3, 300, pic)
    elseif type == 3 then
        block = Block3:create(angle, 3, 300, pic)
    elseif type == 4 then
        block = Block4:create(angle, 3, 300, pic)
    elseif type == 5 then
        block = Block5:create(angle, 3, 300, pic)
    elseif type == 6 then
        block = Block6:create(angle, 3, 300, pic)
    elseif type == 7 then
        block = Block7:create(angle, 3, 300, pic)
    end

    return block
end

--------------------------------
-- 随机下一个方块
-- @function [parent=#Tetris] createNextBlock
function Tetris:createNextBlock()
    self.nextBlock = self:createRandomBlock()
    return self.nextBlock
end

--------------------------------
-- 创建一个随机方块
-- @function [parent=#Tetris] Tetris
function Tetris:createRandomBlock()
    local type = self.parent:nextInt(7, self.randomTimes)
    self.randomTimes = self.randomTimes + 1
    
    local angleType = 1
    local pic = 'tetris/fangkuai.png'
    angle = 0
    if angleType == 1 then
        angle = 0
    elseif angleType == 2 then
        angle = self.blockWidth * 3
    elseif angleType == 3 then
        angle = 180
    else
        angle = 270
    end
    return self:createBlock(type, angle, pic)
end

--------------------------------
-- 震屏效果
-- @function [parent=#Tetris] shake
function Tetris:shake(node, interval)
    local x, y = node:getPosition()
    local _interval = 0
    local schedulerHandle = nil
    schedulerHandle = scheduler.scheduleUpdateGlobal(function(dt) 
        _interval = _interval + dt
        if _interval < interval then
            node:setPosition(x, y - 400 * dt)
        else
            node:setPosition(x, y)
            scheduler.unscheduleGlobal(schedulerHandle)
        end
    end)
end

--------------------------------
-- 退出时清理操作
-- @function [parent=#Tetris] onExit
function Tetris:onExit()
    if self.fixScheduler then
        self.fixScheduler:destroy()
    end
end

return Tetris

