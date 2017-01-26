--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisClearStonePanel 俄罗斯方块
-- 指定块数内清理障碍
local TetrisSinglePanel = import(".TetrisSinglePanel")
local TetrisClearStonePanel = class("TetrisClearStonePanel", TetrisSinglePanel)
local TetrisClearStoneConf = import("..data.TetrisClearStoneConf")
local Tetris = import (".Tetris")
local RandomUtil = require "core.util.RandomUtil"

--------------------------------
-- 创建方法
-- @function [parent=#TetrisClearStonePanel] onCreate
function TetrisClearStonePanel:onCreate(powerId, armyId)
    TetrisSinglePanel.onCreate(self, "layout.TetrisClearStone")
    self.lbLeftBlockNum = self.layout['lb_left_line']
    self.totalBlockNum = 0
    self.blockNum = 0
    self:loadConfig(TetrisSinglePanel.TYPE_CLEAR_STONE, powerId, armyId)
    self:updateBlockNum()
end

--------------------------------
-- 游戏开始
-- @function [parent=#TetrisClearStonePanel] gameStart
function TetrisClearStonePanel:gameStart(data)
    log:info("gameStart")
    Tips.showSceneTips("游戏开始！！！")

    -- 重置游戏
    self.btnPlay:setVisible(false)
    self:reset()

    -- 初始化随机数
    RandomUtil:setRandomseed(data.randomseed)

    -- 随机下一块方块
    local nextBlock = self.tetris:createNextBlock()

    -- 处理居中
    local offsetx, offsety = nextBlock:getOffSet()
    nextBlock:setPosition(cc.p(0, -offsety))
    self.nextBg:addChild(nextBlock)

    -- 游戏开始
    self.tetris.isAI = false
    self.tetris:gameStart(self.conf)
end

--------------------------------
-- 载入配置
-- @function [parent=#TetrisClearStonePanel] loadConfig
function TetrisClearStonePanel:loadConfig(type, powerId, armyId)
    self.conf = TetrisClearStoneConf.loadConfig(powerId, armyId)
    self.totalBlockNum = self.conf.maxBlockNum
end

--------------------------------
-- 更新剩余方块数
-- @function [parent=#TetrisClearStonePanel] roundStart
function TetrisClearStonePanel:updateBlockNum()
    local blockNum = self.totalBlockNum - self.blockNum
    if blockNum <= 0 then
        self.tetris:gameOver()
        blockNum = 0
    end
    self.lbLeftBlockNum:setString(blockNum)
end

--------------------------------
-- 更新分数
-- @function [parent=#TetrisClearStonePanel] updateScore
function TetrisClearStonePanel:updateScore(removeLineNums)
    TetrisSinglePanel.updateScore(self, removeLineNums)
    self.blockNum =  self.blockNum + 1
    self:updateBlockNum()

    -- 判断是否胜利
    local grids = self.tetris.grids
    for i = 1, #grids do
        for j = 1, #grids[i] do
            if grids[i][j] ~= nil and grids[i][j] ~= 0 then
                local block = grids[i][j]
                if block.confBlock ~= nil and block.confBlock then
                    return
                end
            end
        end
    end

    -- 胜利了
    Tips.showSceneTips("恭喜您获胜了！！！", 3)
    self.tetris:gameOver()
end

--------------------------------
-- 重置
-- @function [parent=#TetrisClearStonePanel] reset
function TetrisClearStonePanel:reset()
    TetrisSinglePanel.reset(self)

    self.blockNum = 0
    self:updateBlockNum()
end


return TetrisClearStonePanel

