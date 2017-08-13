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

    -- 创建对战界面
    local pvpLayout = require("layout.TetrisPvp").create()
    self:fixLayout(pvpLayout)
    self.pvpLayer:addChild(pvpLayout["root"])
    self.btnPvp = pvpLayout['btn_pvp']
    self.btnCancel = pvpLayout['btn_cancel']
    self.searchPanel = pvpLayout['search_panel']

    -- 创建排行榜界面
    self.rankLayout = require("layout.TetrisRank").create()
    self:fixLayout(self.rankLayout)
    self.rankLayer:addChild(self.rankLayout['root'])

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
    -- 初始化玩家信息
    self:initPlayerInfo(barLayout)
    self:addObject(barLayout["root"], "scene")

    -- 初始底部信息
    self:initBottomBar(barLayout)
    self.topPanel = barLayout['top_panel']
    self.bottomPanel = barLayout['bottom_panel']
    

    -- 注册事件监听
    self.powerProgressEventListener = handler(self, self.updatePowerProgress)
    self.playerDataListener = handler(self, self.updatePlayerData)
    self.viewChangeListener = handler(self, self.handleViewChange)
    emgr:addEventListener(EventDefine.POWER_PROGRESS_UPDATE, self.powerProgressEventListener)
    emgr:addEventListener(EventDefine.PLAYER_UPDATE, self.playerDataListener)
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
        self.currPowerId = 2--progress.powerId
        self.currArmyId = 41--progress.armyId
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
-- 初始化玩家数据
-- @function [parent=#TetrisScene] initPlayerInfo
function TetrisScene:initPlayerInfo(barLayout)
    -- 动态设置contentSize
    local size = barLayout['bar_bg']:getContentSize()
    barLayout['bar_bg']:setContentSize(cc.size(display.width, size.height))
    
    -- 生命
    self.lbLife = barLayout['lb_energy']
    self.lbLife:setString(utils.gameArchive:queryData("lifes"))

    -- 钻石
    self.lbDiam = barLayout["lb_item"]
    self.lbDiam:setString(utils.gameArchive:queryData("diam"))

    self.btnBuyEnergy = barLayout['btn_buy_energy']
    self.btnBuyEnergy:addClickEventListener(handler(self, self.buyEnergy))

    self.btnBuyDiam = barLayout['btn_buy_item']
    self.btnBuyDiam:addClickEventListener(handler(self, self.buyDiam))
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
            self:addBtnAttackAnim(btn)
        end
    end
    
end

--------------------------------
-- 更新玩家数据
-- @function [parent=#TetrisScene] updatePlayerData
function TetrisScene:updatePlayerData(data)
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
-- @function [parent=#TetrisScene] playPlayerDataAnimation
function TetrisScene:playPlayerDataAnimation(value, item, callback)
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
    self:addObject(label, "top")

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
        -- btn:setVisible(false)
        newBtn.btn:setTag(powerId * 1000 + i)
        newBtn.btn:addClickEventListener(handler(self, self.handleArmyClick))
    else
        -- local pic = string.format("ui/tetris/power/%s.png", conf.pic)
        -- btn:loadTextureNormal(pic,0)
        -- btn:loadTexturePressed(pic,0)
        -- btn:loadTextureDisabled(pic,0)
        -- btn:setTag(powerId * 1000 + i)
        -- btn:addClickEventListener(handler(self, self.handleArmyClick))
        newBtn.btn:setEnabled(true)
        newBtn.btn:setTag(powerId * 1000 + i)
        newBtn.btn:addClickEventListener(handler(self, self.handleArmyClick))

        if powerId == self.currPowerId and armyId == self.currArmyId then
            -- 添加动画
            self:addBtnAttackAnim(newBtn)
        end
        -- local queryKey = "power." .. powerId .. "." .. i
        -- local star = utils.gameArchive:queryData(queryKey)
        -- if star == nil then
        -- elseif star >= 3 then
        --     newBtn.star1:setVisible(true)
        --     newBtn.star2:setVisible(true)
        --     newBtn.star3:setVisible(true)
        -- elseif star >= 2 then
        --     newBtn.star1:setVisible(true)
        --     newBtn.star2:setVisible(true)
        -- elseif star >= 1 then
        --     newBtn.star1:setVisible(true)
        -- end
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

    -- root.star1:setVisible(false)
    -- root.star2:setVisible(false)
    -- root.star3:setVisible(false)
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
            local unopenPic = string.format("power_clearstone_%s.png", "unopen")

            btn:loadTextureNormal(openPic, 1)
            btn:loadTexturePressed(openPic, 1)
            btn:loadTextureDisabled(unopenPic, 1)
        elseif conf.armyType == TetrisPowerConf.TYPE_TIMEMODE then
            local openPic = string.format("power_time_%s.png", "open")
            local unopenPic = string.format("power_time_%s.png", "unopen")

            btn:loadTextureNormal(openPic, 1)
            btn:loadTexturePressed(openPic, 1)
            btn:loadTextureDisabled(unopenPic, 1)
        elseif conf.armyType == TetrisPowerConf.TYPE_METEOR2 then
            local openPic = string.format("power_meteor_%s.png", "open")
            local unopenPic = string.format("power_meteor_%s.png", "unopen")

            btn:loadTextureNormal(openPic, 1)
            btn:loadTexturePressed(openPic, 1)
            btn:loadTextureDisabled(unopenPic, 1)
        elseif conf.armyType == TetrisPowerConf.TYPE_SPAR then
            local openPic = string.format("power_spar_%s.png", "open")
            local unopenPic = string.format("power_spar_%s.png", "unopen")

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
-- 初始化底部bar
-- @function [parent=#TetrisScene] initBottomBar
function TetrisScene:initBottomBar(barLayout)
    self.btnRank = barLayout['btn_rank']
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
    self.btnRank:addClickEventListener(handler(self, self.handleClickRank))

    self:handleClickSingle()
end

function TetrisScene:handleClickSingle()
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

    self.powerLayer:runAction(cc.MoveTo:create(0.2, cc.p(0, 0) ))
    self.pvpLayer:runAction(cc.MoveTo:create(0.2, cc.p(self.maxWidth, 0) ))
    self.rankLayer:runAction(cc.MoveTo:create(0.2, cc.p(-self.maxWidth, 0) ))
end

function TetrisScene:handleClickMulti()
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

    
    self.powerLayer:runAction(cc.MoveTo:create(0.2, cc.p(-self.maxWidth, 0) ))
    self.pvpLayer:runAction(cc.MoveTo:create(0.2, cc.p(0, 0) ))
    self.rankLayer:runAction(cc.MoveTo:create(0.2, cc.p(-self.maxWidth * 2, 0) ))
end

function TetrisScene:handleClickRank()
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
     self.pvpLayer:runAction(cc.MoveTo:create(0.2, cc.p(self.maxWidth * 2, 0) ))
     self.powerLayer:runAction(cc.MoveTo:create(0.2, cc.p(self.maxWidth, 0) ))
     self.rankLayer:runAction(cc.MoveTo:create(0.2, cc.p(0, 0) ))

     -- 拉取PVP数据
     self:initRankData()
end

function TetrisScene:pvpSearch()
    if cmgr:isConnected() then
        -- 报名
        -- self:pushPanel("Tetris.view.TetrisMulti", {""})
        self:signPvp()
    else
        Tips.showSceneTips("未连接服务器", 2)
        return
    end
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
    cmgr:send(actions.cancelFight, function() 
        self.btnCancel:setVisible(false)
        self.btnPvp:setVisible(true)
        self.searchPanel:setVisible(false)

        self.topPanel:setVisible(true)
        self.topPanel:runAction(cc.MoveTo:create(0.2, cc.p(318.64, 1094) ))
        self.bottomPanel:setVisible(true)
        self.bottomPanel:runAction(cc.MoveTo:create(0.2, cc.p(320.00, 50) ))
    end)
end

function TetrisScene:signPvp()
    cmgr:send(actions.quitFight)
    cmgr:send(actions.joinFight)

    self.pvpPushHandler = handler(self, self.handlePvpPush)
    cmgr:addPushCallback(actions.PUSH_FIGHT, self.pvpPushHandler)
end

function TetrisScene:handlePvpPush(response)
    if tolua.isnull(self) then
        return
    end

    local udpConv = nil
    if response.data.schedule ~= nil then
        local scheduleData = nil
        if response.data.schedule.def == nil then
            scheduleData = response.data.schedule
            scheduleData.def = {playerId=0, playerName="机器人小C", score=0, isAI=true, isHost=false}
            scheduleData.att.isHost = true
        elseif response.data.schedule.att.playerId == mmgr.player.playerId then
            scheduleData.att.isHost = true
            scheduleData.def.isHost = false
        else
            scheduleData.def.isHost = true
            scheduleData.att.isHost = false
        end

        self:pushPanel("Tetris.view.TetrisMulti", { scheduleData })

        -- 匹配到了，重置PVP界面
        cmgr:removePushCallback(actions.PUSH_FIGHT, self.pvpPushHandler)
        self:resetPvpView()

        -- 切换到pvp对战界面
        -- cmgr:send(actions.readyFight)
    end

        -- 建立udp连接
        -- if (udpConv) then
        --     ucmgr:open(udpConv, self.host, 8010)
        --     -- 添加PushHandler
        --     ucmgr:addPushCallback(actions.PUSH_FIGHT, self.pushHandler)
        -- end
end

function TetrisScene:resetPvpView()
    self.btnCancel:setVisible(false)
    self.btnPvp:setVisible(true)
    self.searchPanel:setVisible(false)

    self.topPanel:setVisible(true)
    self.topPanel:setPosition(cc.p(318.64, 1094))
    self.bottomPanel:setVisible(true)
    self.bottomPanel:setPosition(cc.p(320.00, 50))
end


function TetrisScene:buyEnergy()
    if not cmgr:isConnected() then
        Tips.showSceneTips("网络未连接，请检查网络！", 5, Tips.ERROR_COLOR)
        return
    end

    cmgr:send(actions.queryBuyLifeCost, function(response) 
        self:pushPanel("Tetris.view.TetrisTipsBuyEnergy", {response.data.cost})
    end)
end

function TetrisScene:buyDiam()
    if not cmgr:isConnected() then
        Tips.showSceneTips("网络未连接，请检查网络！", 5, Tips.ERROR_COLOR)
        return
    end

    cmgr:send(actions.getPayInfo, function(response) 
        self:pushPanel("Tetris.view.TetrisShop", {response.data})
    end)
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
                self:handleClickRank()
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
                self:handleClickSingle()
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
                self:handleClickSingle()
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
                self:handleClickMulti()
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
-- 初始化排行榜数据
-- @function [parent=#TetrisScene] initRankData
function TetrisScene:initRankData()
    -- 发包获取数据
    if not self.rankList then
        self.rankList = self.rankLayout['list_view']
        self.lbMyRank = self.rankLayout['lb_myrank']
        self.btnRecv = self.rankLayout['btn_recv']
        self.rankList:init()
    end

    -- 获取排行榜数据
    cmgr:send(actions.getRankInfo, function(response)
        local data = response.data
        if data.myRank == -1 then
            self.lbMyRank:setString("未上榜")
        else
            self.lbMyRank:setString(data.myRank)
        end

        if data.rewardState == 0 then
            self.btnRecv:setEnabled(false)
        else
            self.btnRecv:setEnabled(true)
        end
        self.maxPage = data.maxPage
        self.currPage = 1
        self.fetchData = true
        self.itemCount = 0

        self:initRankList(data.rankList)

        if self.maxPage > self.currPage then
            -- 监听滑动事件，拉取剩余数据
            self.rankList:onScroll(function(event) 
                if self.fetchData then
                    return
                end
                local percent = self.rankList:getScrollPercent()
                -- log:info("scroll percent:%s, eventName:%s", percent, event.name)
                if percent >= 0.6 and (self.maxPage > self.currPage) then
                     self.fetchData = true
                     self:getRankData(self.currPage)
                     self.currPage = self.currPage + 1
                end
            end)
        end
    end, 0)
    
    -- 清理数据
    self.rankList:removeAllChildren()
    self.rankList:init()
end

--------------------------------
-- 拉取排行榜数据
-- @function [parent=#TetrisScene] getRankData
function TetrisScene:getRankData(page)
    -- log:info("fetch data:%s", page)
    cmgr:send(actions.getRankInfo, function(response)
        self:initRankList(response.data.rankList)
    end, page)
end

--------------------------------
-- 将数据插入排行榜
-- @function [parent=#TetrisScene] getRankData
function TetrisScene:initRankList(dataList)
    -- 携程方式插入
    scheduler.scheduleGlobalByCoroutine(function()
        for index, data in pairs(dataList) do
            local layout = require("layout.TetrisRankItem").create()
            local cup = layout['sp_cup']
            local lbName = layout['lb_name']
            local lbPoint = layout['lb_point']
            local lbRank = layout['lb_rank']
            local bg = layout['bg']
            if data.rank <= 3 then
                cup:setTexture(string.format("ui/rank/cup%s.png", data.rank))
            else
                cup:setVisible(false)
                lbRank:setString(data.rank)
                lbRank:setVisible(true)
            end

            lbName:setString(data.playerName)
            lbPoint:setString(data.points)
            -- 是自己
            if data.playerId == mmgr.player.playerId then
                bg:setTexture("ui/rank/rank_line_self_bg.png")
            end
            
            local panel = layout['panel']
            panel:retain()
            panel:removeFromParent()
            panel:setScale(0.9)

            self.rankList:addItem(panel, true)
            coroutine.yield()
        end
        self.fetchData = false
    end, 0)
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

