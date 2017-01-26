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
    local layout = require("layout.TetrisMainScene").create()
    self:fixLayout(layout)

    -- 创建副本界面
    self:createPowerView()

    -- 添加事件监听
    self.btnMultiplayer = layout['btn_multiplayer']
    self.inputHost = cc.EditBox:create(cc.size(250, 70), cc.Scale9Sprite:create(), cc.Scale9Sprite:create())
    self.inputHost:setAnchorPoint(0.5, 0.5)
    self.inputHost:setPosition(125, 35)
    self.inputHost:setFontColor(cc.c3b(0, 128, 0))
    self.inputHost:setText("192.168.0.116")
    self.inputHost:setInputMode(6)
    layout['bg_input']:addChild(self.inputHost)
    
    self.btnMultiplayer:addClickEventListener(handler(self, self.playMulti))

    self:addObject(layout["root"], "scene")
end

--------------------------------
-- 创建副本
-- @function [parent=#TetrisScene] createPowerView
function TetrisScene:createPowerView()
    -- 副本大小
    self.powerNum = 2
    self.powerStartArmyNum = 59
    self.powerLoopArmyNum = 66
    self.currPowerId = 1
    self.currArmyId = 4

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

    self:addChild(self.tableView)
end

--------------------------------
-- 单机模式
-- @function [parent=#TetrisScene] playSingle
function TetrisScene:playSingle(powerId, armyId)
    local animationLayout = require("layout.TetrisStartAnimation").create()
    animationLayout['panel']:setAnchorPoint(0.5, 0.5)
    animationLayout['panel']:setPosition(display.cx, display.cy)
    self:addObject(animationLayout['root'], "modal")

    local animation = animationLayout['animation']
    animationLayout['root']:runAction(animation)
    animation:setLastFrameCallFunc(function()
        animationLayout['root']:removeFromParent()
    end)
    animation:setFrameEventCallFunc(function(frame)
        if frame:getEvent() == "loadNext" then
            local conf = TetrisPowerConf.loadConfig(powerId, armyId)
            self:pushPanel("Tetris.view." .. conf.module, {powerId, armyId})
        end
    end)
    animation:gotoFrameAndPlay(0, false) 
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

    Tips.showSceneTips(string.format("选择了第%s章第%s关", power, army), 1)
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
    else
        local pic = string.format("ui/tetris/power/%s.png", conf.pic)
        btn:loadTextureNormal(pic,0)
        btn:loadTexturePressed(pic,0)
        btn:loadTextureDisabled(pic,0)
        btn:setTag(powerId * 1000 + i)
        btn:addClickEventListener(handler(self, self.handleArmyClick))
    end
end

--------------------------------
-- 获取副本的章节数目
-- @function [parent=#TetrisScene] numberOfCellsInTableView
function TetrisScene:numberOfCellsInTableView(view)
    return self.powerNum
end

--------------------------------
-- 卸载资源
-- @function [parent=#TetrisScene] onExit
function TetrisScene:onExit()
    -- 卸载资源
end

return TetrisScene

