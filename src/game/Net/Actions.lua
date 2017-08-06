--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2016/12/28
-- Time: 13:54
-- To change this template use File | Settings | File Templates.
-- 网络定义模块
local Action = class("Action")

--------------------------------
-- 构造函数
-- @function [parent=#Action] ctor
function Action:ctor(command, args)
    self.command = command
    self.args = args
end

-- 暴露actions
cc.exports.actions = {}

-- 登录用户
actions.login = Action.new("user@login", "deviceInfo=%s&deviceType=%s&yx=%s&yxSource=%s&uuid=%s")

-- 创建用户
actions.createPlayer = Action.new("player@createPlayer", "")

-- 获取用户信息
actions.getPlayerInfo = Action.new("player@getPlayerInfo", "")

-- 单人副本
actions.getPowerData = Action.new("player@getPowerData", "")
actions.syncPowerData = Action.new("player@syncPowerData", "data=%s")
actions.syncLife = Action.new("player@syncLife", "lifes=%s&timestamp=%s")
actions.queryBuyLifeCost = Action.new("player@queryBuyLifeCost", "")
actions.buyLife = Action.new("player@buyLife", "lifes=%s&timestamp=%s")
actions.buyItem = Action.new("player@buyItem", "cost=%s&buyTimes=%s")
actions.getPayInfo = Action.new("pay@getInfo", "")
actions.createOrder = Action.new("pay@createOrder", "itemId=%s")
actions.getRankInfo = Action.new("pvp@getRankInfo", "page=%s")

-- 多人对战相关
actions.joinFight = Action.new("fight@join", "")
actions.cancelFight = Action.new("fight@cancel", "")
actions.quitFight = Action.new("fight@quit", "")
actions.readyFight = Action.new("fight@ready", "")
actions.doUpdate = Action.new("fight@doUpdate", "protoId=%s&frameNum=%s&serverFrameNum=%s&seq=%s&args=%s")
actions.writeLog = Action.new("log", "msg=%s")
actions.ping = Action.new("fight@ping", "seq=%s")

actions.PUSH_FIGHT = "push@fight"
actions.PUSH_UPDATE = "push@update"


-- 战斗protos
cc.exports.protos = {}

protos.FIGHT_START = 1
protos.KEY_PRESS = 100
protos.REMOVE_LINES = 101
protos.DEAD = 102
protos.UPDATE_SERVERFRAME = -100

actions.seq_map = {}

-- 记录延迟
function actions.recordDelay(seq, tag, time)
    if not seq then
        return
    end

    if not actions.seq_map[seq] or tag == 'send' then
        actions.seq_map[seq] = time
        -- log:info("[%s]seq:%s, time:%s", tag, seq, time)
    else
        local _time = actions.seq_map[seq]
        -- log:info("[%s]seq:%s, delay:%s", tag, seq, time - _time)
    end
end





