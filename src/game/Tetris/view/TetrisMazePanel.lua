--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TetrisMazePanel 俄罗斯方块
-- 方块迷阵
local TetrisSinglePanel = import(".TetrisSinglePanel")
local TetrisMazePanel = class("TetrisMazePanel", TetrisSinglePanel)
local TetrisMazeConf = import("..data.TetrisMazeConf")
local Tetris = import (".Tetris")
local RandomUtil = require "core.util.RandomUtil"

--------------------------------
-- 创建方法
-- @function [parent=#TetrisMazePanel] onCreate
function TetrisMazePanel:onCreate(powerId, armyId)
    TetrisSinglePanel.onCreate(self, "layout.TetrisMaze")
    self.lbLeftBlockNum = self.layout['lb_left_line']
    self.totalBlockNum = 0
    self.blockNum = 0
    self:loadConfig(TetrisSinglePanel.TYPE_MAZE, powerId, armyId)
    self:updateBlockNum()
end

--------------------------------
-- 游戏开始
-- @function [parent=#TetrisMazePanel] gameStart
function TetrisMazePanel:gameStart(data)
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
-- @function [parent=#TetrisMazePanel] loadConfig
function TetrisMazePanel:loadConfig(type, powerId, armyId)
    self.conf = TetrisMazeConf.loadConfig(powerId, armyId)
    self.totalBlockNum = self.conf.maxBlockNum
end

--------------------------------
-- 更新剩余方块数
-- @function [parent=#TetrisMazePanel] roundStart
function TetrisMazePanel:updateBlockNum()
    local blockNum = self.totalBlockNum - self.blockNum
    if blockNum <= 0 then
        self.tetris:gameOver()
        blockNum = 0
    end
    self.lbLeftBlockNum:setString(blockNum)
end

--------------------------------
-- 随机下一块
-- @function [parent=#TetrisMazePanel] nextInt
function TetrisMazePanel:nextInt(range, times)
    log:info("TetrisMazePanel nextInt %s", times)
    return self.conf.nextBlockArray[times]
end

--------------------------------
-- 更新分数
-- @function [parent=#TetrisMazePanel] updateScore
function TetrisMazePanel:updateScore(removeLineNums)
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
-- @function [parent=#TetrisMazePanel] reset
function TetrisMazePanel:reset()
    TetrisSinglePanel.reset(self)

    self.blockNum = 0
    self:updateBlockNum()
end


return TetrisMazePanel

