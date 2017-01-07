
--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- uiTestScene 测试场景
-- local BaseTestScene = require("game.TestLua.tests.BaseTestScene")
local tableTestPanel = class("tableTestPanel", BasePanel)

function tableTestPanel:onCreate()
    -- BaseTestScene.onCreate(self)
    
    -- 重新注册事件
    self:getScene().btn:addClickEventListener(function (event)
        self:getScene():popPanel()
    end)

    log:info("test TableView %s", cc.TableView)
    self.testList = {}
    local tableView = cc.TableView:create(cc.size(400, 500))
    tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
    tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
    tableView:setPosition(cc.p(display.cx, 30))
    tableView:setDelegate()

    tableView:registerScriptHandler(handler(self, self.tableCellTouched), cc.TABLECELL_TOUCHED)
    tableView:registerScriptHandler(handler(self, self.cellSizeForTable), cc.TABLECELL_SIZE_FOR_INDEX)
    tableView:registerScriptHandler(handler(self, self.tableCellAtIndex), cc.TABLECELL_SIZE_AT_INDEX)
    tableView:registerScriptHandler(handler(self, self.numberOfCellsInTableView), cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
    tableView:registerScriptHandler(handler(self, self.tableCellHighLight), cc.TABLECELL_HIGH_LIGHT)
    tableView:registerScriptHandler(handler(self, self.tableCellUnHightLight), cc.TABLECELL_UNHIGH_LIGHT)

    tableView:reloadData()

    self:addChild(tableView)
end


function tableTestPanel:tableCellHighLight(view, cell)
    log:info("table view tableCellHighLight %s %s", view, cell)
end

function tableTestPanel:tableCellUnHightLight(view, cell)
    log:info("table view tableCellUnHighLight %s %s", view, cell)
end

function tableTestPanel:tableCellTouched(view, cell)
    log:info("table view tableCellTouched %s %s", view, cell)
    local content = cell:getChildByTag(1)
    if content then
        content:setString(content:getString() .. "被选中")
    end
end

function tableTestPanel:cellSizeForTable(view, idx)
    log:info("table view cellSizeForTable %s %s", view, cell)
    return 400, 45
end

function tableTestPanel:tableCellAtIndex(view, idx)
    log:info("table view tableCellAtIndex %s %s", view, cell)
    local cell = view:dequeueCell()
    if not sell then
        cell = cc.TableViewCell:create()
    end
    content = cell:getChildByTag(1)
    if not content then        
        local label = cc.Label:createWithSystemFont("test" .. idx,"Arial", 24)
        label:setTextColor(cc.c3b(0, 255, 0))
        label:setAnchorPoint(0, 0)
        label:setPosition(cc.p(0, 0))
        label:setTag(1)

        local sprite = cc.Sprite:create("Star.png")
        sprite:setAnchorPoint(0, 0)
        sprite:setPosition(cc.p(150, 0))
        sprite:setTag(1)

        cell:addChild(label)
        cell:addChild(sprite)
    else
        content:setString("test" .. idx)
    end
    
    

    return cell
end

function tableTestPanel:numberOfCellsInTableView(view)
    log:info("table view numberOfCellsInTableView %s", view)
    return 100
end


function tableTestPanel:onExit()
    -- 重新注册事件
    self:getScene().btn:addClickEventListener(function (event)
        app:changeScene("TestLua", {}, "random", 1)
    end)
end



return tableTestPanel
