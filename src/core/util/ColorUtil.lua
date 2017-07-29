--
-- User: wangys
-- ColorUtil 颜色工具类

local ColorUtil = {}

--------------------------------
-- 16进制color转换
-- @function [parent=#RandomUtil] hexColor
function ColorUtil.hexColor(hexColor)
    local r = string.format("%d", "0x" .. string.sub(hexColor, 2, 3))
    local g = string.format("%d", "0x" .. string.sub(hexColor, 4, 5))
    local b = string.format("%d", "0x" .. string.sub(hexColor, 6, 7))

    return { r = tonumber(r), g = tonumber(g), b = tonumber(b)}
end

return ColorUtil
