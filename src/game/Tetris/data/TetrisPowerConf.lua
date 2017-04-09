--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisPowerConf 方块迷阵

local TetrisPowerConf = class("TetrisPowerConf")
local TetrisMeteorConf = import(".TetrisMeteorConf")
local TetrisMeteor2Conf = import(".TetrisMeteor2Conf")
local TetrisMazeConf = import(".TetrisMazeConf")
local TetrisClearStoneConf = import(".TetrisClearStoneConf")
local TetrisTimeModeConf = import(".TetrisTimeModeConf")

TetrisPowerConf.configMap = {}
TetrisPowerConf.powerInfoMap = {}

-- 关卡模式1 -- 清理陨石
TetrisPowerConf.TYPE_CLEAR_STONE = 1
-- 关卡模式2 -- 极速挑战
TetrisPowerConf.TYPE_TIMEMODE = 2
-- 关卡模式3 -- 星际迷阵
TetrisPowerConf.TYPE_METEOR = 3
-- 关卡模式4 -- 方块迷阵
TetrisPowerConf.TYPE_MAZE = 4
-- 关卡模式5 -- 星际迷阵2
TetrisPowerConf.TYPE_METEOR2 = 5

--------------------------------
-- 构造函数
-- @function [parent=#TetrisPowerConf] ctor
function TetrisPowerConf:ctor(powerId, armyId, confId, armyType)
    self.powerId = powerId
    self.armyId = armyId
    self.confId = confId
    self.armyType = armyType
    if self.armyType == TetrisPowerConf.TYPE_CLEAR_STONE then
        self.pic = "square3"
        self.module = "TetrisClearStone"
    elseif self.armyType == TetrisPowerConf.TYPE_TIMEMODE then
        self.pic = "square2"
        self.module = "TetrisTimeMode"
    elseif self.armyType == TetrisPowerConf.TYPE_METEOR2 then
        self.pic = "square4"
        self.module = "TetrisMeteor2"
    elseif self.armyType == TetrisPowerConf.TYPE_MAZE then
        self.pic = "square1"
        self.module = "TetrisMaze"
    else
        return
    end

    if TetrisPowerConf.configMap[powerId] == nil then
        TetrisPowerConf.configMap[powerId] = {}
    end
    TetrisPowerConf.configMap[powerId][armyId] = self
end

-- 第一章节第1关
TetrisPowerConf.new(1, 1, 1, TetrisPowerConf.TYPE_CLEAR_STONE)
-- 第一章节第2关
TetrisPowerConf.new(1, 2, 2, TetrisPowerConf.TYPE_CLEAR_STONE)
-- 第一章节第3关
TetrisPowerConf.new(1, 3, 1, TetrisPowerConf.TYPE_TIMEMODE)
-- 第一章节第4关
TetrisPowerConf.new(1, 4, 2, TetrisPowerConf.TYPE_TIMEMODE)
-- 第一章节第5关
TetrisPowerConf.new(1, 5, 1, TetrisPowerConf.TYPE_MAZE)
-- 第一章节第6关
TetrisPowerConf.new(1, 6, 2, TetrisPowerConf.TYPE_MAZE)
-- 第一章节第7关
TetrisPowerConf.new(1, 7, 3, TetrisPowerConf.TYPE_CLEAR_STONE)
-- 第一章节第8关
TetrisPowerConf.new(1, 8, 4, TetrisPowerConf.TYPE_CLEAR_STONE)
-- 第一章节第9关
TetrisPowerConf.new(1, 9, 3, TetrisPowerConf.TYPE_TIMEMODE)
-- 第一章节第10关
TetrisPowerConf.new(1, 10, 4, TetrisPowerConf.TYPE_TIMEMODE)
-- 第一章节第11关
TetrisPowerConf.new(1, 11, 3, TetrisPowerConf.TYPE_MAZE)
-- 第一章节第12关
TetrisPowerConf.new(1, 12, 4, TetrisPowerConf.TYPE_MAZE)
-- 第一章节第13关
TetrisPowerConf.new(1, 13, 5, TetrisPowerConf.TYPE_CLEAR_STONE)
-- 第一章节第14关
TetrisPowerConf.new(1, 14, 5, TetrisPowerConf.TYPE_TIMEMODE)
-- 第一章节第15关
TetrisPowerConf.new(1, 15, 5, TetrisPowerConf.TYPE_MAZE)
-- 第一章节第16关
TetrisPowerConf.new(1, 15, 1, TetrisPowerConf.TYPE_METEOR2)

TetrisPowerConf.MAX_POWER_ID = 2
TetrisPowerConf.powerInfoMap[1] = 59
TetrisPowerConf.powerInfoMap[2] = 66

--------------------------------
-- 获取配置
-- @function [parent=#TetrisPowerConf] loadConfig
function TetrisPowerConf.loadConfig(powerId, armyId)
    local conf = nil
    if TetrisPowerConf.configMap[powerId] ~= nil then
        conf =  TetrisPowerConf.configMap[powerId][armyId]
    end

    if nil == conf then
        return TetrisPowerConf.new(powerId, armyId, 2)
    end
    return conf
end

--------------------------------
-- 获取副本最大章节数
-- @function [parent=#TetrisPowerConf] getPowerMaxArmyId
function TetrisPowerConf.getPowerMaxArmyId(powerId)
    return TetrisPowerConf.powerInfoMap[powerId]
end

--------------------------------
-- 获取配置
-- @function [parent=#TetrisPowerConf] loadDetailConfig
function TetrisPowerConf.loadDetailConfig(powerId, armyId)
    local conf = TetrisPowerConf.loadConfig(powerId, armyId)
    if conf.armyType == TetrisPowerConf.TYPE_CLEAR_STONE then
        return TetrisClearStoneConf.loadConfig(conf.confId)
    elseif conf.armyType == TetrisPowerConf.TYPE_TIMEMODE then
        return TetrisTimeModeConf.loadConfig(conf.confId)
    elseif conf.armyType == TetrisPowerConf.TYPE_METEOR2 then
        return TetrisMeteor2Conf.loadConfig(conf.confId)
    elseif conf.armyType == TetrisPowerConf.TYPE_MAZE then
        return TetrisMazeConf.loadConfig(conf.confId)
    end

    return nil
end


return TetrisPowerConf