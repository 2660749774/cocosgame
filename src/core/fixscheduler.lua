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
    self.scheduler = scheduler.scheduleUpdateGlobal(handler(self, self.update))
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
    -- if self.timeScale > 1 and self.serverFrameNum > 0 then
    --     self.fillFrameNum = self.timeScale - 1
    -- end
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
    table.insert(self.serverFrame[frameNum], event)
    -- if event.protoId == 1 and event.keyCode == 100 then
    --     -- log:info("addServerFrame keyCode 100 frameNum:%s, localFrameNum:%s", frameNum, self.frameNum)
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

    -- 逻辑帧率驱动显示帧率
    while (self.fixTime >= self.dt) do
        if self.serverFrameNum ~= -1 
            and self.frameNum >= self.serverFrameNum
            and self.fillFrameNum == 0 then
            -- 锁帧等待
            break
        elseif self.serverFrameNum == -1 or self.frameNum < self.serverFrameNum then
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

        -- 调用显示帧
        for i=1, self.timeScale do
            self:doUpdate(self.dt, self.callbackdt)
        end

        -- 处理服务器网络返回
        self:doServerFrame()
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
function fixscheduler:send(action, protoId, ...)
    -- if not self.sendPack then
    local args = { ... }
    local key = "" .. protoId
    for _, v in pairs(args) do
        key = key .. "-" .. v
    end
    if self.framePacks[key] == nil then
        table.insert(args, 1, self.frameNum)
        table.insert(args, 2, self.serverFrameNum)
        self.framePacks[key] = {action=action, protoId=protoId, args=args}

        if ucmgr:isConnected() then
            ucmgr:send(action, protoId, unpack(args))
        else
            cmgr:send(action, nil, protoId, unpack(args))
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
    if nil == self.serverFrameHandler then
        return
    end

 
    local eventList = self.serverFrame[self.frameNum]
    if nil ~= eventList then
        self.serverFrameHandler(eventList)
    end
    self.serverFrame[self.frameNum] = {}
end

--------------------------------
-- 设置加速
-- @function [parent=#fixscheduler] setTimeScale
function fixscheduler:setTimeScale(scale, fillFrameNum)
    self.timeScale = scale
    self.gameTime = 0
    self.fixTime = 0

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
-- @function [parent=#fixscheduler] setTimeScale
function fixscheduler:destroy()
    scheduler.unscheduleGlobal(self.scheduler)
end

return fixscheduler