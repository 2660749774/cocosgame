--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisPowerConf 方块迷阵

local TetrisPowerConf = class("TetrisPowerConf")

TetrisPowerConf.configMap = {}

--------------------------------
-- 构造函数
-- @function [parent=#TetrisPowerConf] ctor
function TetrisPowerConf:ctor(powerId, armyId, armyType)
    self.powerId = powerId
    self.armyId = armyId
    self.armyType = armyType
    if self.armyType == 1 then
        self.pic = "square3"
        self.module = "TetrisClearStone"
    elseif self.armyType == 2 then
        self.pic = "square2"
        self.module = "TetrisTimeMode"
    elseif self.armyType == 3 then
        self.pic = "square4"
        self.module = "TetrisMeteor"
    else
        self.pic = "square1"
        self.module = "TetrisMaze"
    end

    if TetrisPowerConf.configMap[powerId] == nil then
        TetrisPowerConf.configMap[powerId] = {}
    end
    TetrisPowerConf.configMap[powerId][armyId] = self
end

-- 第一章节第1关
TetrisPowerConf.new(1, 1, 1)
-- 第一章节第2关
TetrisPowerConf.new(1, 2, 2)
-- 第一章节第3关
TetrisPowerConf.new(1, 3, 4)

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


return TetrisPowerConf