local ListView = ccui.ListView

--------------------------------
-- 初始化
-- @function [parent=#ListView] init
function ListView:init()
    self.container = self:getInnerContainer()
    self.itemCount = 0
end

--------------------------------
-- 获取滑动百分比
-- @function [parent=#ListView] getScrollPercent
function ListView:getScrollPercent()
    local container = self.container
    
    -- 获取当前滑动区块高度
    local minY = self:getContentSize().height - container:getContentSize().height
    local height = -minY
    if height == 0 then
        return 0
    end

    -- 获取滑动百分比
    local percent = 1 - math.abs(container:getPositionY() / height)
    if percent < 0 or percent > 1  then
        -- 异常值处理
        return 0
    end

    return percent
end

--------------------------------
-- 插入元素，并且自动调整
-- @function [parent=#ListView] addItem
function ListView:addItem(item, adjust)
    local percent = nil
    if adjust then
        percent = self:getScrollPercent()
        -- log:info("addItem, percent:%s", percent)
    end
    self:pushBackCustomItem(item)
    if adjust then
        self:refreshView()
        local percent = self.itemCount * percent / (self.itemCount + 1)
        self:jumpToPercentVertical(percent * 100)
    end
    self.itemCount = self.itemCount + 1
end
