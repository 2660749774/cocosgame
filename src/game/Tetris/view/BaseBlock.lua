--
-- User: wangys
-- BaseBlock 俄罗斯方块 - 基础方块
local BaseBlock = class("BaseBlock", cc.Node)


--------------------------------
-- 构造函数
-- @function [parent=#BaseBlock] ctor
function BaseBlock:ctor(blockType, angle, min, max, pic)
    self.blockWidth = 27
    self.fixPixel = 3
    self.blockType = blockType
    self.blockArray = {}
    self.blocks = {}
    self.curIndex = 1
    self.offsetLeft = 0
    self.offsetRight = 0
    self.min = min
    self.max = max
    self.pic = pic
end

--------------------------------
-- 修正位置
-- @function [parent=#BaseBlock] fixPosition
function BaseBlock:fixPosition() 
    local x, y = self:getPosition()
    local max = self.max + self.offsetRight
    local min = self.min - self.offsetLeft

    -- log:info("fixPosition x:%s, y:%s, offsetRight:%s, max:%s", x, y, self.offsetRight, max)
    if x > max then
        self:setPosition(max, y)
    elseif x < min then
        self:setPosition(min, y)
    end
end


--------------------------------
-- 设置透明度
-- @function [parent=#BaseBlock] setOpacity
function BaseBlock:setOpacity(opacity) 
    for _, block in pairs(self.blocks) do
        block:setOpacity(opacity)
    end
end

--------------------------------
-- 修正位置
-- @function [parent=#BaseBlock] fixPosition
function BaseBlock:doRotation(grids)
    local srcIndex = self.curIndex
    self.curIndex = self.curIndex + 1
    if self.curIndex > 4 then
        self.curIndex = 1
    end
    self:refreshDisplay()
    self:fixPosition()
    if self:checkCollision(grids) then
        self.curIndex = srcIndex
        self:refreshDisplay()
        self:fixPosition()
    end
end

--------------------------------
-- 处理左移动
-- @function [parent=#BaseBlock] handleLeft
function BaseBlock:handleLeft(grids)
    local x, y = self:getPosition()
    local sx, sy = x, y
    -- log:info("handleLeft x:%s, y:%s, offsetX:%s, min:%s", x, y, self.offsetLeft, self.min)

    x = x - self.blockWidth
    local min = (self.min - self.offsetLeft)
    if x < min then
        x = min
    end
    self:setPosition(cc.p(x, y))
    if self:checkCollision(grids) then
        -- 不可以移动了
        self:setPosition(cc.p(sx, sy))
    end
end

--------------------------------
-- 处理右移动
-- @function [parent=#BaseBlock] handleRight
function BaseBlock:handleRight(grids)
    local x, y = self:getPosition()
    local sx, sy = x, y
    
    x = x + self.blockWidth
    local max = self.max + self.offsetRight
    if x > max  then
        x = max
    end
    
    -- log:info("handleRight x:%s, y:%s, offsetRight:%s, max:%s", x, y, self.offsetRight, max)
    self:setPosition(cc.p(x, y))
    if self:checkCollision(grids) then
        -- 不可以移动了
        self:setPosition(cc.p(sx, sy))
    end
end

--------------------------------
-- 获取格子的偏移量
-- @function [parent=#BaseBlock] getGridArray
function BaseBlock:getOffSet()
    local minx, miny = self:_getGridArrayOffSet(self:getGridArray())

    return minx * self.blockWidth, miny * self.blockWidth
end

--------------------------------
-- 处理向下
-- @function [parent=#BaseBlock] checkCollision
function BaseBlock:checkCollision(grids)
    -- 计算需要占用的格子
    local array = self:getGridArray()
    local minx, miny = self:_getGridArrayOffSet(array)

    -- 计算自己所在的逻辑坐标
    x, y = self:getPosition()
    local gridX = math.floor(x / self.blockWidth + 1)
    local gridY = math.floor(y / self.blockWidth + 1)

    -- 计算自己所在位置是否合法
    for _, value in pairs(array) do
        -- log:info("checkCollision grid y:%s, x:%s", gridY + value[2], gridX + value[1])
        if grids[gridY + value[2]] == nil or grids[gridY + value[2]][gridX + value[1]] ~= 0 then
            return true
        end
    end

    return false
end

--------------------------------
-- 检查位置是否有效
-- @function [parent=#BaseBlock] checkAvailable
function BaseBlock:checkAvailable(x, y, grids, blockArray, idx)
    -- 起始格子位置
    local gridX = math.floor(x / self.blockWidth + 1)
    local gridY = math.floor(y / self.blockWidth + 1)
    local rowsnum = #grids
    local colsnum = #grids[1]

    -- 计算是否有效
    -- log:info("checkAvailable gridY:%s, gridX:%s, rowsnum:%s", gridY, gridX, rowsnum)
    for i=1, #blockArray do
        for j=1, #blockArray[i] do
            if blockArray[i][j] == 1 then
                local _x, _y = (j - 1), (4 - i)
                -- log:info("checkAvailable grid y:%s, x:%s", gridY + _y, gridX + _x)
                if gridX + _x < 1 or gridX + _x > colsnum then
                    return false
                end
                if (gridY + _y <= rowsnum) and (grids[gridY + _y] == nil or grids[gridY + _y][gridX + _x] ~= 0) then
                    return false
                end
            end
        end
    end
    return true
end

--------------------------------
-- 检查是否可以继续向下
-- @function [parent=#BaseBlock] checkDown
function BaseBlock:checkDown(grids)
    -- 计算需要占用的格子
    local array = self:getGridArray()
    local minx, miny = self:_getGridArrayOffSet(array)

    -- 计算自己所在坐标
    x, y = self:getPosition()
    local gridX = math.floor(x / self.blockWidth + 1)
    local gridY = math.floor(y / self.blockWidth)

    -- 到底部了
    if gridY + miny < 1 then
        return true
    end

    -- 检查自己所处位置是否合法
    for _, value in pairs(array) do
        -- log:info("checkDown grid y:%s, x:%s", gridY + value[2], gridX + value[1])
        if grids[gridY + value[2]] ~= nil and grids[gridY + value[2]][gridX + value[1]] ~= 0 then
            return true
        end
    end

    return false
end

--------------------------------
-- 处理向下
-- @function [parent=#BaseBlock] handleDown
function BaseBlock:handleDown(grids, simulate)
    -- 计算需要占用的格子
    local array = self:getGridArray()
    local minx, miny = self:_getGridArrayOffSet(array)

    -- 计算当前方块所在的逻辑x, y
    x, y = self:getPosition()
    local gridX = math.floor(x / self.blockWidth + 1)
    local gridY = math.floor(y / self.blockWidth + 1)
    local fit  = false -- 是否找到合适位置
    local fitY = nil -- 合适位置的y值
    for i = 1 - miny, gridY do
        fit = true
        for _, value in pairs(array) do
            -- log:info("check grid y:%s, x:%s", i + value[2], gridX + value[1])
            if grids[i + value[2]] ~= nil and grids[i + value[2]][gridX + value[1]] ~= 0 then
                fit = false
                fitY = nil
                break
            end
        end
        if fit then
            if fitY == nil or fitY > i then
                fitY = i
            end
        end
    end

    -- 处理降落
    -- log:info("find fitY:%s", fitY)
    if fit then
        if not simulate then
            for _, value in pairs(array) do
                if grids[fitY + value[2]] == nil then
                    return false
                end
                -- log:info("fill grid y:%s, x:%s", fitY + value[2], gridX + value[1])
                grids[fitY + value[2]][gridX + value[1]] = value[3]
            end
            self:setPosition(cc.p(x, (fitY - 1) * self.blockWidth + self.fixPixel))
        end
        return true
    end
    
    return false
end

--------------------------------
-- 获取格子的逻辑坐标
-- @function [parent=#BaseBlock] getGridArray
function BaseBlock:getGridArray()
    local array = {}
    for _, block in pairs(self.blocks) do
        local x, y = block:getPosition()
        table.insert(array, {x / self.blockWidth, y / self.blockWidth, block})
    end
    return array
end

--------------------------------
-- 获取格子的负极值
-- @function [parent=#BaseBlock] _getGridArrayOffSet
function BaseBlock:_getGridArrayOffSet(array)
    local minx = -1
    local miny = -1
    for _, value in pairs(array) do
        if minx == -1 or value[1] < minx then
            minx = value[1]
        end
        if miny == -1 or value[2] < miny then
            miny = value[2]
        end
    end

    return minx, miny
end


--------------------------------
-- 刷新显示
-- @function [parent=#BaseBlock] refreshDisplay
function BaseBlock:refreshDisplay()
    local array = self.blockArray[self.curIndex]
    local minx, maxx = 4, 0
    if #self.blocks == 0 then
        local bg = cc.Sprite:create() --cc.LayerColor:create(ccc4(0xFF, 0x00, 0x00, 0x80), self.blockWidth * 4, self.blockWidth * 4)
        bg:setContentSize(cc.size(self.blockWidth * 4,self.blockWidth * 4))
        bg:setAnchorPoint(0, 0)
        for i=1, #array do
            for j=1, #array[i] do
                if array[i][j] == 1 then
                    local sprite = cc.Sprite:createWithSpriteFrameName(self.pic)
                    sprite:setAnchorPoint(0, 0)
                    local x, y = (j - 1), (4 - i)
                    sprite:setPosition(x * self.blockWidth, y * self.blockWidth)
                    bg:addChild(sprite)
                    table.insert(self.blocks, sprite)
                    
                    if minx > x then
                        minx = x
                    end
                    if maxx < x then
                        maxx = x
                    end
                end
            end
        end
        self:addChild(bg)
    else
        local index = 1
        for i=1, #array do
            for j=1, #array[i] do
                if array[i][j] == 1 then
                    local x, y = (j - 1), (4 - i)
                    self.blocks[index]:setPosition(x * self.blockWidth, y * self.blockWidth)
                    index = index + 1

                    if minx > x then
                        minx = x
                    end
                    if maxx < x then
                        maxx = x
                    end
                end
            end
        end
    end
    self.offsetLeft = minx * self.blockWidth
    self.offsetRight = (3 - maxx) * self.blockWidth
end



return BaseBlock