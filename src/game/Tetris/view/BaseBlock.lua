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
    self.angle = angle - 90
    self.offsetLeft = 0
    self.offsetRight = 0
    self.min = min
    self.max = max
    self.pic = 'tetris/fangkuai.png'
    self.nextOffset = 0
    -- log:info("create BaseBlock max:%s", self.max)
end

--------------------------------
-- 修正位置
-- @function [parent=#BaseBlock] fixPosition
function BaseBlock:fixPosition() 
    local x, y = self:getPosition()
    local max = self.max + self.offsetRight
    local min = self.min + self.offsetLeft

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
    self.sprite1:setOpacity(opacity)
    self.sprite2:setOpacity(opacity)
    self.sprite3:setOpacity(opacity)
    self.sprite4:setOpacity(opacity)
end

--------------------------------
-- 修正位置
-- @function [parent=#BaseBlock] fixPosition
function BaseBlock:doRotation(grids)
    self._angle = self.angle
    self:rotation()

    if self:checkCollision(grids) then
        -- 旋转导致了重叠，旋转回来
        if self._angle == 0 then
            self.angle = 270
        else
            self.angle = self._angle - 90
        end
        self:rotation()
    end
end

--------------------------------
-- 处理左移动
-- @function [parent=#BaseBlock] handleLeft
function BaseBlock:handleLeft(grids)
    local x, y = self:getPosition()
    local sx, sy = x, y
    -- log:info("handleLeft x:%s, y:%s, offsetX:%s, angle:%s", x, y, self.offsetLeft, self.angle)
    x = x - self.blockWidth
    local min = (self.min + self.offsetLeft)
    -- if min > self.min then
    --     min = self.min
    -- end
    
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
    -- if max < self.max then
    --     max = self.max
    -- end

    if x > max  then
        x = max
    end
    
    -- log:info("handleRight x:%s, y:%s, offsetX:%s, max:%s", x, y, self.offsetRight, max)
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
    local offsetX, offsetY = self:_getGridArrayOffSet(self:getGridArray())

    return offsetX * self.blockWidth, offsetY * self.blockWidth
end

--------------------------------
-- 处理向下
-- @function [parent=#BaseBlock] checkCollision
function BaseBlock:checkCollision(grids)
    -- 计算需要占用的格子
    local array = self:getPositiveGridArray()
    local offsetX, offsetY, minx, miny = self:_getGridArrayOffSet(self:getGridArray())

    -- 计算自己所在的逻辑坐标
    x, y = self:getPosition()
    local gridX = math.floor(x / self.blockWidth + 1 + minx)
    local gridY = math.floor(y / self.blockWidth + 1 + miny)

    -- 计算自己所在位置是否合法
    for _, value in pairs(array) do
        -- log:info("checkCollision grid y:%s, x:%s", gridY + value[2], gridX + value[1])
        if grids[gridY + value[2]] ~= nil and grids[gridY + value[2]][gridX + value[1]] ~= 0 then
            return true
        end
    end

    return false
end

--------------------------------
-- 检查是否可以继续向下
-- @function [parent=#BaseBlock] checkDown
function BaseBlock:checkDown(grids)
    -- 计算需要占用的格子
    local array = self:getPositiveGridArray()
    local offsetX, offsetY, minx, miny = self:_getGridArrayOffSet(self:getGridArray())

    -- 计算自己所在坐标
    x, y = self:getPosition()
    local gridX = math.floor(x / self.blockWidth + 1 + minx)
    local gridY = math.floor(y / self.blockWidth + miny)

    -- 到底部了
    if gridY < 1 then
        return true
    end

    -- 检查自己所处位置是否合法
    for _, value in pairs(array) do
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
    local array = self:getPositiveGridArray()
    local offsetX, offsetY, minx, miny = self:_getGridArrayOffSet(self:getGridArray())

    -- 计算当前方块所在的逻辑x, y
    x, y = self:getPosition()
    local gridX = math.floor(x / self.blockWidth + 1 + minx)
    local gridY = math.floor(y / self.blockWidth + miny)
    local fit  = false -- 是否找到合适位置
    local fitY = -1 -- 合适位置的y值
    for i = 1, #grids do
        fit = true
        for _, value in pairs(array) do
            -- log:info("check grid y:%s, x:%s", gridY + value[2], gridX + value[1])
            if grids[i + value[2]] ~= nil and grids[i + value[2]][gridX + value[1]] ~= 0 then
                fit = false
                break
            end
        end
        if fit then
            if fitY == -1 or fitY > i then
                fitY = i
            end
        elseif fitY >= 0 and fitY < gridY then
            fitY = -1
        end
    end

    -- 处理降落
    if fit then
        if not simulate then
            gridY = fitY
            for _, value in pairs(array) do
                if grids[gridY + value[2]] == nil then
                    return false
                end
                -- log:info("fill grid y:%s, x:%s", gridY + value[2], gridX + value[1])
                grids[gridY + value[2]][gridX + value[1]] = value[3]
            end
        end
        self:setPosition(cc.p(x, (gridY + offsetY - 1) * self.blockWidth + self.fixPixel))
        return true
    end

    return false
end

--------------------------------
-- 获取格子的逻辑坐标
-- @function [parent=#BaseBlock] getGridArray
function BaseBlock:getGridArray()
    local array = {}
    local x, y = self.sprite1:getPosition()
    table.insert(array, {x / self.blockWidth, y / self.blockWidth, self.sprite1})

    x, y = self.sprite2:getPosition()
    table.insert(array, {x / self.blockWidth, y / self.blockWidth, self.sprite2})

    x, y = self.sprite3:getPosition()
    table.insert(array, {x / self.blockWidth, y / self.blockWidth, self.sprite3})

    x, y = self.sprite4:getPosition()
    table.insert(array, {x / self.blockWidth, y / self.blockWidth, self.sprite4})

    return array
end

--------------------------------
-- 获取格子的逻辑坐标(都是正数)
-- @function [parent=#BaseBlock] getPositiveGridArray
function BaseBlock:getPositiveGridArray()
    local array = self:getGridArray()
    local offsetX, offsetY = self:_getGridArrayOffSet(array)

    if offsetX > 0 or offsetY > 0 then
        for _, value in pairs(array) do
            value[1] = value[1] + offsetX
            value[2] = value[2] + offsetY
        end
    end

    return array
end

--------------------------------
-- 获取格子的负极值
-- @function [parent=#BaseBlock] getPositiveGridArray
function BaseBlock:_getGridArrayOffSet(array)
    local minx = 0
    local miny = 0
    for _, value in pairs(array) do
        if value[1] < minx then
            minx = value[1]
        end
        if value[2] < miny then
            miny = value[2]
        end
    end

    local offsetX = 0
    local offsetY = 0
    if minx < 0 then
        offsetX = -minx
    end
    if miny < 0 then
        offsetY = -miny
    end

    return offsetX, offsetY, minx, miny
end



return BaseBlock