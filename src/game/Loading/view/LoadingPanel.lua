
--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- LoadingPanel 资源加载
local LoadingPanel = class("LoadingPanel", BasePanel)


--------------------------------
-- 场景创建
-- @function [parent=#LoadingPanel] onCreate 
-- @return
function LoadingPanel:onCreate(panel, panelName, openMethod, args)
    -- 创建界面
    local layout = require("layout.LoadingPanel").create()
    layout['root']:setPosition(cc.p(display.cx, display.cy))
    self:addChild(layout['root'])

    -- 资源
    self.loadList = {}

    -- 新的场景
    self.args = {panel = panel, panelName = panelName, openMethod = openMethod, args = args}

    -- 进度
    self.loadLabel = layout['load_label']
    self.progressBar = layout['LoadingBar_1']

    -- 分析需要加载的资源
    local loadingRes = panel.LoadingRes
    for key, value in pairs(loadingRes) do
        for _, _value in pairs(value) do
            table.insert(self.loadList, {type = key, file = _value[1], group = _value[2]})
        end
    end

    -- 计数器
    self.total = #self.loadList
    self.curr = 0

    -- 更新进度
    self:updateProgress()

    -- 添加帧事件
    -- self.frameHandler = scheduler.scheduleUpdateGlobal(handler(self, self.onFrames))    
    scheduler.scheduleUpdateGlobalByCoroutine(handler(self, self.onFrames))
end

--------------------------------
-- 帧循环
-- @function [parent=#LoadingPanel] onFrames 
-- @return
function LoadingPanel:onFrames()
    -- local res = self:peekNextRes()
    -- if (res == nil) then
    --     return
    -- end
    local res = self:peekNextRes()
    while res ~= nil do
        local type = string.lower(res.type)
        if res.type == "plist" then
            rmgr:loadSpriteFrames(res.file, res.group)
        elseif res.type == "image" then
            rmgr:loadTexture(res.file)
        elseif res.type == "armature" then
            rmgr:loadArmature(res.file, res.group)
        end
        res = self:peekNextRes()
        coroutine.yield()
    end
end

function LoadingPanel:peekNextRes()
    
    -- 更新进度
    self:updateProgress()

    -- 获取下一个资源
    self.curr = self.curr + 1
    if self.curr > self.total then
        self:handleLoadingEnd()
    else
        return self.loadList[self.curr]
    end
end

function LoadingPanel:handleLoadingEnd()
    -- scheduler.unscheduleGlobal(self.frameHandler)
    -- app:changeScene(self.args.sceneName, self.args.args, self.args.transition, self.args.time, self.args.more)
    log:info("handleLoadingEnd %s %s %s", self.args.openMethod, self.args.panelName, self.args.args)
    if self.args.openMethod == "open" then
        self:getScene():openPanel(self.args.panelName, self.args.args)
    else
        self:getScene():popAndPushPanel(self.args.panelName, self.args.args)
    end
end

function LoadingPanel:updateProgress()
    self.loadLabel:setString(self.curr .. "/" .. self.total)
    local value = math.modf(100 * self.curr / self.total)
    self.progressBar:setPercent(value)
end

function LoadingPanel:onCleanup()
    rmgr:removeTexture("ui/loading/load_progress1.png")
    rmgr:removeTexture("ui/loading/load_pregress2.png")
    rmgr:removeTexture("ui/loading/load_bg.png")
    rmgr:removeTexture("ui/loading/bg.png")
    rmgr:removeTexture("ui/loading/load_txt.png")
end



return LoadingPanel
