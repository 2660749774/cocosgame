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

--------------------------------
-- 给string添加endwith方法
-- @function trim
function string.endwith(input, text)
    if input == nil or text == nil then
        return false
    end
    
    local inputLen = string.len(input)
    local textLen = string.len(text)
    if inputLen < textLen then
        return false
    elseif inputLen == textLen then
        return input == text
    else
        local subInput = string.sub(input, -textLen, -1)
        return subInput == text
    end
end

--------------------------------
-- 给string添加startwith方法
-- @function trim
function string.startwith(input, text)
    if input == nil or text == nil then
        return false
    end
    
    local inputLen = string.len(input)
    local textLen = string.len(text)
    if inputLen < textLen then
        return false
    elseif inputLen == textLen then
        return input == text
    else
        local subInput = string.sub(input, 1, textLen)
        return subInput == text
    end
end