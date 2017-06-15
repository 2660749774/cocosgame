--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisPowerPanel 俄罗斯方块
local TetrisPowerPanel = class("TetrisPowerPanel", BasePanel)

--------------------------------
-- 创建方法
-- @function [parent=#TetrisPowerPanel] onCreate
function TetrisPowerPanel:onCreate()
    -- 副本大小
    self.powerNum = 2
    self.powerStartArmyNum = 59
    self.powerLoopArmyNum = 66

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

function TetrisPowerPanel:handleArmyClick(event)
    local target = event.target
    local tag = target:getTag()
    local power = math.floor(tag / 1000)
    local army = tag % 1000

    Tips.showSceneTips(string.format("选择了第%s章第%s关", power, army), 1)
end


--------------------------------
-- 获取制定cell大小
-- @function [parent=#TetrisPowerPanel] tableCellAtIndex
function TetrisPowerPanel:cellSizeForTable(view, idx)
    return display.width, 2996
end

--------------------------------
-- 获取指定cell内容
-- @function [parent=#TetrisPowerPanel] tableCellAtIndex
function TetrisPowerPanel:tableCellAtIndex(view, idx)
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
-- @function [parent=#TetrisPowerPanel] fillStartCell
function TetrisPowerPanel:fillStartCell(cell, idx)
    local layout = require("layout.TetrisPowerStart").create()
    local bg = layout['bg']
    for i = 1, self.powerStartArmyNum do 
        local btn = layout['btn' .. i]
        btn:setTag((idx + 1) * 1000 + i)
        btn:addClickEventListener(handler(self, self.handleArmyClick))
    end
    bg:setPositionX(display.cx)
    cell:addChild(layout['root'])
end

--------------------------------
-- 填充结束格子
-- @function [parent=#TetrisPowerPanel] fillEndCell
function TetrisPowerPanel:fillEndCell(cell, idx)
    local layout = require("layout.TetrisPowerLoop").create()
    for i = 1, self.powerLoopArmyNum do 
        local btn = layout['btn' .. i]
        btn:setTag((idx + 1) * 1000 + i)
        btn:addClickEventListener(handler(self, self.handleArmyClick))
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
-- @function [parent=#TetrisPowerPanel] fillLoopCell
function TetrisPowerPanel:fillLoopCell(cell)
    local layout = require("layout.TetrisPowerLoop").create()
    for i = 1, self.powerLoopArmyNum do 
        local btn = layout['btn' .. i]
        btn:setTag((idx + 1) * 1000 + i)
        btn:addClickEventListener(handler(self, self.handleArmyClick))
    end
    local bg = layout['bg']
    bg:setPositionX(display.cx)

    cell:addChild(layout['root'])
end

--------------------------------
-- 获取副本的章节数目
-- @function [parent=#TetrisPowerPanel] numberOfCellsInTableView
function TetrisPowerPanel:numberOfCellsInTableView(view)
    return self.powerNum
end

--------------------------------
-- 卸载资源
-- @function [parent=#TetrisPowerPanel] onExit
function TetrisPowerPanel:onExit()
    -- 卸载资源
    local tipLayer = self:getScene():getLayer("tips")
    tipLayer:removeAllChildren()
end

return TetrisPowerPanel

