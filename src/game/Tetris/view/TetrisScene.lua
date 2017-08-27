--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisScene 俄罗斯方块
local TetrisScene = class("TetrisScene", BaseScene)
local TetrisPowerConf = import("..data.TetrisPowerConf")

--------------------------------
-- 创建方法
-- @function [parent=#TetrisScene] onCreate
function TetrisScene:onCreate()
    -- Layers 获取Layer
    self.maxWidth = 852 - (852 - display.width) / 2
    self.powerLayer = cc.Layer:create()
    self.pvpLayer = cc.Layer:create()
    self.rankLayer = cc.Layer:create()
    self.touchLayer = cc.Layer:create()
    
    self.pvpLayer:setPosition(cc.p(self.maxWidth, 0))
    self.rankLayer:setPosition(cc.p(-self.maxWidth, 0))
    self:addObject(self.powerLayer, "scene")
    self:addObject(self.pvpLayer, "scene")
    self:addObject(self.rankLayer, "scene")
    self:addObject(self.touchLayer, "scene")

    -- 创建副本界面
    self:createPowerView()

    -- 创建bar界面
    self.barView = require("game.Tetris.view.sub.TetrisBarView"):create("barView", {self})
    self:addObject(self.barView, "scene")

    -- 创建对战界面
    self.pvpView = require("game.Tetris.view.sub.TetrisPvpView"):create("pvpView", {self, self.barView.topPanel, self.barView.bottomPanel})
    self.pvpLayer:addChild(self.pvpView)

    -- 创建排行榜界面
    self.rankView = require("game.Tetris.view.sub.TetrisRankView"):create("rankView")
    self.rankLayer:addChild(self.rankView)

    -- 注册事件监听
    self.powerProgressEventListener = handler(self, self.updatePowerProgress)
    self.viewChangeListener = handler(self, self.handleViewChange)
    emgr:addEventListener(EventDefine.POWER_PROGRESS_UPDATE, self.powerProgressEventListener)
    emgr:addEventListener(EventDefine.VIEW_CHANGE, self.viewChangeListener)

    -- 添加触摸监听
    self:addLayerTouchListener()

    -- 播放背景音乐
    amgr:playBgMusic({"main_bg1.mp3", "main_bg2.wav", "main_bg3.mp3"}, true)
end

--------------------------------
-- 创建副本
-- @function [parent=#TetrisScene] createPowerView
function TetrisScene:createPowerView()
    -- 副本大小
    self.powerNum = TetrisPowerConf.MAX_POWER_ID
    self.powerStartArmyNum = TetrisPowerConf.getPowerMaxArmyId(1)
    self.powerLoopArmyNum = TetrisPowerConf.getPowerMaxArmyId(2)
    self.layoutMap = {}

    local progress = utils.gameArchive:queryData("power.progress")
    if progress then
        self.currPowerId = progress.powerId
        self.currArmyId = progress.armyId
    else
        self.currPowerId = 1
        self.currArmyId = 1
    end

    -- 创建TableView
    self.tableView = cc.TableView:create(cc.size(display.width, display.height))
    self.tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    self.tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_BOTTOMUP)
    self.tableView:setDelegate()

    self.tableView:registerScriptHandler(handler(self, self.cellSizeForTable), cc.TABLECELL_SIZE_FOR_INDEX)
    self.tableView:registerScriptHandler(handler(self, self.tableCellAtIndex), cc.TABLECELL_SIZE_AT_INDEX)
    self.tableView:registerScriptHandler(handler(self, self.numberOfCellsInTableView), cc.NUMBER_OF_CELLS_IN_TABLEVIEW)

    self.tableView:reloadData()
    self.tableView:setContentOffset(cc.vertex2F(0, 0), false) -- 滑动到底部
    self.tableView:setBounceable(false) -- 禁止回弹

    self.powerLayer:addChild(self.tableView)
end

--------------------------------
-- 更新副本进度
-- @function [parent=#TetrisScene] updatePowerProgress
function TetrisScene:updatePowerProgress(progress)
    log:info("do updatePowerProgress event")
    log:showTable(progress)
    if progress.powerId > self.currPowerId or progress.armyId > self.currArmyId then
        -- 进度更新了
        local layout = self.layoutMap[self.currPowerId]
        local btn = layout['btn' .. self.currArmyId]
        if btn then
            btn.panel:removeChildByTag(5000)
        end

        -- 更新进度
        self.currPowerId = progress.powerId
        self.currArmyId = progress.armyId
        layout = self.layoutMap[self.currPowerId]
        btn = layout['btn' .. self.currArmyId]
        if btn then
            btn.btn:setEnabled(true)
            ShaderUtil.removeGray(btn.btn)
            ShaderUtil.removeGray(btn.lbArmyNum)
            self:addBtnAttackAnim(btn)
        end
    end
    
end

--------------------------------
-- 处理界面变更
-- @function [parent=#TetrisScene] handleViewChange
function TetrisScene:handleViewChange(viewName)
    if viewName == "MainScene" then
        amgr:playBgMusic({"main_bg1.mp3", "main_bg2.wav", "main_bg3.mp3"}, true)
    end
end

--------------------------------
-- 单机模式
-- @function [parent=#TetrisScene] playSingle
function TetrisScene:playSingle(powerId, armyId)
    self:pushPanel("Tetris.view.TetrisPowerStart", {powerId, armyId})
end

--------------------------------
-- 点击关卡
-- @function [parent=#TetrisScene] handleArmyClick
function TetrisScene:handleArmyClick(event)
    local target = event.target
    local tag = target:getTag()
    local power = math.floor(tag / 1000)
    local army = tag % 1000

    -- Tips.showSceneTips(string.format("选择了第%s章第%s关", power, army), 1)
    self:playSingle(power, army)
end


--------------------------------
-- 获取制定cell大小
-- @function [parent=#TetrisScene] tableCellAtIndex
function TetrisScene:cellSizeForTable(view, idx)
    return display.width, 2996
end

--------------------------------
-- 获取指定cell内容
-- @function [parent=#TetrisScene] tableCellAtIndex
function TetrisScene:tableCellAtIndex(view, idx)
    local cell = view:dequeueCell()
    if not sell then
        cell = cc.TableViewCell:create()
    end

    if idx == 0 then
        self:fillStartCell(cell, idx)   
    elseif idx == (self.powerNum - 1) then
        self:fillEndCell(cell, idx)   
    else
        self:fillLoopCell(cell, idx)   
    end

    return cell
end

--------------------------------
-- 填充开始格子
-- @function [parent=#TetrisScene] fillStartCell
function TetrisScene:fillStartCell(cell, idx)
    local layout = require("layout.TetrisPowerStart").create()
    local bg = layout['bg']
    for i = 1, self.powerStartArmyNum do 
        self:initArmyBtn(layout, idx, i)
    end
    bg:setPositionX(display.cx)
    cell:addChild(layout['root'])
end

--------------------------------
-- 填充结束格子
-- @function [parent=#TetrisScene] fillEndCell
function TetrisScene:fillEndCell(cell, idx)
    local layout = require("layout.TetrisPowerLoop").create()
    for i = 1, self.powerLoopArmyNum do 
        self:initArmyBtn(layout, idx, i)
    end
    local bg = layout['bg']
    local bgSize = bg:getContentSize()


    local endBg = cc.Sprite:createWithSpriteFrameName("unopen_bg.png")
    local endBgSize = endBg:getContentSize()
    endBg:setPosition(endBgSize.width / 2, bgSize.height - endBgSize.height / 2)
    bg:addChild(endBg)
    bg:setPositionX(display.cx)

    cell:addChild(layout['root'])
end

--------------------------------
-- 填充循环格子
-- @function [parent=#TetrisScene] fillLoopCell
function TetrisScene:fillLoopCell(cell, idx)
    local layout = require("layout.TetrisPowerLoop").create()
    for i = 1, self.powerLoopArmyNum do 
        self:initArmyBtn(layout, idx, i)
    end
    local bg = layout['bg']
    bg:setPositionX(display.cx)

    cell:addChild(layout['root'])
end

--------------------------------
-- 初始化副本按钮
-- @function [parent=#TetrisScene] initArmyBtn
function TetrisScene:initArmyBtn(layout, idx, i)
    local btn = layout['btn' .. i]
    local powerId = idx + 1
    local armyId = i
    local conf = TetrisPowerConf.loadConfig(powerId, i)

    local newBtn = self:createArmyBtn(conf, powerId, i)
    newBtn:setScale(0.8)
    if powerId > self.currPowerId or (powerId == self.currPowerId and i > self.currArmyId) then
        newBtn.btn:setEnabled(false)
        ShaderUtil.setGray(newBtn.btn)
        ShaderUtil.setGray(newBtn.lbArmyNum)
        newBtn.btn:setTag(powerId * 1000 + i)
        newBtn.btn:addClickEventListener(handler(self, self.handleArmyClick))
    else
        newBtn.btn:setEnabled(true)
        -- ShaderUtil.removeGray(newBtn.btn)
        -- ShaderUtil.removeGray(newBtn.lbArmyNum)
        newBtn.btn:setTag(powerId * 1000 + i)
        newBtn.btn:addClickEventListener(handler(self, self.handleArmyClick))

        if powerId == self.currPowerId and armyId == self.currArmyId then
            -- 添加动画
            self:addBtnAttackAnim(newBtn)
        end
    end

    local x, y = btn:getPosition()
    btn:removeFromParent()
    layout['btn' .. i] = newBtn
    newBtn:setPosition(x, y)
    layout['bg']:addChild(newBtn)
    if not self.layoutMap[powerId] then
        self.layoutMap[powerId] = layout
    end
end

--------------------------------
-- 创建副本据点按钮
-- @function [parent=#TetrisScene] numberOfCellsInTableView
function TetrisScene:createArmyBtn(conf, powerId, armyId)
    local layout = require("layout.TetrisPowerArmy").create()
    local root = layout['panel']
    local btn = layout['btn']
    root.btn = btn
    root.star1 = layout['star1']
    root.star2 = layout['star2']
    root.star3 = layout['star3']
    root.lbArmyNum = layout['lb_armynum']
    root.panel = layout['panel']

    root.btn:setEnabled(false)
    if powerId == 1 then
        root.lbArmyNum:setString(armyId)
    else
        root.lbArmyNum:setString(59 + armyId)
    end
    root.lbArmyNum:setScale(1.25)

    if conf == nil then
        -- 默认据点
        return root
    else
        -- log:info("conf type:%s", conf.armyType)
        if conf.armyType == TetrisPowerConf.TYPE_CLEAR_STONE then
            local openPic = string.format("power_clearstone_%s.png", "open")
            local unopenPic = string.format("power_clearstone_%s.png", "open")

            btn:loadTextureNormal(openPic, 1)
            btn:loadTexturePressed(openPic, 1)
            btn:loadTextureDisabled(unopenPic, 1)
        elseif conf.armyType == TetrisPowerConf.TYPE_TIMEMODE then
            local openPic = string.format("power_time_%s.png", "open")
            local unopenPic = string.format("power_time_%s.png", "open")

            btn:loadTextureNormal(openPic, 1)
            btn:loadTexturePressed(openPic, 1)
            btn:loadTextureDisabled(unopenPic, 1)
        elseif conf.armyType == TetrisPowerConf.TYPE_METEOR2 then
            local openPic = string.format("power_meteor_%s.png", "open")
            local unopenPic = string.format("power_meteor_%s.png", "open")

            btn:loadTextureNormal(openPic, 1)
            btn:loadTexturePressed(openPic, 1)
            btn:loadTextureDisabled(unopenPic, 1)
        elseif conf.armyType == TetrisPowerConf.TYPE_SPAR then
            local openPic = string.format("power_spar_%s.png", "open")
            local unopenPic = string.format("power_spar_%s.png", "open")

            btn:loadTextureNormal(openPic, 1)
            btn:loadTexturePressed(openPic, 1)
            btn:loadTextureDisabled(unopenPic, 1)
        end
    end
    root:retain()
    root:removeFromParent()
    return root
end

--------------------------------
-- 添加动画
-- @function [parent=#TetrisScene] addBtnAttackAnim
function TetrisScene:addBtnAttackAnim(btn)
    -- 添加动画
    local attackAnimLayout = require("layout.TetrisAttackAnimation").create()
    local animation = attackAnimLayout['animation']
    attackAnimLayout['root']:runAction(animation)
    attackAnimLayout['root']:setPosition(cc.p(100, 100))
    attackAnimLayout['root']:setLocalZOrder(-100)     
    attackAnimLayout['root']:setTag(5000)
    animation:gotoFrameAndPlay(0, true) 
    btn.panel:addChild(attackAnimLayout['root'])
end

--------------------------------
-- 获取副本的章节数目
-- @function [parent=#TetrisScene] numberOfCellsInTableView
function TetrisScene:numberOfCellsInTableView(view)
    return self.powerNum
end

--------------------------------
-- 处理点击副本按钮
-- @function [parent=#TetrisScene] handleClickSingle
function TetrisScene:handleClickSingle()
    self.currBtn = "single"
    self.powerLayer:runAction(cc.MoveTo:create(0.2, cc.p(0, 0) ))
    self.pvpLayer:runAction(cc.MoveTo:create(0.2, cc.p(self.maxWidth, 0) ))
    self.rankLayer:runAction(cc.MoveTo:create(0.2, cc.p(-self.maxWidth, 0) ))
end

--------------------------------
-- 处理点击PVP按钮
-- @function [parent=#TetrisScene] handleClickMulti
function TetrisScene:handleClickMulti()
    self.currBtn = "multi"
    self.powerLayer:runAction(cc.MoveTo:create(0.2, cc.p(-self.maxWidth, 0) ))
    self.pvpLayer:runAction(cc.MoveTo:create(0.2, cc.p(0, 0) ))
    self.rankLayer:runAction(cc.MoveTo:create(0.2, cc.p(-self.maxWidth * 2, 0) ))
end

--------------------------------
-- 处理点击排行榜按钮
-- @function [parent=#TetrisScene] handleClickRank
function TetrisScene:handleClickRank()
     self.currBtn = "rank"
     self.pvpLayer:runAction(cc.MoveTo:create(0.2, cc.p(self.maxWidth * 2, 0) ))
     self.powerLayer:runAction(cc.MoveTo:create(0.2, cc.p(self.maxWidth, 0) ))
     self.rankLayer:runAction(cc.MoveTo:create(0.2, cc.p(0, 0) ))

     -- 拉取PVP数据
     self.rankView:initRank()
end


--------------------------------
-- 添加触摸监听器
-- @function [parent=#TetrisScene] addLayerTouchListener
function TetrisScene:addLayerTouchListener()
    local listener = cc.EventListenerTouchOneByOne:create()

    -- 开始触摸
    listener:registerScriptHandler(function(touch, event) 
        self.touchPos = touch:getLocation()
        self.lastMovePos = touch:getLocation()
        self.layerTouchEnable = nil
        return true
    end, cc.Handler.EVENT_TOUCH_BEGAN)

    -- 触摸移动
    listener:registerScriptHandler(function(touch, event) 
        self.movePos = touch:getLocation()
        if (self.lastMovePos ~= null) then
            -- 移动
            if self.layerTouchEnable == nil then
                local moveX = self.movePos.x - self.lastMovePos.x
                local moveY = self.movePos.y - self.lastMovePos.y
                if math.abs(moveX) < 1 and math.abs(moveY) < 1 then
                    return
                end
                if math.abs(moveX) < math.abs(moveY) and (self.currBtn == "single" or self.currBtn == "rank") then
                    self.layerTouchEnable = false
                else
                    self.tableView:setTouchEnabled(false)
                    self.layerTouchEnable = true
                end
            end
            
            if self.layerTouchEnable then
                self:onMove(self.movePos.x - self.lastMovePos.x)
                self.lastMovePos = self.movePos
            end
        end

    end, cc.Handler.EVENT_TOUCH_MOVED)

    -- 结束触摸
    listener:registerScriptHandler(function(touch, event) 
        if self.layerTouchEnable then
            self.touchEndPos = touch:getLocation()
            if (self.touchPos ~= null) then
                -- 计算移动
                local moveX = self.touchEndPos.x - self.touchPos.x
                self:onMoveEnd(moveX)
            end
            self.layerTouchEnable = nil
            self.tableView:setTouchEnabled(true)
        end
    end, cc.Handler.EVENT_TOUCH_ENDED)

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self.touchLayer)

end

--------------------------------
-- 处理触摸结束
-- @function [parent=#TetrisScene] onMoveEnd
function TetrisScene:onMoveEnd(moveX)
    if moveX > 0 then
        -- 向右移动
        if self.currBtn == "rank" then
            -- 停留在此
            self.rankLayer:runAction(cc.MoveTo:create(0.2, cc.p(0, 0) ))
            self.powerLayer:runAction(cc.MoveTo:create(0.2, cc.p(self.maxWidth, 0) ))
            self.pvpLayer:runAction(cc.MoveTo:create(0.2, cc.p(self.maxWidth * 2, 0) ))
        elseif self.currBtn == "single" then
            local x, y = self.rankLayer:getPosition()
            if x >= -426 then
                -- 移动到排行榜
                self.barView:handleClickRank()
            else
                -- 停留在此
                self.rankLayer:runAction(cc.MoveTo:create(0.2, cc.p(-self.maxWidth, 0) ))
                self.powerLayer:runAction(cc.MoveTo:create(0.2, cc.p(0, 0) ))
                self.pvpLayer:runAction(cc.MoveTo:create(0.2, cc.p(self.maxWidth, 0) ))
            end
        elseif self.currBtn == "multi" then
            local x, y = self.pvpLayer:getPosition()
            if x >= 426 then
                -- 移动到power
                self.barView:handleClickSingle()
            else
                -- 停留在此
                self.rankLayer:runAction(cc.MoveTo:create(0.2, cc.p(-self.maxWidth * 2, 0) ))
                self.powerLayer:runAction(cc.MoveTo:create(0.2, cc.p(-self.maxWidth, 0) ))
                self.pvpLayer:runAction(cc.MoveTo:create(0.2, cc.p(0, 0) ))
            end
        end
    else
        -- 向左移动
        if self.currBtn == "rank" then
            local x, y = self.rankLayer:getPosition()
            if x <= -426 then
                -- 移动到power
                self.barView:handleClickSingle()
            else
                -- 停留在此
                self.rankLayer:runAction(cc.MoveTo:create(0.2, cc.p(0, 0) ))
                self.powerLayer:runAction(cc.MoveTo:create(0.2, cc.p(self.maxWidth, 0) ))
                self.pvpLayer:runAction(cc.MoveTo:create(0.2, cc.p(self.maxWidth * 2, 0) ))
            end
        elseif self.currBtn == "single" then
            local x, y = self.powerLayer:getPosition()
            if x <= -426 then
                -- 移动到pvp
                self.barView:handleClickMulti()
            else
                -- 停留在此
                self.rankLayer:runAction(cc.MoveTo:create(0.2, cc.p(-self.maxWidth, 0) ))
                self.powerLayer:runAction(cc.MoveTo:create(0.2, cc.p(0, 0) ))
                self.pvpLayer:runAction(cc.MoveTo:create(0.2, cc.p(self.maxWidth, 0) ))
            end
        elseif self.currBtn == "multi" then
            -- 停留在此
            self.powerLayer:runAction(cc.MoveTo:create(0.2, cc.p(-self.maxWidth, 0) ))
            self.pvpLayer:runAction(cc.MoveTo:create(0.2, cc.p(0, 0) ))
            self.rankLayer:runAction(cc.MoveTo:create(0.2, cc.p(-self.maxWidth * 2, 0) ))
        end
    end
end

--------------------------------
-- 处理移动，实时更新位置
-- @function [parent=#TetrisScene] onMove
function TetrisScene:onMove(moveX)
    -- log:info("onMove:%s", moveX)
    if moveX > 0 then
        -- 向右移动
        if self.currBtn == "rank" or self.currBtn == "single" then
            local x, y = self.rankLayer:getPosition()
            if (x + moveX) > 0 then
                return
            end
            self.rankLayer:setPosition(x + moveX, y)

            x, y = self.powerLayer:getPosition()
            self.powerLayer:setPosition(x + moveX, y)

            x, y = self.pvpLayer:getPosition()
            self.pvpLayer:setPosition(x + moveX, y)
        elseif self.currBtn == "multi" then
            local x, y = self.pvpLayer:getPosition()
            if (x + moveX) > self.maxWidth then
                return
            end
            self.pvpLayer:setPosition(x + moveX, y)

            x, y = self.powerLayer:getPosition()
            self.powerLayer:setPosition(x + moveX, y)

            x, y = self.rankLayer:getPosition()
            self.rankLayer:setPosition(x + moveX, y)
        end
    else
        -- 向左移动
        if self.currBtn == "rank" then
            local x, y = self.rankLayer:getPosition()
            if (x + moveX) < -self.maxWidth then
                return
            end
            self.rankLayer:setPosition(x + moveX, y)
            
            x, y = self.powerLayer:getPosition()
            self.powerLayer:setPosition(x + moveX, y)

            x, y = self.pvpLayer:getPosition()
            self.pvpLayer:setPosition(x + moveX, y)
        elseif self.currBtn == "single" then
            local x, y = self.powerLayer:getPosition()
            if (x + moveX) < -self.maxWidth then
                return
            end
            self.powerLayer:setPosition(x + moveX, y)

            x, y = self.rankLayer:getPosition()
            self.rankLayer:setPosition(x + moveX, y)

            x, y = self.pvpLayer:getPosition()
            self.pvpLayer:setPosition(x + moveX, y)
        elseif self.currBtn == "multi" then
            x, y = self.pvpLayer:getPosition()
            if (x + moveX) < 0 then
                return
            end
            self.pvpLayer:setPosition(x + moveX, y)

            local x, y = self.powerLayer:getPosition()
            self.powerLayer:setPosition(x + moveX, y)

            x, y = self.rankLayer:getPosition()
            self.rankLayer:setPosition(x + moveX, y)
        end
    end
end

--------------------------------
-- 卸载资源
-- @function [parent=#TetrisScene] onExit
function TetrisScene:onExit()
    -- 卸载资源
    -- 移除事件监听
    emgr:removeEventListener(EventDefine.POWER_PROGRESS_UPDATE, self.powerProgressEventListener)
    emgr:removeEventListener(EventDefine.VIEW_CHANGE, self.viewChangeListener)
end

return TetrisScene

