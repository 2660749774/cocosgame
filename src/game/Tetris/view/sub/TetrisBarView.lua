--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisBarView  俄罗斯方块
-- 上下边栏view

local TetrisBarView = class("TetrisBarView", BaseView)

--------------------------------
-- 创建方法
-- @function [parent=#TetrisBarView] onCreate
function TetrisBarView:onCreate(scene)
    self.layout = require("layout.TetrisMainBar").create()

    -- 初始化界面
    -- 动态设置contentSize
    local size = self.layout['bar_bg']:getContentSize()
    self.layout['bar_bg']:setContentSize(cc.size(display.width, size.height))
    self.lbLife = self.layout['lb_energy']
    self.lbDiam = self.layout["lb_item"]
    self.btnBuyEnergy = self.layout['btn_buy_energy']
    self.btnBuyDiam = self.layout['btn_buy_item']
    self.scene = scene

    -- 初始化玩家信息
    self:initPlayerInfo()

    -- 初始化按钮信息
    self:initBottomBar()
    self.topPanel = self.layout['top_panel']
    self.bottomPanel = self.layout['bottom_panel']

    -- 添加按钮监听器
    self.playerDataListener = handler(self, self.updatePlayerData)
    emgr:addEventListener(EventDefine.PLAYER_UPDATE, self.playerDataListener)

    self:addLayout(self.layout)
end

--------------------------------
-- 初始化玩家数据
-- @function [parent=#TetrisBarView] initPlayerInfo
function TetrisBarView:initPlayerInfo()
    -- 生命
    self.lbLife:setString(utils.gameArchive:queryData("lifes"))

    -- 钻石
    self.lbDiam:setString(utils.gameArchive:queryData("diam"))

    -- 添加按钮监听事件
    self.btnBuyEnergy:addClickEventListener(handler(self, self.buyEnergy))
    self.btnBuyDiam:addClickEventListener(handler(self, self.buyDiam))
end

--------------------------------
-- 初始化底部bar
-- @function [parent=#TetrisBarView] initBottomBar
function TetrisBarView:initBottomBar()
    self.btnRank = self.layout['btn_rank']
    self.btnSingle = self.layout['btn_single']
    self.btnMulti = self.layout['btn_multi']
    self.btnLeft = self.layout['btn_left']
    self.btnRight = self.layout['btn_right']
    self.bar1 = self.layout['bar1']
    self.bar2 = self.layout['bar2']
    self.bar3 = self.layout['bar3']
    self.barChoose = self.layout['bar_choose']
    self.barLight = self.layout['bar_light']
    self.lbIntro = self.layout['lb_intro']
    self.currBtn = ""

    self.btnLeft:setVisible(false)
    self.btnRight:setVisible(false)

    self.btnSingle:addClickEventListener(handler(self, self.handleClickSingle))
    self.btnMulti:addClickEventListener(handler(self, self.handleClickMulti))
    self.btnRank:addClickEventListener(handler(self, self.handleClickRank))

    self:handleClickSingle()
end

--------------------------------
-- 处理点击副本按钮
-- @function [parent=#TetrisBarView] handleClickSingle
function TetrisBarView:handleClickSingle()
    if (self.currBtn == "single") then
        return
    end

    self.barChoose:setPosition(cc.p(320, 50))
    self.barLight:runAction(cc.MoveTo:create(0.2, cc.p(320, 50) ))
    
    self.bar1:setPosition(cc.p(82.5, 50))
    self.btnRank:setPosition(cc.p(82.5, 55))
    self.btnRank:setScale(0.8)

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
    self.scene:handleClickSingle()
end

--------------------------------
-- 处理点击PVP按钮
-- @function [parent=#TetrisBarView] handleClickMulti
function TetrisBarView:handleClickMulti()
    if (self.currBtn == "multi") then
        return
    end

    self.barChoose:setPosition(cc.p(485, 50))
    self.barLight:runAction(cc.MoveTo:create(0.2, cc.p(485, 50) ))

    self.bar1:setPosition(cc.p(82.5, 50))
    self.btnRank:setPosition(cc.p(82.5, 55))
    self.btnRank:setScale(0.8)

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

    self.scene:handleClickMulti()
end

--------------------------------
-- 处理点击排行榜按钮
-- @function [parent=#TetrisBarView] handleClickRank
function TetrisBarView:handleClickRank()
    if (self.currBtn == "rank") then
        return
    end

     self.barChoose:setPosition(cc.p(155, 50))
     self.barLight:runAction(cc.MoveTo:create(0.2, cc.p(155, 50) ))

     self.bar1:setPosition(cc.p(82.5, 50))
     self.btnRank:setPosition(cc.p(155, 85))
     self.btnRank:setScale(1)
     self.lbIntro:setString("排行榜")
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

     self.currBtn = "rank"
     self.scene:handleClickRank()
end

--------------------------------
-- 更新玩家数据
-- @function [parent=#TetrisBarView] updatePlayerData
function TetrisBarView:updatePlayerData(data)
    log:info("do updatePlayerData event, data:%s", data)
    log:showTable(data)

    if data.lifes then
        local oldValue = tonumber(self.lbLife:getString())
        self:playPlayerDataAnimation(data.lifes - oldValue, self.lbLife, function()
            self.lbLife:setString(data.lifes)
        end)
    end

    if data.diam then
        local oldValue = tonumber(self.lbDiam:getString())
        self:playPlayerDataAnimation(data.diam - oldValue, self.lbDiam, function()
            self.lbDiam:setString(data.diam)
        end)
    end
end

--------------------------------
-- 增加动画
-- @function [parent=#TetrisBarView] playPlayerDataAnimation
function TetrisBarView:playPlayerDataAnimation(value, item, callback)
    -- 创建Label
    local label = ccui.Text:create()
    label:setFontSize(28)
    label:enableShadow({r = 0, g = 0, b = 0, a = 255}, {width = 1, height = -1}, 0)
    if (value > 0) then
        label:setString("+" .. value)
        label:setColor(ColorUtil.hexColor("#00FF75"))
    else
        label:setString(value)
        label:setColor(ColorUtil.hexColor("#FF2E00"))
    end

    local pos = item:convertToWorldSpace(cc.vertex2F(0, 0))
    label:setPosition(pos.x + 80, pos.y + 14)
    self:addChild(label)

    local action1 = cc.MoveTo:create(0.5, cc.p(pos.x + 40, pos.y  + 14))
    local action2 = cc.FadeOut:create(0.5)
    local sequence1 = cc.Sequence:create(action1, action2, cc.CallFunc:create(function() 
        label:removeFromParent()
    end))

    local delayAction = cc.DelayTime:create(0.3)
    local action3 = cc.ScaleTo:create(0.2, 1.5)
    local action4 = cc.ScaleTo:create(0.2, 1)
    local sequence2 = cc.Sequence:create(delayAction, action3, action4, cc.CallFunc:create(function() 
        if callback then
            callback()
        end
    end))

    label:runAction(sequence1)
    item:runAction(sequence2)
end

--------------------------------
-- 购买体力
-- @function [parent=#TetrisBarView] buyEnergy
function TetrisBarView:buyEnergy()
    if not cmgr:isConnected() then
        Tips.showSceneTips("网络未连接，请检查网络！", 5, Tips.ERROR_COLOR)
        return
    end

    cmgr:send(actions.queryBuyLifeCost, function(response) 
        self.scene:pushPanel("Tetris.view.TetrisTipsBuyEnergy", {response.data.cost})
    end)
end

--------------------------------
-- 购买钻石
-- @function [parent=#TetrisBarView] buyDiam
function TetrisBarView:buyDiam()
    if not cmgr:isConnected() then
        Tips.showSceneTips("网络未连接，请检查网络！", 5, Tips.ERROR_COLOR)
        return
    end

    cmgr:send(actions.getPayInfo, function(response) 
        self.scene:pushPanel("Tetris.view.TetrisShop", {response.data})
    end)
end

--------------------------------
-- 界面退出时候调用
-- @function [parent=#TetrisBarView] buyDiam
function TetrisBarView:onExit()
    emgr:removeEventListener(EventDefine.PLAYER_UPDATE, self.playerDataListener)
end

return TetrisBarView

