--------------------------------
-- trim操作
-- @function trim
function trim(s)
    return string.gsub(s, '%z', "")
end

--------------------------------
-- trim array 去除数组中nil和空白字符
-- @function trim
function trimArray(array)
    local _array = {}
    for _, value in pairs(array) do
        if value ~= nil and trim(value) ~= "" then
            table.insert(_array, value)
        end
    end

    return _array
end