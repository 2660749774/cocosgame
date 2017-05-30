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
    -- local layout = require("layout.TetrisMainScene").create()
    -- self:fixLayout(layout)
    -- self:addObject(layout["root"], "scene")

    -- Layers 获取Layer
    self.maxWidth = 852 - (852 - display.width) / 2
    self.powerLayer = cc.Layer:create()
    self.pvpLayer = cc.Layer:create()
    self.touchLayer = cc.Layer:create()
    
    self.pvpLayer:setPosition(cc.p(self.maxWidth, 0))
    self:addObject(self.powerLayer, "scene")
    self:addObject(self.pvpLayer, "scene")
    self:addObject(self.touchLayer, "scene")

    -- 创建副本界面
    self:createPowerView()

    -- 创建对战界面
    local pvpLayout = require("layout.TetrisPvp").create()
    self:fixLayout(pvpLayout)
    self.pvpLayer:addChild(pvpLayout["root"])
    self.btnPvp = pvpLayout['btn_pvp']
    self.btnCancel = pvpLayout['btn_cancel']
    self.searchPanel = pvpLayout['search_panel']

    -- 添加search动画
    local searchAnimLayout = require("layout.TetrisSearchAnimation").create()
    local animation = searchAnimLayout['animation']
    searchAnimLayout['root']:setPosition(cc.p(-48.47, 13.57))
    searchAnimLayout['root']:runAction(animation)
    animation:gotoFrameAndPlay(0, true) 
    self.searchPanel:addChild(searchAnimLayout['root'])

    self.btnPvp:addClickEventListener(handler(self, self.pvpSearch))
    self.btnCancel:addClickEventListener(handler(self, self.pvpCancel))

    -- 创建bar
    local barLayout = require("layout.TetrisMainBar").create()
    self:fixLayout(barLayout)
    local size = barLayout['bar_bg']:getContentSize()
    barLayout['bar_bg']:setContentSize(cc.size(display.width, size.height))
    self:addObject(barLayout["root"], "scene")
    self:initBottomBar(barLayout)
    self.topPanel = barLayout['top_panel']
    self.bottomPanel = barLayout['bottom_panel']
    

    -- 添加事件监听
    -- self.btnMultiplayer = layout['btn_multiplayer']
    -- self.inputHost = cc.EditBox:create(cc.size(350, 70), cc.Scale9Sprite:create(), cc.Scale9Sprite:create())
    -- self.inputHost:setAnchorPoint(0.5, 0.5)
    -- self.inputHost:setPosition(175, 35)
    -- self.inputHost:setFontColor(cc.c3b(0, 128, 0))
    -- self.inputHost:setText("192.168.1.4")
    -- self.inputHost:setInputMode(6)
    -- layout['bg_input']:addChild(self.inputHost)
    
    -- self.btnMultiplayer:addClickEventListener(handler(self, self.playMulti))

    -- 注册事件监听
    self.eventListener = handler(self, self.updatePowerProgress)
    emgr:addEventListener(EventDefine.EventDefine, self.eventListener)

    -- 添加触摸监听
    self:addLayerTouchListener()
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
    self.currPowerId = progress.powerId
    self.currArmyId = progress.armyId

    local layout = self.layoutMap[self.currPowerId]
    local btn = layout['btn' .. self.currArmyId]
    local conf = TetrisPowerConf.loadConfig(self.currPowerId, self.currArmyId)
    local pic = string.format("ui/tetris/power/%s.png", conf.pic)
    btn:loadTextureNormal(pic,0)
    btn:loadTexturePressed(pic,0)
    btn:loadTextureDisabled(pic,0)
    btn:setVisible(true)
end

--------------------------------
-- 单机模式
-- @function [parent=#TetrisScene] playSingle
function TetrisScene:playSingle(powerId, armyId)
    self:pushPanel("Tetris.view.TetrisPowerStart", {powerId, armyId})
end

--------------------------------
-- 联网模式
-- @function [parent=#TetrisScene] playSingle
function TetrisScene:playMulti()
    local host = self.inputHost:getText()
    log:info("host %s", host)
    if host == nil or host == "" then
        Tips.showSceneTips("请输入连接的主机名称", 2)
        return
    end
    self:pushPanel("Tetris.view.TetrisMulti", {host})
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

    local endBg = cc.Sprite:create("ui/tetris/power/unopen_bg.png")
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
    local conf = TetrisPowerConf.loadConfig(powerId, i)
    if powerId > self.currPowerId or (powerId == self.currPowerId and i > self.currArmyId) then
        btn:setVisible(false)
        btn:setTag(powerId * 1000 + i)
        btn:addClickEventListener(handler(self, self.handleArmyClick))
    else
        local pic = string.format("ui/tetris/power/%s.png", conf.pic)
        btn:loadTextureNormal(pic,0)
        btn:loadTexturePressed(pic,0)
        btn:loadTextureDisabled(pic,0)
        btn:setTag(powerId * 1000 + i)
        btn:addClickEventListener(handler(self, self.handleArmyClick))
    end
    if not self.layoutMap[powerId] then
        self.layoutMap[powerId] = layout
    end
end

--------------------------------
-- 获取副本的章节数目
-- @function [parent=#TetrisScene] numberOfCellsInTableView
function TetrisScene:numberOfCellsInTableView(view)
    return self.powerNum
end

--------------------------------
-- 初始化底部bar
-- @function [parent=#TetrisScene] initBottomBar
function TetrisScene:initBottomBar(barLayout)
    self.btnShop = barLayout['btn_shop']
    self.btnSingle = barLayout['btn_single']
    self.btnMulti = barLayout['btn_multi']
    self.btnLeft = barLayout['btn_left']
    self.btnRight = barLayout['btn_right']
    self.bar1 = barLayout['bar1']
    self.bar2 = barLayout['bar2']
    self.bar3 = barLayout['bar3']
    self.barChoose = barLayout['bar_choose']
    self.barLight = barLayout['bar_light']
    self.lbIntro = barLayout['lb_intro']
    self.currBtn = ""

    self.btnLeft:setVisible(false)
    self.btnRight:setVisible(false)

    self.btnSingle:addClickEventListener(handler(self, self.handleClickSingle))
    self.btnMulti:addClickEventListener(handler(self, self.handleClickMulti))
    self.btnShop:addClickEventListener(handler(self, self.handleClickShop))

    self:handleClickSingle()
end

function TetrisScene:handleClickSingle()
    if (self.currBtn == "single") then
        return
    end

    self.barChoose:setPosition(cc.p(320, 50))
    self.barLight:runAction(cc.MoveTo:create(0.2, cc.p(320, 50) ))
    
    self.bar1:setPosition(cc.p(82.5, 50))
    self.btnShop:setPosition(cc.p(82.5, 55))
    self.btnShop:setScale(0.8)

    self.bar2:setPosition(cc.p(320, 50))
    self.btnSingle:setPosition(cc.p(320, 85))
    self.btnSingle:setScale(1)
    self.lbIntro:setString("副 本")
    self.lbIntro:setPosition(cc.p(320, 20))

    self.bar3:setPosition(cc.p(557.50, 50))
    self.btnMulti:setPosition(cc.p(557.50, 55))
    self.btnMulti:setScale(0.8)

    self.btnLeft:setPosition(cc.p(223, 50))
    self.btnLeft:setVisible(true)
    self.btnRight:setPosition(cc.p(417, 50))
    self.btnRight:setVisible(true)


    self.currBtn = "single"

    self.powerLayer:runAction(cc.MoveTo:create(0.2, cc.p(0, 0) ))
    self.pvpLayer:runAction(cc.MoveTo:create(0.2, cc.p(self.maxWidth, 0) ))
end

function TetrisScene:handleClickMulti()
    if (self.currBtn == "multi") then
        return
    end

    self.barChoose:setPosition(cc.p(485, 50))
    self.barLight:runAction(cc.MoveTo:create(0.2, cc.p(485, 50) ))

    self.bar1:setPosition(cc.p(82.5, 50))
    self.btnShop:setPosition(cc.p(82.5, 55))
    self.btnShop:setScale(0.8)

    self.bar2:setPosition(cc.p(247.5, 50))
    self.btnSingle:setPosition(cc.p(247.5, 55))
    self.btnSingle:setScale(0.8)

    self.bar3:setPosition(cc.p(485, 50))
    self.btnMulti:setPosition(cc.p(485, 85))
    self.btnMulti:setScale(1)
    self.lbIntro:setString("对 战")
    self.lbIntro:setPosition(cc.p(485, 20))

    self.btnLeft:setPosition(cc.p(388, 50))
    self.btnLeft:setVisible(true)
    self.btnRight:setVisible(false)

    self.currBtn = "multi"

    
    self.powerLayer:runAction(cc.MoveTo:create(0.2, cc.p(-self.maxWidth, 0) ))
    self.pvpLayer:runAction(cc.MoveTo:create(0.2, cc.p(0, 0) ))
end

function TetrisScene:handleClickShop()
    if (self.currBtn == "shop") then
        return
    end

     self.barChoose:setPosition(cc.p(155, 50))
     self.barLight:runAction(cc.MoveTo:create(0.2, cc.p(155, 50) ))

     self.bar1:setPosition(cc.p(82.5, 50))
     self.btnShop:setPosition(cc.p(155, 85))
     self.btnShop:setScale(1)
     self.lbIntro:setString("商 店")
     self.lbIntro:setPosition(cc.p(155, 20))

     self.bar2:setPosition(cc.p(392.5, 50))
     self.btnSingle:setPosition(cc.p(392.5, 55))
     self.btnSingle:setScale(0.8)

     self.bar3:setPosition(cc.p(557.50, 50))
     self.btnMulti:setPosition(cc.p(557.50, 55))
     self.btnMulti:setScale(0.8)

    
     self.btnLeft:setVisible(false)
     self.btnRight:setPosition(cc.p(252, 50))
     self.btnRight:setVisible(true)

     self.currBtn = "shop"
end

function TetrisScene:pvpSearch()
    self.btnPvp:setVisible(false)
    self.btnCancel:setVisible(true)
    self.searchPanel:setVisible(true)

    local sequence = cc.Sequence:create(cc.MoveTo:create(0.2, cc.p(318.64, 1190)), 
                                        cc.CallFunc:create(function() 
                                            self.topPanel:setVisible(false)
                                        end))
    self.topPanel:runAction(sequence)

    sequence = cc.Sequence:create(cc.MoveTo:create(0.2, cc.p(320.00, -50)), 
                                        cc.CallFunc:create(function() 
                                            self.bottomPanel:setVisible(false)
                                        end))
    self.bottomPanel:runAction(sequence)
end

function TetrisScene:pvpCancel()
    self.btnCancel:setVisible(false)
    self.btnPvp:setVisible(true)
    self.searchPanel:setVisible(false)

    self.topPanel:setVisible(true)
    self.topPanel:runAction(cc.MoveTo:create(0.2, cc.p(318.64, 1094) ))
    self.bottomPanel:setVisible(true)
    self.bottomPanel:runAction(cc.MoveTo:create(0.2, cc.p(320.00, 50) ))
end


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
                if math.abs(moveX) < math.abs(moveY) and self.currBtn == "single" then
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

function TetrisScene:onMoveEnd(moveX)
    log:info("onMoveEnd:%s", moveX)
    if moveX > 0 then
        -- 向右移动
        if self.currBtn == "single" then
            -- 停留在此
            self.powerLayer:runAction(cc.MoveTo:create(0.2, cc.p(0, 0) ))
            self.pvpLayer:runAction(cc.MoveTo:create(0.2, cc.p(self.maxWidth, 0) ))
        elseif self.currBtn == "multi" then
            local x, y = self.pvpLayer:getPosition()
            if x >= 426 then
                -- 移动到power
                self:handleClickSingle()
            else
                -- 停留在此
                self.powerLayer:runAction(cc.MoveTo:create(0.2, cc.p(-self.maxWidth, 0) ))
                self.pvpLayer:runAction(cc.MoveTo:create(0.2, cc.p(0, 0) ))
            end
        end
    else
        -- 向左移动
        if self.currBtn == "single" then
            local x, y = self.powerLayer:getPosition()
            if x <= -426 then
                -- 移动到power
                self:handleClickMulti()
            else
                -- 停留在此
                self.powerLayer:runAction(cc.MoveTo:create(0.2, cc.p(0, 0) ))
                self.pvpLayer:runAction(cc.MoveTo:create(0.2, cc.p(self.maxWidth, 0) ))
            end
        elseif self.currBtn == "multi" then
            -- 停留在此
            self.powerLayer:runAction(cc.MoveTo:create(0.2, cc.p(-self.maxWidth, 0) ))
            self.pvpLayer:runAction(cc.MoveTo:create(0.2, cc.p(0, 0) ))
        end
    end
end

function TetrisScene:onMove(moveX)
    log:info("onMove:%s", moveX)
    if moveX > 0 then
        -- 向右移动
        if self.currBtn == "single" then
            local x, y = self.powerLayer:getPosition()
            if (x + moveX) > 0 then
                return
            end
            self.powerLayer:setPosition(x + moveX, y)

            x, y = self.pvpLayer:getPosition()
            self.pvpLayer:setPosition(x + moveX, y)
        elseif self.currBtn == "multi" then
            x, y = self.pvpLayer:getPosition()
            if (x + moveX) > self.maxWidth then
                return
            end
            self.pvpLayer:setPosition(x + moveX, y)

            local x, y = self.powerLayer:getPosition()
            self.powerLayer:setPosition(x + moveX, y)

            
        end
    else
        -- 向左移动
        if self.currBtn == "single" then
            local x, y = self.powerLayer:getPosition()
            if (x + moveX) < -self.maxWidth then
                return
            end
            self.powerLayer:setPosition(x + moveX, y)

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
        end
    end
end

--------------------------------
-- 卸载资源
-- @function [parent=#TetrisScene] onExit
function TetrisScene:onExit()
    -- 卸载资源
    -- 移除事件监听
    emgr:removeEventListener(EventDefine.EventDefine, self.eventListener)
end

return TetrisScene

