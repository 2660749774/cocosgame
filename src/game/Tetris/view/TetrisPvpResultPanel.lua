--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisPvpResultPanel 俄罗斯方块Pvp介绍模块
-- 副本开始介绍
local TetrisPvpResultPanel = class("TetrisPvpResultPanel", BasePanel)
local TetrisPowerConf = import("..data.TetrisPowerConf")

--------------------------------
-- 创建方法
-- @function [parent=#TetrisPvpResultPanel] onCreate
function TetrisPvpResultPanel:onCreate(data)
    log:info("TetrisPvpResultPanel data:%s", data)
    log:showTable(data)
    local layout = require("layout.TetrisPvpResult").create()
    self.disableTransition = true
    self.bg = layout['bg']
    self.btnOk = layout['btn_ok']
    self.panel = layout['panel']
    self.data = data
    self.layout = layout

    self.playerInfo = {}
    self.targetPlayerInfo = {}
    
    self:initPlayerInfo(layout, self.playerInfo, "_self")
    self:initPlayerInfo(layout, self.targetPlayerInfo, "_target")

    self:initPanel(data)

    self.btnOk:addClickEventListener(handler(self, self.handleOk))

    self:addLayoutWithMask(layout, "layout.ModalMask")
    self:playAnimation(data)
end

--------------------------------
-- 初始化玩家数据
-- @function [parent=#TetrisPvpResultPanel] initPlayerInfo
function TetrisPvpResultPanel:initPlayerInfo(layout, playerInfo, suffix)
    playerInfo.lbPlayerName = layout['lb_name' .. suffix]
    playerInfo.lbScoreNum = layout['lb_num' .. suffix]
    playerInfo.lbScoreChange = layout['lb_score' .. suffix]
    playerInfo.winFlag = layout['win' .. suffix]
    playerInfo.scorePanel = layout['score_panel' .. suffix]
end

--------------------------------
-- 初始化
-- @function [parent=#TetrisPvpResultPanel] initPanel
function TetrisPvpResultPanel:initPanel(data)
    if data.att.isHost then
        data.att.isWin = (data.att.playerId == data.winId)
        data.def.isWin = (data.def.playerId == data.winId)
        self:updatePlayerInfo(self.playerInfo, data.att)
        self:updatePlayerInfo(self.targetPlayerInfo, data.def)

        if data.att.isWin then
            -- 替换背景
            self.bg:setTexture("ui/pvp/blue_win_bg.png")
        end
    else
        data.att.isWin = (data.att.playerId == data.winId)
        data.def.isWin = (data.def.playerId == data.winId)
        self:updatePlayerInfo(self.playerInfo, data.def)
        self:updatePlayerInfo(self.targetPlayerInfo, data.att)

        if data.def.isWin then
            -- 替换背景
            self.bg:setTexture("ui/pvp/blue_win_bg.png")
        end
    end
end

--------------------------------
-- 更新玩家信息
-- @function [parent=#TetrisPvpResultPanel] updatePlayerInfo
function TetrisPvpResultPanel:updatePlayerInfo(playerInfo, data)
    log:info("updatePlayerInfo:%s", data)
    log:showTable(data)
    playerInfo.lbPlayerName:setString(data.playerName)
    playerInfo.lbScoreNum:setString(tostring(data.score))
    if data.isWin then
        playerInfo.winFlag:setVisible(true)
        playerInfo.lbScoreChange:setString("+23")
    else
        playerInfo.winFlag:setVisible(false)
        playerInfo.lbScoreChange:setString("-23")
    end
end

--------------------------------
-- 处理点击确认
-- @function [parent=#TetrisPvpResultPanel] handleOk
function TetrisPvpResultPanel:handleOk()
    local scene = self:getScene()
    scene:popPanel()
    scene:popPanel()

    -- 重新进入主页
    emgr:dispatchEvent(EventDefine.VIEW_CHANGE, "MainScene")
end

--------------------------------
-- 播放动画
-- @function [parent=#TetrisPvpResultPanel] playAnimation
function TetrisPvpResultPanel:playAnimation(data)
    local winPlayerInfo = nil
    -- 先播获胜者动画
    if data.att.isHost then
        data.att.isWin = (data.att.playerId == data.winId)
        data.def.isWin = (data.def.playerId == data.winId)
        if data.att.isWin then
            winPlayerInfo = self.playerInfo
        else
            winPlayerInfo = self.targetPlayerInfo
        end
    else
        data.att.isWin = (data.att.playerId == data.winId)
        data.def.isWin = (data.def.playerId == data.winId)
        if data.att.isWin then
            winPlayerInfo = self.targetPlayerInfo
        else
            winPlayerInfo = self.playerInfo
        end
    end

    -- winPlayerInfo.winFlag:setScale(2)
    -- winPlayerInfo.winFlag:setOpacity(40)
    winPlayerInfo.winFlag:setScale(2)
    local action1 = cc.ScaleTo:create(0.8, 1)
    local action2 = cc.FadeTo:create(0.8, 255)
    local spawn = cc.Spawn:create(action1, action2)
    winPlayerInfo.winFlag:runAction(cc.EaseBounceOut:create(spawn))

    self.playerInfo.scorePanel:setOpacity(0)
    self.playerInfo.scorePanel:setScale(2)
    local sequence2 = cc.Sequence:create(cc.DelayTime:create(1), cc.EaseBounceOut:create(spawn:clone()))
    self.playerInfo.scorePanel:runAction(sequence2)

    self.targetPlayerInfo.scorePanel:setOpacity(0)
    self.targetPlayerInfo.scorePanel:setScale(2)
    local sequence3 = cc.Sequence:create(cc.DelayTime:create(2), cc.EaseBounceOut:create(spawn:clone()))
    self.targetPlayerInfo.scorePanel:runAction(sequence3)
    
end

return TetrisPvpResultPanel

