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
local TetrisPowerConf = import("..data.TetrisPowerConf")
local Tetris = import (".Tetris")
local RandomUtil = require "core.util.RandomUtil"

--------------------------------
-- 创建方法
-- @function [parent=#TetrisClearStonePanel] onCreate
function TetrisClearStonePanel:onCreate(powerId, armyId)
    TetrisSinglePanel.onCreate(self, "layout.TetrisClearStone")
     -- 对齐
    app:alignLeft(self.leftBg)
    app:alignRight(self.rightBg)

    self.powerId = powerId
    self.armyId = armyId
    self.lbLeftBlockNum = self.layout['lb_left_line']
    self.totalBlockNum = 0
    self.blockNum = 0

    self.lbResult = self.layout['lb_result']
    self.totalFangkuaiNum = 0 -- 总方块数量
    self.removeFangkuaiNum = 0 -- 已消除方块数量

    self:loadConfig(TetrisPowerConf.TYPE_CLEAR_STONE, powerId, armyId)
    self:updateBlockNum()

    -- 设置关卡数
    if powerId == 1 then
        self.lbArmyNum:setString(armyId)
    else
        self.lbArmyNum:setString(59 + armyId)
    end
end

--------------------------------
-- 游戏开始
-- @function [parent=#TetrisClearStonePanel] gameStart
function TetrisClearStonePanel:gameStart(data)
    log:info("gameStart")
    -- Tips.showSceneTips("游戏开始！！！")

    -- 重置游戏
    self:reset()

    -- 初始化随机数
    RandomUtil:setRandomseed(data.randomseed)

    -- -- 随机下一块方块
    -- local nextBlock = self.tetris:createNextBlock()

    -- -- 处理居中
    -- local offsetx, offsety = nextBlock:getOffSet()
    -- nextBlock:setPosition(cc.p(0, -offsety))
    -- self.nextBg:addChild(nextBlock)

    -- 游戏开始
    self.tetris.isAI = false
    self.tetris:gameStart(self.conf)
end

--------------------------------
-- 载入配置
-- @function [parent=#TetrisClearStonePanel] loadConfig
function TetrisClearStonePanel:loadConfig(type, powerId, armyId)
    self.conf = TetrisPowerConf.loadDetailConfig(powerId, armyId)
    self.totalBlockNum = self.conf.maxBlockNum
    self.starArray = self.conf.starArray

    -- 统计方块数量
    local blockArray = self.conf.blockArray
    for i = 1, #blockArray do
        for j = 1, #blockArray[i] do
            if blockArray[i][j] == 4 then
                self.totalFangkuaiNum = self.totalFangkuaiNum + 1
            end
        end
    end
end

--------------------------------
-- 更新显示
-- @function [parent=#TetrisClearStonePanel] refreshView
function TetrisClearStonePanel:refreshView()
    local blockNum = self.totalBlockNum - self.blockNum
    if blockNum <= 0 and self.removeFangkuaiNum ~= self.totalFangkuaiNum then
        self.tetris:pauseGame()
        self:getScene():pushPanel("Tetris.view.TetrisTipsBuyTime", {15, self:calcBuyCost(), self.buyTimes, 2, function() 
            self.blockNum = self.blockNum - 15
            self.buyTimes =  self.buyTimes + 1
            self.lbLeftBlockNum:setString("15")
            self.tetris:resumeGame()
        end, function() 
            self.tetris:resumeGame()
            self.tetris:gameOver()
            blockNum = 0
        end})
    end
    self.lbLeftBlockNum:setString(blockNum)
    self.lbResult:setString(self.removeFangkuaiNum .. "/" .. self.totalFangkuaiNum)
end

--------------------------------
-- 游戏结束
-- @function [parent=#TetrisClearStonePanel] notifyGameOver
function TetrisClearStonePanel:notifyGameOver()
    if self.pass then
        return
    end
    self:getScene():pushPanel("Tetris.view.TetrisPowerFail", {self.powerId, self.armyId, self.removeFangkuaiNum, self.totalFangkuaiNum, self})
end

--------------------------------
-- 更新方块数
-- @function [parent=#TetrisClearStonePanel] updateBlockNum
function TetrisClearStonePanel:updateBlockNum()
    self.blockNum = self.blockNum + 1
    self:refreshView()
end

--------------------------------
-- 更新分数
-- @function [parent=#TetrisClearStonePanel] updateShuidiNum
function TetrisClearStonePanel:updateShuidiNum(grids)
    -- 判断是否胜利
    local totalFangkuaiNum = 0
    for i = 1, #grids do
        for j = 1, #grids[i] do
            if grids[i][j] ~= nil and grids[i][j] ~= 0 then
                local block = grids[i][j]
                if block.blockType == 4 or block.blockType == 6 then
                    totalFangkuaiNum = totalFangkuaiNum + 1
                end
            end
        end
    end

    self.removeFangkuaiNum = self.totalFangkuaiNum - totalFangkuaiNum
    self:refreshView()
    if (totalFangkuaiNum > 0) then
        return
    end

    self.pass = true
    self.tetris:gameOver()
    self:getScene():pushPanel("Tetris.view.TetrisPowerSucc", {self.powerId, self.armyId, 3, self.removeFangkuaiNum})
end

--------------------------------
-- 重置
-- @function [parent=#TetrisClearStonePanel] reset
function TetrisClearStonePanel:reset()
    TetrisSinglePanel.reset(self)

    self.blockNum = 0
    self:refreshView()
end


return TetrisClearStonePanel

