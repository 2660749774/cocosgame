--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2016/12/31
-- Time: 15:16
-- To change this template use File | Settings | File Templates.
-- TetrisNew 俄罗斯方块
local TetrisNew = class("TetrisNew")
local TetrisCore = import("..core.TetrisCore")
local BlockView = import(".block.BlockView")
local BlockProp = import("..core.BlockProp")

--------------------------------
-- 创建方法
-- @function [parent=#TetrisNew] onCreate
function TetrisNew:ctor(bg, isNet, isSelf, parent)
    self.bg = bg
    self.isNet = isNet
    self.isAI = false
    self.parent = parent
    self.isSelf = isSelf
    self.blockWidth = 27

    self.core = nil
    self.grids = {} -- 当前方格
    self.nextBlock = nil -- 下一块方块
    self.pic = 'fangkuai.png'
    self.fixPixel = 3
    self.upperBlockList = {}

    -- 输入采集相关变量
    self.keyCode = -1
    self.collectCd = 0
    self.collectInputInterval = 0.025
    self.collectInputRatio = 1
    self.downNum = 0
    self.callbackNums = 0
    self.callbackCount = 0
    self.removeLineNums = 0
    self.delayEvent = {}
end

--------------------------------
-- 暂停游戏
-- @function [parent=#TetrisNew] pauseGame
function TetrisNew:pauseGame()
    self.pause = true
    self.core:pauseGame()
end

--------------------------------
-- 恢复游戏
-- @function [parent=#TetrisNew] resumeGame
function TetrisNew:resumeGame()
    self.pause = false
    self.core:resumeGame()
end

--------------------------------
-- 設置AI類型
-- @function [parent=#TetrisNew] setAIFlag
function TetrisNew:setAIFlag(isAI)
    self.isAI = isAI
    if self.core then
        self.core.isAI = isAI
    end
end

--------------------------------
-- 每一帧运行
-- @function [parent=#TetrisNew] doUpdate
function TetrisNew:doUpdate(dt)
    -- 自身事件更新
    local eventNum = #self.delayEvent
    if eventNum > 0 then
        for i=1, eventNum do
            self:handleEvent(self.delayEvent[i])
        end
        for i=1, eventNum do
            table.remove(self.delayEvent, 1)
        end
        return
    end

    -- 1. 采集输入
    self:collectInput(dt)

    -- 2. 同步block位置信息
    if self.block ~= nil then
        self.block:doUpdate()
    end

    -- 3. 取事件进行更新
    local event = self.core:pollEvent()
    if (nil ~= event) then
        self:handleEvent(event)
    end
    

    -- 4. 父节点更新
    if self.parent.doUpdate then
        self.parent:doUpdate(dt)
    end
end

--------------------------------
-- 处理事件
-- @function [parent=#TetrisNew] handleEvent
function TetrisNew:handleEvent(event)
    log:info("[view]update event:%s", event.name)
    -- 处理event
    if event.name == "GameStart" then
        -- 游戏开始
        self:initGridView()

        -- 创建nextBlock
        self:updateNextBlock(event.nextBlock)
    elseif event.name == "RoundStart" then
        -- 回合开始
        self.block = BlockView:create(event.block, self.pic)
        self.block:updateAttribute(self.nextBlock)
        self.block:doUpdate()
        self.bg:addChild(self.block)
        self:roundReset()

        -- 更新下一个block
        self:updateNextBlock(event.nextBlock)

        -- 更新方块数量
        if self.parent.updateBlockNum then
            self.parent:updateBlockNum()
        end
    elseif event.name == "Shake" then
        -- 震屏
        self:shake(self.bg, 0.05)
    elseif event.name == "MergeBlock" then
        -- 合并block
        self:merge(self.block)
        self.block = nil

        if not event.succ then
            -- 游戏结束
            self:gameOver()
        end
    elseif event.name == "Eliminate" then
        -- 进行消除
        self:doEliminate(event.eliminateArr, event.eliminateProp)
    elseif event.name == "AddLines" then
        -- 增加了行数
        self:addLines(event.lines)
    end
end

--------------------------------
-- 回合重置
-- @function [parent=#TetrisNew] roundReset
function TetrisNew:roundReset()
    self.collectInputRatio = 1
    self.keyCode = -1
    self.downNum = 0
    self.collectCd = 0
end

--------------------------------
-- 采集输入
-- @function [parent=#TetrisNew] collectInput
function TetrisNew:collectInput(dt)
    -- 采集输入
    dt = dt * self.collectInputRatio
    if self.collectCd > 0 then
        self.collectCd = self.collectCd - dt
    else
        local keyCode = self.keyCode
        if keyCode ~= -1 then
            if self.keyCode == 11 then
                keyCode = 1
            elseif self.keyCode == 21 then
                keyCode = 2
            elseif self.keyCode == 31 then
                keyCode = 3
            elseif self.keyCode == 51 then
                keyCode = 5
                self.downNum = 5
            end

            -- 对于快速下降特殊处理
            if keyCode == 5 then
                self.downNum = self.downNum - 1
                if self.downNum <= 0 then
                    self.keyCode = -1
                    self.collectInputRatio = 1
                end
            end
            self.core:handleInput(keyCode)
        end
        self.collectCd = self.collectInputInterval
    end
end

--------------------------------
-- 合并节点
-- @function [parent=#TetrisNew] merge
function TetrisNew:merge(block)
    local blockArray = block:getBlockArray()
    local tx = block.model.x
    local ty = block.model.y
    local index = 1
    for i = 1, 4 do
        for j = 1, 4 do
            if blockArray[i][j] ~= 0 then
                local bx, by = j, (4 - i) + 1
                self.grids[ty + by][tx + bx] = block:getBlock(index)
                index = index + 1
            end
        end
    end

    -- 父亲视图更新grids
    if self.parent.updateGridView then
        self.parent:updateGridView(self.grids)
    end
end

--------------------------------
-- 打印tetris
-- @function [parent=#TetrisNew] print
function TetrisNew:print()
    local fmt = ""
    local t = {}
    for i = 1, self.col do
        if i == 1 then
            fmt = fmt .. "%s"
        else
            fmt = fmt .. " %s"
        end
    end
    for i = 1, self.row do
        for j = 1, #self.grids[i] do
            if t[i] == nil then
                t[i] = {}
            end
            if self.grids[i][j] ~= 0 then
                t[i][j] = 'B'
            else
                t[i][j] = '0'
            end
        end
    end
    for i = self.row, 1, -1 do
        log:info(fmt, unpack(t[i]))
    end
    log:info("-------------------------------------------")
end

--------------------------------
-- 进行消除
-- @function [parent=#TetrisNew] doEliminate
function TetrisNew:doEliminate(eliminateArr, eliminateProp)
    if self.callbackNums > 0 then
        -- 还有动画在播报，延迟
        table.insert(self.delayEvent, {name = "Eliminate", eliminateArr = eliminateArr, eliminateProp = eliminateProp})
        return
    end

    -- 获取需要消除的行
    local removeBlocks = {}
    local eliminateGrids = {}
    for i = 1, self.row do
        if eliminateArr[i] ~= 0 then
            for j = 1, self.col do
                local block = self.grids[i][j]
            
                if eliminateProp[i] then
                    local prop = eliminateProp[i][j]
                    if prop then
                        block.eliminateProp = prop
                    end
                end
                table.insert(removeBlocks, block)

                -- 特殊处理
                -- local prop = self.grids[i][j].prop 
                -- if prop and prop.blockType == 4 then
                --     table.insert(eliminateGrids, {y = i, x = j, prop = prop})
                -- elseif prop and prop.blockType == 3 then
                --     table.insert(eliminateGrids, {y = i, x = j, prop = prop})
                -- end
            end
            self.removeLineNums = self.removeLineNums + 1
        end
    end
    
    -- 整理方块
    local nextIdx = 1
    for i = 1, self.row do
        while (nextIdx <= self.row and eliminateArr[nextIdx] == 1) do
            nextIdx = nextIdx + 1
        end

        if i == nextIdx then
            nextIdx = nextIdx + 1
        else
            if nextIdx <= self.row then
                for j = 1, self.col do
                    local block = self.grids[nextIdx][j]
                    self.grids[i][j] = block
                    if block and block ~= 0 then
                        -- 需要改变坐标
                        block.moveLines = nextIdx - i
                        table.insert(self.upperBlockList, block)
                    end
                end
                nextIdx = nextIdx + 1
            else
                for j = 1, self.col do
                    self.grids[i][j] = 0
                end
            end
        end
    end

    -- 添加动画
    self.callbackNums = #removeBlocks
    self.callbackCount = 0
    if #removeBlocks > 0 then
        -- 播放音效
        amgr:playEffect("remove_block.wav")

        -- 父亲视图更新节点属性
        if self.parent.checkRemoveLines then
            self.parent:checkRemoveLines(removeBlocks)
        end

        local action = cc.Blink:create(0.5, 3)
        for _, block in pairs(removeBlocks) do
            -- 消除特殊事件处理
            if block.eliminateProp then
                -- 处理消除事件
                local prop = block.eliminateProp
                if prop.type == "insert" then
                    local newBlock = self:createGridBlock(prop.prop, prop.x, prop.y)
                    self:insertGridBlock(prop.x, prop.y, newBlock)
                    prop.newBlock = newBlock
                elseif prop.type == "replace" then
                    local targetY = prop.targetY
                    local newBlock = self:createGridBlock(prop.prop, prop.x, prop.y)
                    self:replaceGridBlock(prop.x, prop.y, targetY, newBlock)
                    prop.newBlock = newBlock
                end
            end

            if block.prop and (block.prop.blockType == 4 or block.prop.blockType == 5) then
                -- 石头方块
                block:setVisible(false)
                local x, y = block:getPosition()
                local stoneAnimLayout = require("layout.TetrisStoneAnimation").create()
                local animation = stoneAnimLayout['animation']
                stoneAnimLayout['root']:runAction(animation)
                stoneAnimLayout['root']:setPosition(x + 13, y + 13)
                animation:setTimeSpeed(0.12)
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

        -- self:print()
    end
end

--------------------------------
-- 指定位置插入数据
-- @function [parent=#TetrisNew] insertGridBlock
function TetrisNew:insertGridBlock(x, y, block)
    block:setVisible(false)
    for i = #self.grids, y, -1 do
        local _value = self.grids[i][x]
        if _value and _value ~= 0 then
            self.grids[i + 1][x] = _value
            self.grids[i][x] = 0
            if _value.moveLines then
                _value.moveLines = _value.moveLines - 1
            end
        end          
    end
    self.grids[y][x] = block
end

--------------------------------
-- 替换方块
-- @function [parent=#TetrisNew] replaceGridBlock
function TetrisNew:replaceGridBlock(x, y, ty, block)
    block:setVisible(false)
    local targetX, targetY = self:convertGridToPosition(x, ty)
    if y == ty then
        self:insertGridBlock(x, y, block)
    elseif ty >= 1 then
        -- 替换原有block
        self.grids[ty][x] = block
    end
end

--------------------------------
-- 插入动画表现
-- @function [parent=#TetrisNew] doInsertGridBlockAnim
function TetrisNew:doInsertGridBlockAnim(x, y, block)
    block:setScale(0)
    block:setVisible(true)
    local action1 = cc.ScaleTo:create(0.2, 1)
    local action2 = cc.DelayTime:create(0.2)
    local sequence = cc.Sequence:create(action1, action2)
    block:runAction(sequence)
end

--------------------------------
-- 处理替换方块动画
-- @function [parent=#TetrisNew] doReplaceGridBlockAnim
function TetrisNew:doReplaceGridBlockAnim(x, y, ty, block)
    local targetX, targetY = self:convertGridToPosition(x, ty)
    block:setVisible(true)
    if y ~= ty then
        -- 创建动画
        local action = cc.MoveTo:create(1, cc.p(targetX, targetY))
        local sequence = cc.Sequence:create(action, 
                cc.CallFunc:create(
                    function() 
                        -- 移除自身
                        if ty < 1 then
                            -- 回调父类
                            if self.parent.updateFlyStar then
                                self.parent:updateFlyStar()
                            end
                            block:removeFromParent()
                        end
                    end
                )
        )
        
        block:runAction(sequence)
    end
end

--------------------------------
-- 更新下一个节点
-- @function [parent=#TetrisNew] updateNextBlock
function TetrisNew:updateNextBlock(model)
    local oldNextBlock = self.nextBlock
    self.nextBlock = BlockView:create(model, self.pic)
    
    -- 刷新下个block
    if self.parent.updateNextBlock then
        self.parent:updateNextBlock(self.nextBlock)
    end

    self.parent:roundStart(oldNextBlock, self.nextBlock, self.isSelf)
end

--------------------------------
-- 进行AI模拟
-- @function [parent=#TetrisNew] playGame
function TetrisNew:aiSimulate(dt)
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

function TetrisNew:doAction(action) 
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
-- @function [parent=#TetrisNew] handleServerFrame
function TetrisNew:handleServerFrame(eventList)
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
-- @function [parent=#TetrisNew] updateServerFrameNum
function TetrisNew:updateServerFrameNum(frameNum)
    if self.core then
        self.core:updateServerFrameNum(frameNum)
    end
end

--------------------------------
-- 添加服务器网络帧内容
-- @function [parent=#TetrisNew] addServerFrame
function TetrisNew:addServerFrame(frameNum, event)
    if self.core then
        self.core:addServerFrame(frameNum, event)
    end
end


--------------------------------
-- 游戲開始
-- @function [parent=#TetrisNew] gameStart
function TetrisNew:gameStart(playerId, conf, seed) 
    self.core:gameStart(playerId, conf, seed)

    -- 添加计时器
    self.schedulerHandler = scheduler.scheduleUpdateGlobal(handler(self, self.doUpdate))
end

--------------------------------
-- 游戏结束
-- @function [parent=#TetrisNew] gameStart
function TetrisNew:gameOver()
    log:info("game Over")
    self.gameOverFlag = true
    self.parent:notifyGameOver(self.isSelf)

    self.core:gameOver()
    -- 停止定时任务
    if self.schedulerHandler then
        scheduler.unscheduleGlobal(self.schedulerHandler)
        self.schedulerHandler = nil
    end
end

--------------------------------
-- 清理重置
-- @function [parent=#TetrisNew] reset
function TetrisNew:reset() 
    log:info("[view]reset isNet:%s", self.isNet)
    -- 停止定时任务
    if self.schedulerHandler then
        scheduler.unscheduleGlobal(self.schedulerHandler)
        self.schedulerHandler = nil
    end

    -- 移除所有方块内容
    self.bg:removeAllChildren()

    -- 重置变量
    self.core = nil
    self.blockWidth = 27
    self.grids = {} -- 当前方格
    self.block = nil
    self.nextBlock = nil -- 下一块方块
    self.pic = 'fangkuai.png'
    self.fixPixel = 3
    self.upperBlockList = {}

    -- 输入采集相关变量
    self.keyCode = -1
    self.collectCd = 0
    self.collectInputInterval = 0.025
    self.collectInputRatio = 1
    self.downNum = 0
    self.callbackNums = 0
    self.callbackCount = 0
    self.removeLineNums = 0
    self.delayEvent = {}

     -- 初始化grid
    if self.isNet then
        self:initGrid(270, 540)
        self.core = TetrisCore:create(self.isNet, self.isAI, 270, 540)
    else
        self:initGrid(378, 810)
        self.core = TetrisCore:create(self.isNet, self.isAI, 378, 810)
    end
end

--------------------------------
-- 初始化Grid
-- @function [parent=#TetrisNew] initGrid
function TetrisNew:initGrid(width, height)
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
-- 初始化初始显示方格
-- @function [parent=#TetrisNew] initGridView
function TetrisNew:initGridView()
    local grids = self.core.grids
    for y=1, #grids do
        self.grids[y] = {}
        for x=1, #grids[y] do
            if grids[y][x] == 0 then
                self.grids[y][x] = 0
            else
                self.grids[y][x] = self:createGridBlock(grids[y][x], x, y)
            end
        end
    end
    self.row = #grids
    self.col = #grids[1]
end

--------------------------------
-- 创建指定方块
-- @function [parent=#TetrisNew] createSingleBlock
function TetrisNew:createGridBlock(blockProp, x, y)
    local block = self:createSingleBlock(blockProp.pic, x, y)
    block.prop = blockProp
    self.bg:addChild(block)

    return block
end

--------------------------------
-- 创建单个方块
-- @function [parent=#TetrisNew] createSingleBlock
function TetrisNew:createSingleBlock(pic, gridX, gridY)
    if pic == "" then
        pic = self.pic
    end
    local sprite = cc.Sprite:createWithSpriteFrameName(pic)
    sprite:setAnchorPoint(0, 0)
    sprite:setPosition((gridX - 1) * self.blockWidth + 3, (gridY - 1) * self.blockWidth + 3)

    return sprite
end


--------------------------------
-- 处理翻转
-- @function [parent=#TetrisNew] 
function TetrisNew:handleShift(event, keyCode)
    self.core:handleInput(3)
end

--------------------------------
-- 处理左移动
-- @function [parent=#TetrisNew] handleLeft
function TetrisNew:handleLeft(event, keyCode)
    if event.type == "longPress" then
        if event.longPress then
            self.keyCode = 11
        else
            self.keyCode = -1
        end
    else
        self.core:handleInput(1)
    end
end

--------------------------------
-- 处理右移动
-- @function [parent=#TetrisNew] handleRight
function TetrisNew:handleRight(event, keyCode)
    if event.type == "longPress" then
        if event.longPress then
            self.keyCode = 21
        else
            self.keyCode = -1
        end
    else
        self.core:handleInput(2)
    end
end

--------------------------------
-- 处理极速下降
-- @function [parent=#TetrisNew] handleDown
function TetrisNew:handleDown(event, keyCode)
    self.core:handleInput(4)
end

--------------------------------
-- 处理加速下降
-- @function [parent=#TetrisNew] handleDownLow
function TetrisNew:handleDownLow(event, keyCode)
    self.downNum = 5
    self.collectInputRatio = 2
    if event.type == "longPress" then
        if event.longPress then
            self.keyCode = 51
        else
            self.keyCode = -1
        end
    else
        self.keyCode = 5
    end
end

--------------------------------
-- 发送网络包
-- @function [parent=#TetrisNew] sendPack
function TetrisNew:sendPack(action, protoId, ...)
    if self.core then
        self.core:sendPack(action, protoId, ...)
    end
end

--------------------------------
-- 刷新方格
-- @function [parent=#TetrisNew] refreshGrid
function TetrisNew:refreshGrid()
    -- 处理上面的方块
    if self.upperBlockList and #self.upperBlockList > 0 then
        for _, block in pairs(self.upperBlockList) do 
            local x, y = block:getPosition()
            block:setPosition(cc.p(x, y - self.blockWidth * block.moveLines))
            block.moveLines = 0
            
        end
        self.upperBlockList = {}
        -- self:print()
    end
end

--------------------------------
-- 处理移除回调
-- @function [parent=#TetrisNew] removeCallBack
function TetrisNew:removeCallBack(sender)
    -- 处理额外属性
    if sender.extraAttributes then
        self.parent:handleExtraAttributes(sender)
    end

    -- 消除特殊事件处理
    if sender.eliminateProp then
        -- 处理消除事件
        local prop = sender.eliminateProp
        if prop.type == "insert" then
            self:doInsertGridBlockAnim(prop.x, prop.y, prop.newBlock)
        elseif prop.type == "replace" then
            self:doReplaceGridBlockAnim(prop.x, prop.y, prop.targetY, prop.newBlock)
        end
    end

    -- 特殊方块处理
    if sender.prop and sender.prop.blockType == 6 then
        -- 水滴方块
        self:handleExtraAttributes(sender)
    else
        sender:removeFromParent()
    end

    -- 更新分数
    self.callbackCount = self.callbackCount + 1
    if self.callbackCount >= self.callbackNums then
        self.callbackNums = 0
        self.callbackCount = 0
        self.parent:updateScore(self.removeLineNums, self.isSelf)
        self:refreshGrid()  
    end
end

--------------------------------
-- 固定位置插入一个block
-- @function [parent=#BaseBlock] insertBlock
function TetrisNew:insertBlock(gridX, gridY, block)
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
-- 处理额外属性
-- @function [parent=#TetrisNew] handleExtraAttributes
function TetrisNew:handleExtraAttributes(sender)
    if self.parent.handleExtraAttributes then
        self.parent:handleExtraAttributes(sender)
    end
end

--------------------------------
-- 增加行数
-- @function [parent=#TetrisNew] addLines
function TetrisNew:addLines(lines)
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
                local block = self:createGridBlock(self.core.grids[index][i], i, index)
                self.grids[index][i] = block
            end
        end
        index = index + 1
    end
    self:print()
end

--------------------------------
-- 随机下一个方块
-- @function [parent=#TetrisNew] createNextBlock
function TetrisNew:createNextBlock()
    -- 创建下一个出现的方块
    self.core:createNextBlock()

    -- 更新下一个节点
    if self.parent.updateNextBlock then
        self.nextBlock = self.parent:updateNextBlock(self.nextBlock)
    end

    return self.nextBlock
end

--------------------------------
-- 震屏效果
-- @function [parent=#TetrisNew] shake
function TetrisNew:shake(node, interval)
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
-- @function [parent=#TetrisNew] convertGridToPosition
function TetrisNew:convertGridToPosition(gridX, gridY)
    return (gridX - 1) * self.blockWidth + self.fixPixel, (gridY - 1) * self.blockWidth + self.fixPixel
end

--------------------------------
-- 退出时清理操作
-- @function [parent=#TetrisNew] onExit
function TetrisNew:onExit()
    if self.core then
        self.core:gameOver()
    end
end

return TetrisNew

