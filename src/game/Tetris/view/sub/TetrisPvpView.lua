--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisPvpView  俄罗斯方块
-- Pvp模块

local TetrisPvpView = class("TetrisPvpView", BaseView)

--------------------------------
-- 创建方法
-- @function [parent=#TetrisPvpView] onCreate
function TetrisPvpView:onCreate(scene, topPanel, bottomPanel)
    self.layout = require("layout.TetrisPvp").create()

    -- 初始化界面
    self.btnPvp = self.layout['btn_pvp']
    self.btnCancel = self.layout['btn_cancel']
    self.searchPanel = self.layout['search_panel']
    self.topPanel = topPanel
    self.bottomPanel = bottomPanel
    self.scene = scene

    -- 播放动画
    local searchAnimLayout = require("layout.TetrisSearchAnimation").create()
    local animation = searchAnimLayout['animation']
    searchAnimLayout['root']:setPosition(cc.p(-48.47, 13.57))
    searchAnimLayout['root']:runAction(animation)
    animation:gotoFrameAndPlay(0, true) 
    self.searchPanel:addChild(searchAnimLayout['root'])

    -- 添加按钮监听器
    self.btnPvp:addClickEventListener(handler(self, self.pvpSearch))
    self.btnCancel:addClickEventListener(handler(self, self.pvpCancel))

    self:addLayout(self.layout)
end

--------------------------------
-- pvp查找对手，报名
-- @function [parent=#TetrisPvpView] pvpSearch
function TetrisPvpView:pvpSearch()
    if cmgr:isConnected() then
        -- 报名
        self:signPvp()
    else
        Tips.showSceneTips("未连接服务器", 2)
        return
    end

    self.btnPvp:setVisible(false)
    self.btnCancel:setVisible(true)
    self.searchPanel:setVisible(true)

    -- 播放隐藏动画
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

    -- 禁止滚动
    self.scene.scrollEnable = false
end

--------------------------------
-- pvp取消报名
-- @function [parent=#TetrisPvpView] pvpSearch
function TetrisPvpView:pvpCancel()
    cmgr:send(actions.cancelFight, function() 
        self.btnCancel:setVisible(false)
        self.btnPvp:setVisible(true)
        self.searchPanel:setVisible(false)

        self.topPanel:setVisible(true)
        self.topPanel:runAction(cc.MoveTo:create(0.2, cc.p(318.64, 1094) ))
        self.bottomPanel:setVisible(true)
        self.bottomPanel:runAction(cc.MoveTo:create(0.2, cc.p(320.00, 50) ))

        -- 允许滚动
        self.scene.scrollEnable = true
    end)
end

--------------------------------
-- pvp报名
-- @function [parent=#TetrisPvpView] signPvp
function TetrisPvpView:signPvp()
    cmgr:send(actions.quitFight)
    cmgr:send(actions.joinFight)

    self.pvpPushHandler = handler(self, self.handlePvpPush)
    cmgr:addPushCallback(actions.PUSH_FIGHT, self.pvpPushHandler)
end

--------------------------------
-- 处理pvp推送
-- @function [parent=#TetrisPvpView] handlePvpPush
function TetrisPvpView:handlePvpPush(response)
    if tolua.isnull(self) then
        return
    end

    local udpConv = nil
    if response.data.schedule ~= nil then
        local scheduleData = response.data.schedule
        if scheduleData.def == nil then
            scheduleData.def = {playerId=0, playerName="机器人小C", score=0, isAI=true, isHost=false}
            scheduleData.att.isHost = true
        elseif scheduleData.att.playerId == mmgr.player.playerId then
            scheduleData.att.isHost = true
            scheduleData.def.isHost = false
        else
            scheduleData.def.isHost = true
            scheduleData.att.isHost = false
        end

        self.scene:pushPanel("Tetris.view.TetrisMulti", { scheduleData })

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

--------------------------------
-- 重置pvp界面
-- @function [parent=#TetrisPvpView] resetPvpView
function TetrisPvpView:resetPvpView()
    self.btnCancel:setVisible(false)
    self.btnPvp:setVisible(true)
    self.searchPanel:setVisible(false)

    self.topPanel:setVisible(true)
    self.topPanel:setPosition(cc.p(318.64, 1094))
    self.bottomPanel:setVisible(true)
    self.bottomPanel:setPosition(cc.p(320.00, 50))
end

return TetrisPvpView

