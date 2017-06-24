--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/27
-- Time: 16:44
-- To change this template use File | Settings | File Templates.
-- Random 游戏随机类
local Random = class("Random")

local math_floor = math.floor

--------------------------------
-- 标准化，保证数字在整数范围之内
-- @function normalize
local function normalize(n) --keep numbers at (positive) 32 bits
	return n % 0x80000000
end

--------------------------------
-- 位运算 and
-- @function bit_and
local function bit_and(a, b)
	local r = 0
	local m = 0
	for m = 0, 31 do
		if (a % 2 == 1) and (b % 2 == 1) then r = r + 2^m end
		if a % 2 ~= 0 then a = a - 1 end
		if b % 2 ~= 0 then b = b - 1 end
		a = a / 2 b = b / 2
	end
	return normalize(r)
end

--------------------------------
-- 位运算 or
-- @function bit_or
local function bit_or(a, b)
	local r = 0
	local m = 0
	for m = 0, 31 do
		if (a % 2 == 1) or (b % 2 == 1) then r = r + 2^m end
		if a % 2 ~= 0 then a = a - 1 end
		if b % 2 ~= 0 then b = b - 1 end
		a = a / 2 b = b / 2
	end
	return normalize(r)
end

--------------------------------
-- 位运算 xor
-- @function bit_xor
local function bit_xor(a, b)
	local r = 0
	local m = 0
	for m = 0, 31 do
		if a % 2 ~= b % 2 then r = r + 2^m end
		if a % 2 ~= 0 then a = a - 1 end
		if b % 2 ~= 0 then b = b - 1 end
		a = a / 2 b = b / 2
	end
	return normalize(r)
end

--------------------------------
-- 获取种子
-- @function bit_xor
local function seed()
	--return normalize(tonumber(tostring(os.time()):reverse()))
	return normalize(os.time())
end

--------------------------------
-- 构建随机数，本随机采用Multiply-with-carry算法
-- https://en.wikipedia.org/wiki/Multiply-with-carry
-- @function [parent=#Random] ctor
function Random:ctor(seed, r)
    self.a = 1103515245
    self.c = 12345
    self.m = 0x1000

    if r then
		if r == 'nr' then temp.a, temp.c, temp.m = 1664525, 1013904223, 0x10000 --from Numerical Recipes.
		elseif r == 'mvc' then temp.a, temp.c, temp.m = 214013, 2531011, 0x10000 end--from MVC
	end
    self.ic = self.c
    self:randomseed(seed)
end

--------------------------------
-- 设置随机种子
-- @function [parent=#Random] randomseed
function Random:randomseed(s)
    if not s then s = seed() end
	self.c = self.ic
	self.x = normalize(s)
end

--------------------------------
-- 随机一个指定范围的整数[1 - n]
-- @function [parent=#Random] nextInt
function Random:nextInt(n)
    return self:random(n)
end

--------------------------------
-- 随机true/false
-- @function [parent=#Random] nextBoolean
function Random:nextBoolean()
    local n = self:nextInt(2)
    if n == 1 then
        return true
    else
        return false
    end
end

--------------------------------
-- 随机一个a,b之间的数字
-- @function [parent=#Random] random
function Random:random(a, b)
	local m = self.m
	local t = self.a * self.x + self.c
	local y = t % m
	self.x = y
	self.c = math_floor(t / m)
	if not a then return y / 0xffff
	elseif not b then
		if a == 0 then return y
		else return 1 + (y % a) end
	else
		return a + (y % (b - a + 1))
	end
end

return Random