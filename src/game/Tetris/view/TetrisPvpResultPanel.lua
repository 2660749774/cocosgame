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

    self.playerInfo = {}
    self.targetPlayerInfo = {}
    
    self:initPlayerInfo(layout, self.playerInfo, "_self")
    self:initPlayerInfo(layout, self.targetPlayerInfo, "_target")

    self:initPanel(data)

    self.btnOk:addClickEventListener(handler(self, self.handleOk))

    self:addLayoutWithMask(layout, "layout.ModalMask")
end

--------------------------------
-- 初始化玩家数据
-- @function [parent=#TetrisPvpResultPanel] initPlayerInfo
function TetrisPvpResultPanel:initPlayerInfo(layout, playerInfo, suffix)
    playerInfo.lbPlayerName = layout['lb_name' .. suffix]
    playerInfo.lbScoreNum = layout['lb_num' .. suffix]
    playerInfo.lbScoreChange = layout['lb_score' .. suffix]
    playerInfo.winFlag = layout['win' .. suffix]
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
    else
        data.att.isWin = (data.att.playerId == data.winId)
        data.def.isWin = (data.def.playerId == data.winId)
        self:updatePlayerInfo(self.playerInfo, data.def)
        self:updatePlayerInfo(self.targetPlayerInfo, data.att)
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

return TetrisPvpResultPanel

