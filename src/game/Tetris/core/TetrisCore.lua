--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2016/12/31
-- Time: 15:16
-- To change this template use File | Settings | File Templates.
-- TetrisCore 俄罗斯方块核心层

local TetrisCore = class("TetrisCore")
local Block1 = import(".BlockCore1")
local Block2 = import(".BlockCore2")
local Block3 = import(".BlockCore3")
local Block4 = import(".BlockCore4")
local Block5 = import(".BlockCore5")
local Block6 = import(".BlockCore6")
local Block7 = import(".BlockCore7")
local RandomUtil = require "core.util.RandomUtil"

--------------------------------
-- 创建方法
-- @function [parent=#TetrisCore] onCreate
function TetrisCore:ctor(isNet, width, height)
    self.id = 0
    self.grids = {}
    self.blockMap = {}

    self.isNet = isNet
    self.width = width
    self.height = height
    self.blockWidth = 27
    
    self.state = 0 -- 0 未开始 1 进行中 2 结束了
    self.frameNum = 0
    self.serverFrameNum = 0
    self.pauseFrameNum = 0

    self.block = nil
    self.nextBlock = nil
    self.eventStack = {}
end

--------------------------------
-- 根据配置文件初始化
-- @function [parent=#TetrisCore] onCreate
function TetrisCore:init(conf)
    self:initGrid(self.width, self.height)
    -- self:initGridBlock(conf)
end

--------------------------------
-- 定时调用
-- @function [parent=#TetrisCore] doUpdate
function TetrisCore:doUpdate(dt)
    -- 状态检查
    if self.state ~= 1 then
        return
    end

    -- 暂停计数器更新
    if self.pauseFrameNum > 0 then
        self.pauseFrameNum = self.pauseFrameNum - 1
        if self.pauseFrameNum <= 0 then
            self:roundStart()
        end
        return
    end

    if self.block == nil then
        -- 检查是否结束了
        return
    end

    -- log:info("[core]x:%s, y:%s", self.block.x, self.block.y)
    self.block:doAction("down")
    if not self:checkAvailable(self.block.x, self.block.y, self.block:getBlockArray()) then
        -- 不可以下降，回退
        self.block:doAction("down", true)

        -- 进行下落
        self:merge(self.block)

        -- 合并block
        table.insert(self.eventStack, {
            name = "MergeBlock"
        })

        -- log:info("-----------------------------------------------")
        -- self:print()
        -- 当前block消失
        self.block = nil

        -- 判断消除
        if self:checkBlockEliminate() then
            self.pauseFrameNum = 1
        else
            self:roundStart()
        end
    end
end

--------------------------------
-- 处理输入
-- @function [parent=#TetrisCore] handleInput
function TetrisCore:handleInput(keyCode)
    -- TODO 网络下，发送服务器
    log:info("[core]handleInput %s", keyCode)
    -- self:handleFrameData({keyCode=keyCode})
    self.fixScheduler:addServerFrame(self.fixScheduler.frameNum + 1, {keyCode=keyCode})
end

--------------------------------
-- 处理服务器帧
-- @function [parent=#TetrisCore] handleInput
function TetrisCore:handleServerFrame(eventList)
    log:info("[core]handleServerFrame %s", data)
    for _, event in pairs(eventList) do
        self:handleFrameData(event)
    end
end

--------------------------------
-- 处理帧数据event
-- @function [parent=#TetrisCore] handleInput
function TetrisCore:handleFrameData(data)
    if self.block == nil then
        return
    end

    local action = nil
    if data.keyCode == 1 then
        action = "left"
    elseif data.keyCode == 2 then
        action = "right"
    elseif data.keyCode == 3 then
        action = "shift"
    elseif data.keyCode == 4 then
        -- 持续下降
        action = "down"
        while true do
            self.block:doAction(action)
            if not self:checkAvailable(self.block.x, self.block.y, self.block:getBlockArray()) then
                self.block:doAction(action, true)
                break
            end
        end
        
        -- 插入一个震屏事件
        table.insert(self.eventStack, {
            name = "Shake"
        })
    elseif data.keyCode == 5 then
        action = "down"
    end

    if action ~= nil then
        self.block:doAction(action)
        if not self:checkAvailable(self.block.x, self.block.y, self.block:getBlockArray()) then
            -- 不可以行动，回退
            self.block:doAction(action, true)
        end
    end 
end

--------------------------------
-- 游戏开始
-- @function [parent=#TetrisCore] gameStart
function TetrisCore:gameStart(conf)
    -- 初始化方格
    self:init(conf)

    -- 创建第一个方块
    self:createNextBlock()

    -- 添加事件
    table.insert(self.eventStack, {
        name = "GameStart",
        grids = self.grids,
        nextBlock = self.nextBlock
    })

    -- 设置定时器
    self.fixScheduler = require "core.fixscheduler".new(0.05)
    self.fixScheduler:addServerFrameHandler(handler(self, self.handleServerFrame))
    if not self.isNet then
        self.fixScheduler:updateServerFrameNum(-1)
    end
    self.updateTask = self.fixScheduler:scheduleTask(handler(self, self.doUpdate), 0.5)

    -- 回合开始
    self:roundStart()

    -- 修改状态
    self.state = 1
end

--------------------------------
-- 一个回合开始，一个回合指的是一个方块到下落结束
-- @function [parent=#TetrisCore] roundStart
function TetrisCore:roundStart()
    local oldNextBlock = self.nextBlock
    
    -- 创建方块
    self.block = self:createBlock(self.nextBlock.type, self.nextBlock.x, self.nextBlock.y, self.nextBlock.idx)
    if self.isNet then
        self.block.x = 5
        self.block.y = 16
    else
        self.block.x = 6
        self.block.y = 16
    end

    -- 随机下一块方块
    self:createNextBlock()

    table.insert(self.eventStack, {
        name = "RoundStart",
        block = self.block,
        nextBlock = self.nextBlock
    })

    -- 设置速度
    self.fixScheduler:setTimeScale(1)
end

--------------------------------
-- 创建下一个出现的方块
-- @function [parent=#TetrisCore] createNextBlock
function TetrisCore:createNextBlock()
    local block = self:createRandomBlock()

    self.nextBlock = block
end

--------------------------------
-- 随机创建一个方块
-- @function [parent=#TetrisCore] createRandomBlock
function TetrisCore:createRandomBlock()
    local type = RandomUtil:nextInt(7)
    local x, y = 7, 30
    local idx = 1

    return self:createBlock(type, x, y , idx)
end

--------------------------------
-- 创建指定方块
-- @function [parent=#TetrisCore] createBlock
function TetrisCore:createBlock(type, x, y, idx)
    local block = nil
    if type == 1 then
        block = Block1:create(x, y, idx)
    elseif type == 2 then
        block = Block2:create(x, y, idx)
    elseif type == 3 then
        block = Block3:create(x, y, idx)
    elseif type == 4 then
        block = Block4:create(x, y, idx)
    elseif type == 5 then
        block = Block5:create(x, y, idx)
    elseif type == 6 then
        block = Block6:create(x, y, idx)
    elseif type == 7 then
        block = Block7:create(x, y, idx)
    end

    return block
end

--------------------------------
-- 判断消除
-- @function [parent=#TetrisCore] checkBlockEliminate
function TetrisCore:checkBlockEliminate()
    -- 消除判断
    local eliminateArr = {}
    local eliminateNum = 0
    for i = #self.grids, 1, -1 do
        local canEliminate = true
        for j = 1, #self.grids[i] do
            if self.grids[i][j] == 0 then
                canEliminate = false
                break
            end
        end
        if canEliminate then
            eliminateArr[i] = true
            eliminateNum = eliminateNum + 1
        else
            eliminateArr[i] = false
        end
    end

    -- 进行消除
    if eliminateNum > 0 then
        local nextIdx = 1
        for i = 1, self.row do
            while (nextIdx <= self.row and eliminateArr[nextIdx]) do
                nextIdx = nextIdx + 1
            end

            if i == nextIdx then
                nextIdx = nextIdx + 1
            else
                if nextIdx <= self.row then
                    for j = 1, self.col do
                        self.grids[i][j] = self.grids[nextIdx][j]
                    end
                    nextIdx = nextIdx + 1
                else
                    for j = 1, self.col do
                        self.grids[i][j] = 0
                    end
                end
            end
        end

        -- 插入消除事件
        table.insert(self.eventStack, {
            name = "Eliminate",
            eliminateArr = eliminateArr
        })
    end

    return eliminateNum > 0
end

--------------------------------
-- 进行融合
-- @function [parent=#TetrisCore] merge
function TetrisCore:merge(block)
    local blockArray = block:getBlockArray()
    local tx = block.x
    local ty = block.y
    for i = 4, 1, -1 do
        for j = 1, 4 do
            if blockArray[i][j] ~= 0 then
                local bx, by = j, (4 - i) + 1
                self.grids[ty + by][tx + bx] = blockArray[i][j]
            end
        end
    end
end

--------------------------------
-- 检查当前位置是否可用
-- @function [parent=#TetrisCore] onCreate
function TetrisCore:checkAvailable(tx, ty, blockArray)
    for i = 1, 4 do
        for j = 1, 4 do
            if blockArray[i][j] ~= 0 then
                local bx, by = j, (4 - i) + 1
                if (tx + bx < 1) or (tx + j > self.col) or (ty + by < 1) then
                    -- 边界检查
                    return false
                end
                if self.grids[ty + by] and self.grids[ty + by][tx + bx] == 1 then
                    return false
                end
            end
        end
    end

    return true
end

--------------------------------
-- 初始化Grid
-- @function [parent=#TetrisCore] initGrid
function TetrisCore:initGrid(width, height)
    self.col = width / self.blockWidth
    self.row = height / self.blockWidth

    for i = 1, self.row do
        for j = 1, self.col do
            if self.grids[i] == nil then
                self.grids[i] = {}
            end
            table.insert(self.grids[i], 0)
        end
    end
end

--------------------------------
-- 打印tetris
-- @function [parent=#TetrisCore] print
function TetrisCore:print()
    local fmt = ""
    for i = 1, self.col do
        if i == 1 then
            fmt = fmt .. "%s"
        else
            fmt = fmt .. " %s"
        end
    end
    for i = self.row, 1, -1 do
        log:info(fmt, unpack(self.grids[i]))
    end
end

--------------------------------
-- 拉取事件
-- @function [parent=#TetrisCore] pollEvent
function TetrisCore:pollEvent()
    local event = nil
    if #self.eventStack > 0 then
        event = self.eventStack[1]
        table.remove(self.eventStack, 1)
    end
    return event
end


return TetrisCore

