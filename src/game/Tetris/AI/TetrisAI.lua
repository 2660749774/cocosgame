--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2016/1/7
-- Time: 14:20
-- To change this template use File | Settings | File Templates.
-- TetrisAI 俄罗斯方块AI
local TetrisAI = class("TetrisAI")

--------------------------------
-- 构造函数
-- @function [parent=#TetrisAI] ctor
function TetrisAI:ctor()
    -- 采用的策略
    -- 1 紧密防守   1行也消除
    -- 2 平衡行     2行起消除，消除1行不加分不扣分
    -- 3 激进型     3行起消除，消除2行不加分不扣分，消除1行扣1分，消除4行得高分
    self.plot = 1
    -- 取多少个最优结果
    self.calculateCount = 4
     

end

--------------------------------
-- 生成可能的移动路径
-- @function [parent=#TetrisAI] generate
function TetrisAI:generate(tetrisCore)
    local keymapFunc = function(x, y, idx) 
        return "" .. x .. ":" .. y .. ":" .. idx
    end

    local moveMapFunc = function(step) 
        return {x=step.x, y=step.y, idx=step.idx}
    end

    local results = {}

    local grids = tetrisCore.grids
    local block = tetrisCore.block

    local boards = grids
    local rownum = #grids[1]
    local colnum = #grids
    local blockArrs = block.shapes

    local occupy = {}

    local actionQueues = {}
    local x, y = block.x, block.y
    table.insert(actionQueues, {x=x, y=y, idx=block.idx, prev=0})
    occupy[keymapFunc(x, y, block.idx)] = true

    local head = 1
    while ( head <= #actionQueues )  do
        local step = actionQueues[head]

        -- 1). 向左移动一步
        local tx = step.x - 1
        local ty = step.y
        local tidx = step.idx
        if ( tetrisCore:checkAvailable(tx, ty, blockArrs[tidx]) ) then
            local key = keymapFunc(tx, ty, tidx)
            if ( occupy[key] == nil ) then
                table.insert(actionQueues, {x=tx, y=ty, idx=tidx, prev=head})
                occupy[key] = true
            end
        end

        -- 2). 向右移动一步
        tx = step.x + 1
        ty = step.y
        tidx = step.idx
        if ( tetrisCore:checkAvailable(tx, ty, blockArrs[tidx]) ) then
            local key = keymapFunc(tx, ty, tidx)
            if ( occupy[key] == nil ) then
                table.insert(actionQueues, {x=tx, y=ty, idx=tidx, prev=head})
                occupy[key] = true
            end
        end

        -- 3). 旋转一步
        tx = step.x
        ty = step.y
        tidx = (step.idx + 1)
        if tidx > 4 then
            tidx = 1
        end
        if ( tetrisCore:checkAvailable(tx, ty, blockArrs[tidx]) ) then
            local key = keymapFunc(tx, ty, tidx)
            if ( occupy[key] == nil ) then
                table.insert(actionQueues, {x=tx, y=ty, idx=tidx, prev=head})
                occupy[key] = true
            end
        end

        -- 4). 向下移动一步
        tx = step.x
        ty = step.y - 1
        tidx = step.idx
        if ( tetrisCore:checkAvailable(tx, ty, blockArrs[tidx]) ) then
            local key = keymapFunc(tx, ty, tidx)
            if ( occupy[key] == nil ) then
                table.insert(actionQueues, {x=tx, y=ty, idx=tidx, prev=head})
                occupy[key] = true
            end
        else
            -- *) 若不能向下了, 则为方块的一个终结节点.
            local tmpMoves = {}
            table.insert(tmpMoves, moveMapFunc(step))
            local tprev = step.prev
            while ( tprev ~= 0 ) do
                table.insert(tmpMoves, moveMapFunc(actionQueues[tprev]))
                tprev = actionQueues[tprev].prev
            end
            -- tmpMoves.reverse()
            -- log:info("show last")
            -- log:showTable(step)
            tmpMoves = self:reverseTable(tmpMoves)
            table.insert(results, {last=step, moves=tmpMoves})
        end
        head = head + 1
    end
    return results
end

function TetrisAI:makeBestDecision(tetrisCore)
    local bestMove = nil
    local bestScore = -1000000
    local grids = tetrisCore.grids
    local block = tetrisCore.block

    -- 1) 生成所有可行的落点, 以及对应的路径线路
    local allMoves = self:generate(tetrisCore)

    -- 2) 遍历每个可行的落点, 选取最优的局面落点
    for _, result in pairs(allMoves) do
        local step = result.last
        local copyGrids = self:applyData(grids, block, step)
        local score = self:evaluate(copyGrids, block, step)
        -- log:info("step x:%s, y:%s, idx:%s, score:%s", step.x, step.y, step.idx, score)
        -- self:print(copyGrids)
        if bestMove == nil or score > bestScore then
            bestScore = score
            bestMove = result.moves
        end
    end

    -- 3) 返回最优可行落点, 及其路径线路
    return {score=bestScore, action_moves=bestMove}
end

function TetrisAI:evaluate(grids, block, step)
    local v1 = self:landingHeight(grids)
    local v2 = self:rowsEliminated(grids)
    local v3 = self:emptyHoles(grids)
    local v4 = self:blackHoles(grids)

    -- log:showTable(grids)
    -- log:info("height:%s", v1)
    -- log:info("removeLines:%s", v2)
    -- log:info("emptyHoles:%s", v3)
    
    return v1 * -80 + v2 * 1000 + v3 * -30 + v4 * -100
end

function TetrisAI:applyData(grids, block, step)
    local copyGrids = {}
     for i = 1, #grids do
        copyGrids[i] = {}
        for j = 1, #grids[i] do
            local value = grids[i][j]
            if value == 0 then
                copyGrids[i][j] = 0
            else
                copyGrids[i][j] = 1
            end
        end
    end

    local tx = step.x
    local ty = step.y
    local blockArray = block.shapes[step.idx]

    -- 填充位子
    for i=1, 4 do
        for j=1, 4 do
            if blockArray[i][j] ~= 0 then
                local bx, by = j, (4 - i) + 1
                -- log:info("bx:%s, by:%s, tx:%s, ty:%s", bx, by, tx, ty)
                if copyGrids[ty + by][tx + bx] == 0 then
                    copyGrids[ty + by][tx + bx] = 1
                end
            end
        end
    end

    return copyGrids
end

-- ===================================
-- @brief landing height
function TetrisAI:landingHeight(grids) 
    -- 起始格子位置
    local maxHeight = 0
    for i=1, #grids do
        for j=1, #grids[i] do
            if grids[i][j] == 1 then
                if i > maxHeight then
                    maxHeight = i
                end
            end
        end
    end
    return maxHeight
end

-- @brief 消行个数
function TetrisAI:rowsEliminated(grids) 
    -- 消除行判断
    local num = 0
    for i = 1, #grids do
        local canRemove = true
        for j = 1, #grids[i] do
            if grids[i][j] == 0 then
                canRemove = false
                break
            end
        end
        if canRemove then
            num = num + 1
        end
    end

    return num
end


-- @brief 空洞个数
function TetrisAI:blackHoles(grids) 
    -- 空洞判断
    local blackHoles = 0
    for i = 1, #grids do
        local hasBlock = false
        for j = 1, #grids[i] do
            if grids[i][j] == 0 then
                if grids[i+1] == nil or grids[i+1][j] == 1 then
                    blackHoles = blackHoles + 1
                elseif (grids[i][j-1] == nil or grids[i][j-1] == 1) and (grids[i][j+1] == nil or grids[i][j+1] == 1) then
                    blackHoles = blackHoles + 0.5
                end
            end
        end
    end

    return blackHoles
end


-- @brief 空洞个数
function TetrisAI:emptyHoles(grids) 
    -- 空洞判断
    local emptyHoles = 0
    for i = 1, #grids do
        local hasBlock = false
        local index = 1
        for j=index, #grids[i] do
            if grids[i][j] == 1 then
                hasBlock = true
            end
            index = j
        end
        for j=index, #grids[i] do
            if grids[i][j] == 0 then
                emptyHoles = emptyHoles + 1
            end
        end
    end

    return emptyHoles
end

--------------------------------
-- 反转数组
-- @function [parent=#TetrisAI] reverseTable
function TetrisAI:reverseTable(array)
    local tmp = {}
    for i=#array, 1, -1 do 
        table.insert(tmp, array[i])
    end
    return tmp
end

--------------------------------
-- 打印tetris
-- @function [parent=#TetrisAI] print
function TetrisAI:print(grids)
    local col = #grids[1]
    local row = #grids
    local fmt = ""
    local t = {}
    for i = 1, col do
        if i == 1 then
            fmt = fmt .. "%s"
        else
            fmt = fmt .. " %s"
        end
    end
    for i = 1, row do
        for j = 1, #grids[i] do
            if t[i] == nil then
                t[i] = {}
            end
            if grids[i][j] ~= 0 then
                t[i][j] = '1'
            else
                t[i][j] = '0'
            end
        end
    end
    for i = row, 1, -1 do
        log:info(fmt, unpack(t[i]))
    end
    log:info("-------------------------------------------")
end

return TetrisAI