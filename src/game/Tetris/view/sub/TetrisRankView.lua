--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisRankView  俄罗斯方块
-- 排行榜模块

local TetrisRankView = class("TetrisRankView", BaseView)

--------------------------------
-- 创建方法
-- @function [parent=#TetrisRankView] onCreate
function TetrisRankView:onCreate()
    self.layout = require("layout.TetrisRank").create()

    -- 初始化界面
    self.rankList = self.layout['list_view']
    self.lbMyRank = self.layout['lb_myrank']
    self.btnRecv = self.layout['btn_recv']

    -- 监听滑动事件
    self.rankList:init()
    self.rankList:onScroll(handler(self, self.onScroll))

    self:addLayout(self.layout)
end

--------------------------------
-- 初始化排行榜
-- @function [parent=#TetrisRankView] initRank
function TetrisRankView:initRank()
    -- 清理数据
    self.rankList:removeAllChildren()
    self.rankList:init()

    self.maxPage = 0
    self.currPage = 0
    self.fetchData = true
    self.itemCount = 0

    -- 获取排行榜数据
    cmgr:send(actions.getRankInfo, function(response)
        local data = response.data

        -- 初始化我的视图
        self:initSelfView(data)
        
        -- 赋值数据
        self.maxPage = data.maxPage
        self.currPage = 1
        self.fetchData = true
        self.itemCount = 0

        -- 添加数据
        self:addRankData(data.rankList)
    end, 0)
end

--------------------------------
-- 处理列表滑动
-- @function [parent=#TetrisRankView] onScroll
function TetrisRankView:onScroll(event)
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
end

--------------------------------
-- 初始化我的视图
-- @function [parent=#TetrisRankView] initSelfView
function TetrisRankView:initSelfView(data)
    if data.myRank == -1 then
        self.lbMyRank:setString("未上榜")
    else
        self.lbMyRank:setString(data.myRank)
    end

    if data.rewardState == 0 then
        self.btnRecv:setEnabled(false)
        ShaderUtil.setGray(self.btnRecv)
    else
        self.btnRecv:setEnabled(true)
        ShaderUtil.removeGray(self.btnRecv)
    end
end

--------------------------------
-- 拉取排行榜数据
-- @function [parent=#TetrisRankView] getRankData
function TetrisRankView:getRankData(page)
    -- log:info("fetch data:%s", page)
    cmgr:send(actions.getRankInfo, function(response)
        self:addRankData(response.data.rankList)
    end, page)
end

--------------------------------
-- 将数据插入排行榜
-- @function [parent=#TetrisRankView] addRankData
function TetrisRankView:addRankData(dataList)
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


return TetrisRankView

