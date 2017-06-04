--
-- User: wangys
-- RandomUtil 随机工具类

local RandomUtil = {}

-- 随机字符串
RandomUtil.random_letters = {
	'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't',
	'u', 'v', 'w', 'x', 'y', 'z',
	'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
	'U', 'V', 'W', 'X', 'Y', 'Z'
}

--------------------------------
-- 初始化方法
-- @function [parent=#RandomUtil] init
function RandomUtil:init()
    -- 设置随机种子
    log:info("init RandomUtil")
    math.randomseed(tonumber(tostring(os.time()):reverse():sub(1,6)))
    log:info(math.random())
    log:info(math.random())
    log:info(math.random())
end

--------------------------------
-- 初始化方法
-- @function [parent=#RandomUtil] init
function RandomUtil:setRandomseed(randomseed)
    -- 设置随机种子
    log:info("init RandomUtil")
    math.randomseed(randomseed)
    log:info(math.random())
    log:info(math.random())
    log:info(math.random())
end

--------------------------------
-- 随机一个指定范围的整数[1 - n]
-- @function [parent=#RandomUtil] nextInt
function RandomUtil:nextInt(n)
    return math.random(1, n)
end

--------------------------------
-- 从指定概率配置随机一个下标
-- @function [parent=#RandomUtil] nextDoubleIndex
function RandomUtil:nextDoubleIndex(probArray)
    local prob = self:nextDouble()
    local index = -1
    local temp = 0
    for i = 1, #probArray do
        index = i
        temp = temp + probArray[i]
        if prob < temp then
            break
        end
    end
    return index
end

--------------------------------
-- 随机一个[0 - 1)的浮点数
-- @function [parent=#RandomUtil] nextDouble
function RandomUtil:nextDouble()
    return math.random()
end

--------------------------------
-- 随机一个[0 - 1)的浮点数
-- @function [parent=#RandomUtil] nextBoolean
function RandomUtil:nextBoolean()
    return RandomUtil:nextDouble() < 0.5
end

--------------------------------
-- 随机指定长度字符串
-- @function [parent=#RandomUtil] genRandomStr
function RandomUtil:genRandomStr(len)
    local rtn = ""
    for i=1, len do
        rtn = rtn .. RandomUtil.random_letters[RandomUtil:nextInt(#RandomUtil.random_letters)]
    end
    
    return rtn
end

return RandomUtil
