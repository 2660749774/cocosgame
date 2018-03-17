--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2016/12/28
-- Time: 19:13
-- To change this template use File | Settings | File Templates.
-- 固定帧率scheduler

-- 定时任务
local ScheduleTask = class("ScheduleTask")

--------------------------------
-- 构造函数
-- @function [parent=#ScheduleTask] ctor
function ScheduleTask:ctor(callback, dt)
    self.dt = dt
    self.callbackdt = self.dt / 1000
    self.callback = callback
    self.gameTime = 0
end

--------------------------------
-- 更新函数
-- @function [parent=#ScheduleTask] update
function ScheduleTask:update(dt, callbackdt)
    self.gameTime = self.gameTime + dt
    if self.gameTime >= self.dt then
        self.gameTime = self.gameTime - self.dt
        self.callback(self.callbackdt)
    end
end

--------------------------------
-- 重置GameTime
-- @function [parent=#ScheduleTask] resetGameTime
function ScheduleTask:resetGameTime()
    self.gameTime = 0
end

-- 固定帧率定时器
local fixscheduler = class("fixscheduler")

--------------------------------
-- 构造函数
-- @function [parent=#fixscheduler] ctor
function fixscheduler:ctor(dt)
    self.dt = dt * 1000
    self.callbackdt = dt
    self.gameTime = 0
    self.fixTime = 0
    self.currTime = cc.Util:getCurrentTime()
    self.scheduler = timer:scheduleTask(handler(self, self.update))
    self.schedulers = {}
    self.timeScale = 1
    self.frameNum = 0
    self.serverFrameNum = 0
    self.serverFrame = {}
    self.serverFrameHandler = nil
    self.fillFrameNum = 0 -- 补充帧
    self.fixTimeScale = 1
    self.updateTime = 0
    self.framePacks = {}
    self.jitterTime = 0
    self.jitterBuffer = {}
    self.jitterdt = 10
    self.delay = 0
    self.seq = 1
    self.preExecFrames = {}
    self.localFrame = {}
end

--------------------------------
-- 添加定时任务
-- @function [parent=#fixscheduler] scheduleTask
function fixscheduler:scheduleTask(callback, interval)
    interval = interval or self.callbackdt
    local _interval = interval * 1000
    _interval = math.max(self.dt, _interval)

    local task = ScheduleTask.new(callback, _interval)
    table.insert(self.schedulers, task)
    return task
end

--------------------------------
-- 移除定时任务
-- @function [parent=#fixscheduler] unscheduleTask
function fixscheduler:unscheduleTask(task)
    for index, value in pairs(self.schedulers) do
        if value == task then
            table.remove(self.schedulers, index)
            break
        end
    end

end

--------------------------------
-- 添加网络帧handler
-- @function [parent=#fixscheduler] addServerFrameHandler
function fixscheduler:addServerFrameHandler(handler)
    self.serverFrameHandler = handler
end

--------------------------------
-- 更新网络帧频
-- @function [parent=#fixscheduler] updateServerFrameNum
function fixscheduler:updateServerFrameNum(frameNum)
    self.serverFrameNum = frameNum
    -- log:info("updateServerFrameNum frameNum:%s, time:%s", self.serverFrameNum, cc.Util:getCurrentTime())
    -- table.insert(self.jitterBuffer, {frameNum = frameNum, span = 0})
    -- if self.timeScale > 1 and self.serverFrameNum > 0 then
    --     self.fillFrameNum = self.timeScale - 1
    -- end
end

--------------------------------
-- jitter tick
-- @function [parent=#fixscheduler] tickJitter
function fixscheduler:tickJitter(dt)
    local frame = self.jitterBuffer[1]
    if nil == frame then
        self.delay = self.delay + dt
        return
    end

    -- 增加积累包的延迟
    for _, value in pairs(self.jitterBuffer) do
        value.span = value.span + dt
    end

    -- 低于指定延迟
    if frame.span < self.delay then
        return
    end

    self.serverFrameNum = frame.frameNum
    table.remove(self.jitterBuffer, 1)

    -- 网络环境改善，降低延迟，缓冲区里面还有包
    local len = #self.jitterBuffer 
    if len > 0 and self.delay >= dt then
        self.delay = self.delay - dt
    elseif len == 0 then
        self.delay = self.delay + dt
    end
    -- log:info("tick jitter frameNum:%s, span:%s, buffSize:%s, sysDelay:%s", frame.frameNum, frame.span, #self.jitterBuffer, self.delay)
end

--------------------------------
-- 添加网络帧内容
-- @function [parent=#fixscheduler] addServerFrame
function fixscheduler:addServerFrame(frameNum, event)
    if self.serverFrameHandler == nil then
        return
    end

    if not self.serverFrame[frameNum] then
        self.serverFrame[frameNum] = {}
    end
    if not event.seq then
        local seq = self.seq
        self.seq = self.seq + 1
        event.seq = seq
    end
    table.insert(self.serverFrame[frameNum], event)

    if event.seq then
        -- 记录延迟
        actions.recordDelay(event.seq, "recv", cc.Util:getCurrentTime())
    end
    -- if event.protoId == 1 and event.keyCode == 100 then
        -- log:info("addServerFrame keyCode 100 frameNum:%s, localFrameNum:%s", frameNum, self.frameNum)
    -- end
end

--------------------------------
-- 更新操作
-- @function [parent=#fixscheduler] update
function fixscheduler:update()
    local currTime = cc.Util:getCurrentTime()
    local _dt = currTime - self.currTime

    -- 逻辑帧率
    self.fixTime = self.fixTime + (_dt * self.fixTimeScale)
    self.updateTime = self.updateTime + 1
    -- self.jitterTime = self.jitterTime  + _dt

    -- while (self.jitterTime >= self.jitterdt) do
    --     self.jitterTime = self.jitterTime - self.jitterdt

    --     -- tickJitter
    --     self:tickJitter(self.jitterdt)
    -- end

    -- log:info("loop jitter cost:%s", (cc.Util:getCurrentTime() - currTime))
    -- log:info("tetris update timeScale:%s, fixTimeScale:%s", self.timeScale, self.fixTimeScale)

    -- 逻辑帧率驱动显示帧率
    while (self.fixTime >= self.dt) do
        local frameNum = self.frameNum + 1
        if self.serverFrameNum ~= -1 
            and frameNum > self.serverFrameNum
            and self.fillFrameNum == 0 then
            self.fixTime = self.fixTime - self.dt
            -- 锁帧等待
            self:preExecFrame(frameNum)
            -- log:info("update frame inner1 serverFrameNum:%s, localFrameNum:%s, fillFrameNum:%s, fixTime:%s, time:%s", self.serverFrameNum, self.frameNum, self.fillFrameNum, self.fixTime, currTime)
            break
        elseif self.serverFrameNum == -1 or frameNum <= self.serverFrameNum then
            self.fixTime = self.fixTime - self.dt
            self.frameNum = self.frameNum + 1

            -- 发送网络请求
            self:sendFramePack()
        end

        -- 加速帧处理
        if self.fillFrameNum > 0 then
            self.fillFrameNum = self.fillFrameNum - 1
            if self.fillFrameNum == 0 then
                self.timeScale = 1
            end
        end

        -- log:info("loop self cost:%s", (cc.Util:getCurrentTime() - currTime))

        -- 调用显示帧
        for i=1, self.timeScale do
            self:doUpdate(self.dt, self.callbackdt)
        end

        -- log:info("loop update cost:%s", (cc.Util:getCurrentTime() - currTime))

        -- 处理服务器网络返回
        self:doServerFrame()

        -- log:info("update frame inner2 serverFrameNum:%s, localFrameNum:%s, fillFrameNum:%s, fixTime:%s, time:%s", self.serverFrameNum, self.frameNum, self.fillFrameNum, self.fixTime, currTime)

        if self.frameNum < self.serverFrameNum then
            self.fixTime = self.dt
        end

        -- log:info("loop serverFramecost:%s", (cc.Util:getCurrentTime() - currTime))
        
    end

    self.currTime = currTime

    -- 加速追帧逻辑
    local diff = self.serverFrameNum - self.frameNum
    -- if diff > 1 then
    --     log:info("frame diff :%s", diff)
    -- log:info("update frame serverFrameNum:%s, localFrameNum:%s, fillFrameNum:%s", self.serverFrameNum, self.frameNum, self.fillFrameNum)
    -- end
    if diff < 4 then
        self.fixTimeScale = 1
    else
        self.fixTimeScale = 10
    end
end

--------------------------------
-- 发送网络包
-- @function [parent=#fixscheduler] doUpdate
function fixscheduler:send(playerId, action, protoId, ...)
    -- if not self.sendPack then
    local args = { ... }
    local key = "" .. protoId
    local value = ""
    local index = 1
    for _, v in pairs(args) do
        key = key .. "-" .. v
        if index == 1 then
            value = value .. v
        else
            value = value .. "," .. v
        end
        index = index + 1
    end

    if self.framePacks[key] == nil then
        local seq = self.seq
        self.seq = self.seq + 1

        table.insert(args, 1, self.frameNum)
        table.insert(args, 2, self.serverFrameNum)
        table.insert(args, 3, seq)

        local event = {playerId = playerId, action = action, protoId = protoId, seq = seq, args = value}
        self.framePacks[key] = event

        -- 记录延迟
        actions.recordDelay(seq, "send", cc.Util:getCurrentTime())

        if ucmgr:isConnected() then
            ucmgr:send(action, protoId, unpack(args))
        else
            cmgr:send(action, nil, protoId, unpack(args))
        end

        -- 如果当前没有延迟，直接执行
        if self.frameNum == self.serverFrameNum then
            -- local frameNum = self.frameNum + 1
            -- log:info("pre exec, add frameNum:%s, seq:%s", self.frameNum, seq)
            if (event.args ~= "4" and event.protoId == protos.KEY_PRESS) then
                event.frameNum = self.frameNum
                event.execute = false
                table.insert(self.localFrame, event)
            end
            -- if not self.preExecFrames[frameNum] then
            --     self.preExecFrames[frameNum] = {}
            -- end
            -- self.preExecFrames[frameNum][seq] = event
            -- if self.serverFrameHandler then
            --     self.serverFrameHandler(event)
            -- end
        end
        
        -- table.insert(self.framePacks, {action=action, protoId=protoId, args=args})
    end
        -- cmgr:send(action, nil, protoId, unpack(args))
    -- end
end

--------------------------------
-- 发送网络包
-- @function [parent=#fixscheduler] doUpdate
function fixscheduler:sendFramePack()
    -- for _, pack in pairs(self.framePacks) do
    --     cmgr:send(pack.action, nil, pack.protoId, unpack(pack.args))
    -- end
    self.framePacks = {}
    -- if not self.sendPack then
        -- local args = { ... }
        -- table.insert(args, 1, self.frameNum)
        -- table.insert(args, 2, self.serverFrameNum)
        -- table.insert(self.framePacks, {action=action, protoId=protoId, args=args})
        -- cmgr:send(action, nil, protoId, unpack(args))
    -- end
end

--------------------------------
-- 执行更新操作
-- @function [parent=#fixscheduler] doUpdate
function fixscheduler:doUpdate(dt, callbackdt)
    for _, task in pairs(self.schedulers) do
        task:update(dt, callbackdt)
    end
end

--------------------------------
-- 处理网络帧
-- @function [parent=#fixscheduler] doServerFrame
function fixscheduler:doServerFrame()
    -- log:info("doServerFrame frameNum:%s, handler:%s, event:%s", self.frameNum, self.serverFrameHandler, self.serverFrame[self.frameNum])
    if nil == self.serverFrameHandler then
        return
    end

    -- 执行服务器帧号
    local eventList = self.serverFrame[self.frameNum]
    local preEventList = self.preExecFrames[self.frameNum]
    local seqList = {}
    if nil ~= eventList then
        for _, event in pairs(eventList) do
            if event.seq and nil ~= preEventList and preEventList[event.seq] then
                preEventList[event.seq] = nil
                -- log:info("pre exec, already frameNum:%s, seq:%s", self.frameNum, event.seq)
            else
                self.serverFrameHandler(event)
                seqList[event.seq] = 1
            end
        end
    end

    -- 检查是否有过早执行的，回退
    if nil ~= preEventList then
        for _, value in pairs(preEventList) do
            if value ~= nil then
                value.reverse = true
                -- log:info("pre exec, rollback frameNum:%s, seq:%s, protoId:%s, reverse:%s", self.frameNum, value.seq, value.protoId, value.reverse)
                self.serverFrameHandler(value)
            end
        end
    end

    -- 检查预执行帧清理
    if #self.localFrame > 0 then
        for _, event in pairs(self.localFrame) do
            if seqList[event.seq] == 1 then
                -- log:info("pre exec, drop frameNum:%s, seq:%s", self.frameNum, event.seq)
                event.execute = true
            end
        end
    end

    -- 执行清理
    self.serverFrame[self.frameNum] = {}
    self.preExecFrames[self.frameNum] = {}
end

--------------------------------
-- 预执行帧号
-- @function [parent=#fixscheduler] preExecFrame
function fixscheduler:preExecFrame(frameNum)
    if #self.localFrame <= 0 then
        return
    end

    for _, event in pairs(self.localFrame) do
        if event.frameNum < frameNum and not event.execute then
            local seq = event.seq
            -- log:info("pre exec, frameNum:%s, seq:%s", frameNum, seq)
            if not self.preExecFrames[frameNum] then
                self.preExecFrames[frameNum] = {}
            end
            self.preExecFrames[frameNum][seq] = event
            if self.serverFrameHandler then
                self.serverFrameHandler(event)
            end
        end
    end
    self.localFrame = {}
end

--------------------------------
-- 设置加速
-- @function [parent=#fixscheduler] setTimeScale
function fixscheduler:setTimeScale(scale, fillFrameNum)
    self.timeScale = scale
    self.gameTime = 0
    self.fixTime = 0
    -- log:traceback()

    if scale > 1 then
        self.fillFrameNum = fillFrameNum
    else
        self.fillFrameNum = 0
    end
    -- log:info("setTimeScale frameNum:%s, timeScale:%s", self.frameNum, scale)
    for _, task in pairs(self.schedulers) do
        task:resetGameTime()
    end
end

--------------------------------
-- 销毁定时器
-- @function [parent=#fixscheduler] destroy
function fixscheduler:destroy()
    timer:unscheduleTask(self.scheduler)
end

return fixscheduler