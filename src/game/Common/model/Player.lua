--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2016/6/4
-- Time: 13:09
-- To change this template use File | Settings | File Templates.
-- Player 用户Model
local Player = class("Player")

--------------------------------
-- 构造函数
-- @function [parent=#Player] ctor
function Player:ctor()
    -- 用户Id
    self.userId = ""

    -- 角色Id
    self.playerId = ""

    -- 角色名称
    self.playerName = ""

    -- vip等级
    self.vipLv = 0

    -- 钻石数量
    self.diam = 0
end

--------------------------------
-- 更新数据
-- @function [parent=#Player] ctor
function Player:update(data)
    log:info("更新玩家数据")
    log:showTable(data)
    if data == nil then
        return
    end

    if data.userId then
        self.userId = data.userId
    end

    if data.playerId then
        self.playerId = data.playerId
    end

    if data.vipLv then
        self.vipLv = data.vipLv
    end

    if data.playerName then
        self.playerName = data.playerName
    end

    if data.diam then
        self.diam = data.diam
    end

    -- 更新玩家数据
    utils.gameArchive:updatePlayerData(self)
end

return Player