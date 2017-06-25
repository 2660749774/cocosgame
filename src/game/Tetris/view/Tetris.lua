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
local ai = import("..AI.TetrisAI")

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
    self.gameOverFlag = false
    self.hang = 0
    self.removeLineNums = 0
    self.disableDown = false
    self.randomTimes = 1
    self.block = nil
    self.nextBlock = nil
    self.isAI = false
    self.pause = false
    self.checkBlockRemoveTimes = 0
    if self.isSelf then
        self.blockPic = 'fangkuai.png'
    else
        self.blockPic = 'fangkuai3.png'
    end

end

function Tetris:pauseGame()
    self.pause = true
end

function Tetris:resumeGame()
    self.pause = false
end

--------------------------------
-- 每一帧运行
-- @function [parent=#Tetris] playGame
function Tetris:doUpdate(dt)
    if self.isSelf then
        -- log:info("doUpdate frameNum:%s, timeScale:%s, isSelf:%s, updateTime:%s, fixTime:%s", self.fixScheduler.timeScale, self.isSelf, self.fixScheduler.updateTime, self.fixScheduler.fixTime)
    end

    if self.gameOverFlag or self.disableDown or self.pause then
        return
    end

    if nil ~= self.parent and self.parent.doUpdate then
        self.parent:doUpdate(dt)
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
-- 进行AI模拟
-- @function [parent=#Tetris] playGame
function Tetris:aiSimulate(dt)
    if self.gameOverFlag or self.disableDown then
        return
    end

    if self.block == nil then
        return
    end
    if self.aicd and self.aicd > dt then
        self.aicd = self.aicd - dt
        return
    elseif self.aicd == nil then
        self.aicd = 1
        return
    end

    if self.moves  == nil then
        local results = ai:makeBestDecision(self.grids, self.block)
        self.moves = results.action_moves
        self.moveStep = 1
    elseif self.moveStep <= #self.moves then
        local action = self.moves[self.moveStep]
        self.moveStep = self.moveStep + 1
        self:doAction(action)
    end


end

function Tetris:doAction(action) 
    if self.block then
        local x, y = self.block:getPosition()
        local idx = self.block.curIndex;

        if action.x > x then
            self:handleRight(nil, 2)
        elseif action.x < x then
            self:handleLeft(nil, 1)
        elseif action.idx ~= idx then
            self:handleShift(nil, 3)
        else
            self:handleDownLow(nil, 5)
            self.aicd = 1
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
    if self.fixScheduler then
        self.fixScheduler:addServerFrame(frameNum, event)
        -- if event.protoId == protos.KEY_PRESS and tonumber(event.args) == 1 then
            -- local delay = cc.Util:getCurrentTime() - self.leftTime
            -- log:info("recive tcp callback, delay:%s, localFramNum:%s, serverFrame:%s, updateTime:%s", 
            -- delay, self.fixScheduler.serverFrameNum, self.fixScheduler.updateTime)
        -- end
    end
end

--------------------------------
-- 获取本地帧号
-- @function [parent=#Tetris] getLocalFrameNum
function Tetris:getLocalFrameNum()
    if self.fixScheduler then
        return self.fixScheduler.frameNum
    end
    return 0
end


--------------------------------
-- 下一个方块
-- @function [parent=#Tetris] roundStart
function Tetris:roundStart()
    if self.gameOverFlag then
        return
    end

    -- log:info("roundStart begin")
    local oldNextBlock = self.nextBlock

    -- 创建方块
    self.block = self:createBlock(self.nextBlock.blockType, self.nextBlock.angle, self.nextBlock.pic)
    self:updateBlock(self.block, self.nextBlock)
    if self.isNet then
        self.block:setPosition(cc.p(138, 435))
    else
        self.block:setPosition(cc.p(165, 435))
    end
    self.bg:addChild(self.block)

    -- 随机下一块方块
    self:createNextBlock()

    -- 充值下一个方块状态
    self.parent:roundStart(oldNextBlock, self.nextBlock, self.isSelf)

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
    self.moves = nil
    self.moveStep = 1
    self.aicd = nil
end

--------------------------------
-- 游戏开始
-- @function [parent=#Tetris] gameStart
function Tetris:gameStart(conf) 
    -- log:info("[Tetris]gameStart nextBlock:%s", self.nextBlock)
    self:initGridBlock(conf)

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
    self.updateTask = self.fixScheduler:scheduleTask(handler(self, self.doUpdate), 0.5)
    if self.isAI then
        self.aiTask = self.fixScheduler:scheduleTask(handler(self, self.aiSimulate))
    end

    -- 回合开始
    self:roundStart()
end

--------------------------------
-- 游戏结束
-- @function [parent=#Tetris] gameStart
function Tetris:gameOver()
    self.gameOverFlag = true
    self.parent:notifyGameOver(self.isSelf)
    -- 停止定时任务
    if self.updateTask then
        self.fixScheduler:destroy()
        self.fixScheduler:unscheduleTask(self.updateTask)
        self.updateTask = nil
        self.fixScheduler = nil
    end
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
    self.gameOverFlag = false
    self.hang = 0
    self.removeLineNums = 0
    self.disableDown = false
    self.randomTimes = 1
    self.block = nil
    self.nextBlock = nil

    -- 初始化grid
    if self.isNet then
        self:initGrid(270, 540)
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
-- 根据配置初始化基础方块
-- @function [parent=#Tetris] createSingleBlock
function Tetris:initGridBlock(conf)
    if conf == nil then
        return
    end

    local blockArray = conf.blockArray
    local pic = string.format("%s.png", conf.blockType)
    
    for i = 1, #blockArray do
        for j = 1, #blockArray[i] do
            if blockArray[i][j] == 1 then
                local gridX = j
                local gridY = #blockArray - i + 1
                local sprite = self:createSingleBlock(pic, gridX, gridY)
                sprite.confBlock = true
                sprite.stoneBlock = iskindof(conf, "TetrisClearStoneConf")
                self.grids[gridY][gridX] = sprite
                self.bg:addChild(sprite)
            elseif blockArray[i][j] == 2 then
                local gridX = j
                local gridY = #blockArray - i + 1
                local sprite = self:createSingleBlock("fangkuai9.png", gridX, gridY)
                sprite.confBlock = true
                sprite.hasStar = true
                self.grids[gridY][gridX] = sprite
                self.bg:addChild(sprite)
            elseif blockArray[i][j] == 3 then
                local gridX = j
                local gridY = #blockArray - i + 1
                local sprite = self:createSingleBlock("fangkuai11.png", gridX, gridY)
                sprite.confBlock = true
                sprite.downBlock = true
                sprite.pic = "fangkuai11.png"
                self.grids[gridY][gridX] = sprite
                self.bg:addChild(sprite)
            elseif blockArray[i][j] == 4 then
                local gridX = j
                local gridY = #blockArray - i + 1
                local sprite = self:createSingleBlock(pic, gridX, gridY)
                sprite.confBlock = true
                sprite.stoneBlock = true
                sprite.shuidiBlock = true
                self.bg:addChild(sprite)
                
                self.grids[gridY][gridX] = sprite
                
            end
        end
    end
end

--------------------------------
-- 创建单个方块
-- @function [parent=#Tetris] createSingleBlock
function Tetris:createSingleBlock(pic, gridX, gridY)
    local sprite = cc.Sprite:createWithSpriteFrameName(pic)
    sprite:setAnchorPoint(0, 0)
    sprite:setPosition((gridX - 1) * self.blockWidth + 3, (gridY - 1) * self.blockWidth + 3)

    return sprite
end


--------------------------------
-- 处理翻转
-- @function [parent=#Tetris] handleShift
function Tetris:handleShift(event, keyCode)
    if self.block == nil then
        return
    else
        -- 发送玩家按钮事件
        if event ~= nil and self.isNet and self.fixScheduler then
            self.fixScheduler:send(actions.doUpdate, protos.KEY_PRESS, 3)
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
    -- if self.isSelf then
    --     local serverFrame = (event == nil)
    --     if not serverFrame then
    --         self.leftTime = cc.Util:getCurrentTime()
    --         self.delay = 0
    --     else
    --         self.delay = cc.Util:getCurrentTime() - self.leftTime
    --         log:info("handleLeft serverFrame:%s, delay:%s, updateTime:%s", serverFrame, self.delay, self.fixScheduler.updateTime)
    --     end
    -- end
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

        if self.isNet and self.fixScheduler then
            self.fixScheduler:send(actions.doUpdate, protos.KEY_PRESS, keyCode)
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

        if self.isNet and self.fixScheduler then
            self.fixScheduler:send(actions.doUpdate, protos.KEY_PRESS, keyCode)
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

    if nil ~= event and self.isNet and self.fixScheduler then
        self.fixScheduler:send(actions.doUpdate, protos.KEY_PRESS, 4)
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

        if self.isNet and self.fixScheduler then
            self.fixScheduler:send(actions.doUpdate, protos.KEY_PRESS, keyCode)
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
        --             self.fixScheduler:send(actions.doUpdate, protos.KEY_PRESS, 52)
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
            -- Tips.showSceneTips("Game Over!", 1)
        end
        self:gameOver()
    elseif not simulate then
        self.disableDown = true
        self.block = nil

        -- 更新格子显示
        if self.parent.updateGridView then
            self.parent:updateGridView(self.grids)
        end

        -- 消除判断
        self:checkBlockRemove()
    end

    
end

--------------------------------
-- 消除判断
-- @function [parent=#Tetris] checkBlockRemove
function Tetris:checkBlockRemove()
    
    -- 检查引用计数器 + 1
    self.checkBlockRemoveTimes = self.checkBlockRemoveTimes + 1
    -- log:info("block remove times step1, count:%s", self.checkBlockRemoveTimes)

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
            local removeBlock = self.grids[line][i]
            removeBlock.gridX = i
            removeBlock.gridY = line
            table.insert(removeBlocks, removeBlock)
            self.grids[line][i] = 0
        end
    end

    -- 处理上面的方块
    self.removeLineNums = #removeLines
    self.callbackNums = #removeBlocks
    self.callbackCount = 0
    if maxLine ~= -1 then
        self.upperBlockList = {}
        local removeLineNums = self.removeLineNums
        for i = maxLine + 1, #self.grids do
            for j = 1, #self.grids[i] do
                -- log:info("reset block, y:%s , x:%s, block:%s", i, j, self.grids[i][j])
                if self.grids[i][j] ~= 0 then
                    local block = self.grids[i][j]
                    self.grids[i][j] = 0
                    self.grids[i - removeLineNums][j] = block
                    block.moveLines = self.removeLineNums
                    table.insert(self.upperBlockList, block)
                end
            end           
        end
    end

    -- 闪烁效果
    if #removeBlocks > 0 then
        -- 检查移除行
        if self.parent.checkRemoveLines then
            self.parent:checkRemoveLines(removeBlocks)
        end

        self.fixScheduler:setTimeScale(1)
        local action = cc.Blink:create(0.5, 3)
        for _, block in pairs(removeBlocks) do
            if block.stoneBlock then
                -- 碎掉动画
                block:setVisible(false)
                local x, y = block:getPosition()

                if block.shuidiBlock then
                    local sprite = cc.Sprite:createWithSpriteFrameName("fangkuai12.png")
                    sprite:setAnchorPoint(0, 0)
                    sprite:setPosition(x, y)
                    block.shuidiSprite = sprite
                    self.bg:addChild(sprite)
                end

               
                local stoneAnimLayout = require("layout.TetrisStoneAnimation").create()
                local animation = stoneAnimLayout['animation']
                stoneAnimLayout['root']:runAction(animation)
                stoneAnimLayout['root']:setPosition(x + 13, y + 13)
                animation:gotoFrameAndPlay(0, false)
                animation:setLastFrameCallFunc(function()
                    stoneAnimLayout['root']:removeFromParent()
                    self:removeCallBack(block)
                end) 
                self.bg:addChild(stoneAnimLayout['root']) 
            else
                -- 闪烁动画
                local sequence = cc.Sequence:create(action:clone(), 
                                                cc.CallFunc:create(handler(self, self.removeCallBack), {sender = block}))
                block:runAction(sequence)
            end
        end
    end

    if #removeBlocks == 0 then
        self:removeCallBack()
    end
end

--------------------------------
-- 处理移除回调
-- @function [parent=#Tetris] removeCallBack
function Tetris:removeCallBack(sender)
    if sender then
        if sender.hasStar then
            self:flyStar(sender)
            sender:removeFromParent()
        elseif sender.downBlock then
            self:handleDownBlock(sender)
        elseif sender.stoneBlock then
            self:handleStoneBlock(sender)
        elseif sender.extraAttributes then
            self:handleExtraAttributes(sender)
            sender:removeFromParent()
        else
            sender:removeFromParent()
        end
    end

    self.callbackCount = self.callbackCount + 1
    if self.callbackCount < self.callbackNums then
        return
    end

    -- 处理上面的方块
    if self.upperBlockList and #self.upperBlockList > 0 then
        for _, block in pairs(self.upperBlockList) do 
            local x, y = block:getPosition()
            block:setPosition(cc.p(x, y - self.blockWidth * block.moveLines))
            block.moveLines = 0
        end
        self.upperBlockList = {}
    end

    -- 更新视图
    self.parent:updateScore(self.removeLineNums, self.isSelf)

    -- 通知服务器消除
    if self.isNet and self.removeLineNums > 0 and self.fixScheduler then
        if self.isSelf then
            self.fixScheduler:send(actions.doUpdate, protos.REMOVE_LINES, self.removeLineNums)
        elseif self.isAI then
            self.fixScheduler:send(actions.doUpdate, protos.REMOVE_LINES, self.removeLineNums .. ",true")
        end
    end
    -- if self.isSelf then
    --     self.parent:updateScore(self.removeLineNums)
    -- elseif self.removeLineNums > 0 then
    --     -- 通知服务器
    --     self.fixScheduler:send(actions.doUpdate, protos.REMOVE_LINES, self.removeLineNums .. ",true")
    -- end

    -- 更新统计数据
    self.hang = self.hang + self.removeLineNums
    self.removeLineNums = 0

    -- 随机下一个
    -- log:info("call roundStart")
    -- if self.isNet then
    --     self.disableDown = true
    --     self.fixScheduler:send(actions.doUpdate, protos.KEY_PRESS, 100)
    -- else
    -- 检查引用计数器 - 1
    self.checkBlockRemoveTimes = self.checkBlockRemoveTimes - 1
    -- log:info("block remove times step5, count:%s", self.checkBlockRemoveTimes)
    if self.checkBlockRemoveTimes == 0 then
        self:roundStart()
    end
    -- end
    -- self:roundStart()
end

--------------------------------
-- 处理下沉方块
-- @function [parent=#Tetris] handleDownBlock
function Tetris:handleDownBlock(sender)
    local gridX = sender.gridX
    local gridY = sender.gridY

    -- 重新添加block
    local x, y = self:convertGridToPosition(gridX, gridY)
    local block = sender
    block:retain()
    block:removeFromParent()
    block:setPosition(x, y)
    self.bg:addChild(block)

    -- 检测下沉位置
    local targetGridY = self:checkDownGridPos(gridX, gridY)
    -- log:info("final gridY:%s", targetGridY)
    local targetX, targetY = self:convertGridToPosition(gridX, targetGridY)
    -- log:info("final pos:%s %s", targetX, targetY)

    self.checkBlockRemoveTimes = self.checkBlockRemoveTimes + 1
    -- log:info("block remove times step2, count:%s", self.checkBlockRemoveTimes)
    -- 原来的位置
    if (targetGridY == gridY) then
        self:insertBlock(gridX, targetGridY, block)
        self.checkBlockRemoveTimes = self.checkBlockRemoveTimes - 1
        -- log:info("block remove times step3, count:%s", self.checkBlockRemoveTimes)
        return
    end

    -- 等分
    if targetGridY < 1 then
        self:handleExtraAttributes()
    end

    -- 创建动画
    local action = cc.MoveTo:create(1, cc.p(targetX, targetY))
    local sequence = cc.Sequence:create(action, 
            cc.CallFunc:create(
                function() 
                    -- 移除自身
                    if targetGridY < 1 then
                        -- 回调父类
                        if self.parent.updateFlyStar then
                            self.parent:updateFlyStar()
                        end
                        block:removeFromParent()
                    else
                        -- 替换原有block
                        local oldBlock = self.grids[targetGridY][gridX]
                        if oldBlock and oldBlock ~= 0 then
                            oldBlock:removeFromParent()
                        end
                        self.grids[targetGridY][gridX] = block
                    end

                    self.checkBlockRemoveTimes = self.checkBlockRemoveTimes - 1
                    -- log:info("block remove times step4, count:%s", self.checkBlockRemoveTimes)
                    if self.checkBlockRemoveTimes == 0 then
                        -- 再次检查消除
                        self:checkBlockRemove()
                    end
                end
            )
    )
    
    block:runAction(sequence)
end

--------------------------------
-- 处理水滴block
-- @function [parent=#Tetris] handleStoneBlock
function Tetris:handleStoneBlock(sender)
    -- 移除自身
    local stoneBlock = sender.shuidiBlock
    local gridX = sender.gridX
    local gridY = sender.gridY
    local pos = sender:convertToWorldSpace(cc.vertex2F(0, 0))
    local shuidiSprite = sender.shuidiSprite
    sender:removeFromParent()

    if not stoneBlock then
        return
    end
    shuidiSprite:removeFromParent()

    -- 添加水滴
    local sprite = cc.Sprite:createWithSpriteFrameName("fangkuai12.png")
    sprite:setAnchorPoint(0, 0)
    sprite:setPosition(pos.x, pos.y)
    self.parent:addChild(sprite)

    local offset = display.width - 640
    -- 放大
    local action1 = cc.ScaleTo:create (1, 2.0)

    -- 贝塞尔运动
    local bezierConfig = {
        cc.p(pos.x, pos.y - 250),   
        cc.p(350 + offset, 900),  
        cc.p(510 + offset, 1030),  
    }  
    local action2 = cc.BezierTo:create(1, bezierConfig)
    -- local action2 = cc.MoveTo:create(1, cc.vertex2F(500, 782))

    local sequence = cc.Sequence:create(action1, action2, 
                                        cc.CallFunc:create(function() 
                                            -- 移除自身
                                            sprite:removeFromParent()
                                        end))
    sprite:runAction(sequence)
end

--------------------------------
-- 固定位置插入一个block
-- @function [parent=#BaseBlock] insertBlock
function Tetris:insertBlock(gridX, gridY, block)
    for i = #self.grids, gridY, -1 do
        local block = self.grids[i][gridX]
        if block and block ~= 0 then
            self.grids[i + 1][gridX] = block
            self.grids[i][gridX] = 0
            if block.moveLines then
                block.moveLines = block.moveLines - 1
            end
        end          
    end
    self.grids[gridY][gridX] = block
end

--------------------------------
-- 检查是可以下降得格数
-- @function [parent=#BaseBlock] checkDownGridPos
function Tetris:checkDownGridPos(gridX, gridY)
    -- log:info("downblock, gridX:%s, gridY:%s", gridX, gridY)

    -- 检查自己所处位置是否合法
    local pos = gridY - 1
    for i = gridY - 1, 1, -1 do
        -- log:info("check grid gridX:%s, gridY:%s, value:%s", gridX, i, self.grids[i][gridX] or -1)
        if self.grids[i][gridX] ~= nil and self.grids[i][gridX] == 0 then
            pos = i
        else
            break
        end
    end

    if pos > 0 and self.grids[pos][gridX] ~= 0 and self.grids[pos][gridX].downBlock then
        pos = pos + 1
    end

    return pos
end

--------------------------------
-- 播放收集星星动画
-- @function [parent=#Tetris] flyStar
function Tetris:flyStar(sender)
    local x, y = sender:getPosition()
    local pos = sender:convertToWorldSpace(cc.vertex2F(0, 0))
    local star = cc.Sprite:createWithSpriteFrameName("star.png")
    star:setAnchorPoint(0, 0)
    star:setPosition(pos.x, pos.y)
    self.parent:addChild(star)

    local offset = display.width - 640
    -- 放大
    local action1 = cc.ScaleTo:create (1, 2.0)

    -- 贝塞尔运动
    local bezierConfig = {
        cc.p(pos.x, pos.y - 250),   
        cc.p(350 + offset, 900),  
        cc.p(510 + offset, 1030),  
    }  
    local action2 = cc.BezierTo:create(1, bezierConfig)
    -- local action2 = cc.MoveTo:create(1, cc.vertex2F(500, 782))

    local sequence = cc.Sequence:create(action1, action2, 
                                        cc.CallFunc:create(function() 
                                            -- 移除自身
                                            star:removeFromParent()
                                            
                                            -- 回调父类
                                            if self.parent.updateFlyStar then
                                                self.parent:updateFlyStar()
                                            end
                                        end))
    star:runAction(sequence)
end

--------------------------------
-- 处理额外属性
-- @function [parent=#Tetris] handleExtraAttributes
function Tetris:handleExtraAttributes(sender)
    if self.parent.handleExtraAttributes then
        self.parent:handleExtraAttributes(sender)
    end
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
                -- log:info("addLines i:%s, j:%s, block:%s", i, j, block)
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
                local sprite = cc.Sprite:createWithSpriteFrameName(self.blockPic)
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

    -- 如果当前方块已经不能下落
    if self.block and not self.block:handleDown(self.grids, true) then
        local x, y = self.block:getPosition()
        self.block:setPosition(cc.p(x, y + self.blockWidth * num))
    end
end

--------------------------------
-- 创建一个随机方块
-- @function [parent=#Tetris] createRandomBlock
function Tetris:createBlock(type, angle, pic)
    local block = nil
    if type == 1 then
        block = Block1:create(angle, 3, 273, pic)
    elseif type == 2 then
        block = Block2:create(angle, 3, 273, pic)
    elseif type == 3 then
        block = Block3:create(angle, 3, 273, pic)
    elseif type == 4 then
        block = Block4:create(angle, 3, 273, pic)
    elseif type == 5 then
        block = Block5:create(angle, 3, 273, pic)
    elseif type == 6 then
        block = Block6:create(angle, 3, 273, pic)
    elseif type == 7 then
        block = Block7:create(angle, 3, 273, pic)
    end

    return block
end

--------------------------------
-- 随机下一个方块
-- @function [parent=#Tetris] createNextBlock
function Tetris:createNextBlock()
    self.nextBlock = self:createRandomBlock()

    -- 更新下一个节点
    if self.parent.updateNextBlock then
        self.nextBlock = self.parent:updateNextBlock(self.nextBlock)
    end

    return self.nextBlock
end

--------------------------------
-- 更新block
-- @function [parent=#Tetris] updateBlock
function Tetris:updateBlock(block, nextBlock)
    -- log:info("updateblock start")
    for i=1, #nextBlock.blocks do 
        local sprite = nextBlock.blocks[i]
        -- log:info("updateblock sprite:%s, downblock:%s", sprite, sprite.downBlock)
        if sprite.hasStar or sprite.extraAttributes or sprite.downBlock then
            sprite:retain()
            sprite:removeFromParent()

            block.blocks[i]:removeFromParent()
            block.blocks[i] = sprite
            block:addChild(sprite)
        end
    end
end

--------------------------------
-- 创建一个随机方块
-- @function [parent=#Tetris] Tetris
function Tetris:createRandomBlock()
    local type = self.parent:nextInt(7, self.randomTimes)
    self.randomTimes = self.randomTimes + 1

    return self:createBlock(type, 0, self.blockPic)
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
-- 格子坐标转换成像素坐标
-- @function [parent=#Tetris] convertGridToPosition
function Tetris:convertGridToPosition(gridX, gridY)
    return (gridX - 1) * self.blockWidth + self.fixPixel, (gridY - 1) * self.blockWidth + self.fixPixel
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

