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
    self.callback = callback
    self.runTime = 0
end

--------------------------------
-- 更新函数
-- @function [parent=#ScheduleTask] update
function ScheduleTask:update(dt)
    self.runTime = self.runTime + dt
    if self.runTime >= self.dt then
        self.runTime = self.runTime - self.dt
        self.callback(self.dt)
    end
end

--------------------------------
-- 重置RunTime
-- @function [parent=#ScheduleTask] resetRunTime
function ScheduleTask:resetRunTime()
    self.runTime = 0
end

-- 固定帧率定时器
local timer = class("timer")

--------------------------------
-- 构造函数
-- @function [parent=#timer] ctor
function timer:ctor()
    self.scheduler = scheduler.scheduleUpdateGlobal(handler(self, self.update))
    self.schedulers = {}
    self.timeScale = 1
end

--------------------------------
-- 添加定时任务
-- @function [parent=#timer] scheduleTask
function timer:scheduleTask(callback, interval)
    interval = interval or 0
    local task = ScheduleTask.new(callback, interval)
    table.insert(self.schedulers, task)
    return task
end

--------------------------------
-- 移除定时任务
-- @function [parent=#timer] unscheduleTask
function timer:unscheduleTask(task)
    for index, value in pairs(self.schedulers) do
        if value == task then
            table.remove(self.schedulers, index)
            break
        end
    end
end


--------------------------------
-- 更新操作
-- @function [parent=#timer] update
function timer:update(dt)
    for i=1, self.timeScale do
        for _, task in pairs(self.schedulers) do
            task:update(dt)
        end
    end
end


--------------------------------
-- 设置加速
-- @function [parent=#timer] setTimeScale
function timer:setTimeScale(scale)
    self.timeScale = scale
    for _, task in pairs(self.schedulers) do
        task:resetRunTime()
    end
end

--------------------------------
-- 销毁定时器
-- @function [parent=#timer] setTimeScale
function timer:destroy()
    scheduler.unscheduleGlobal(self.scheduler)
end

return timer