
cc.FileUtils:getInstance():setPopupNotify(false)

-- 平台常量定义
local PLATFORM_OS_WINDOWS = 0
local PLATFORM_OS_LINUX   = 1
local PLATFORM_OS_MAC     = 2
local PLATFORM_OS_ANDROID = 3
local PLATFORM_OS_IPHONE  = 4
local PLATFORM_OS_IPAD    = 5
local PLATFORM_OS_BLACKBERRY = 6
local PLATFORM_OS_NACL    = 7
local PLATFORM_OS_EMSCRIPTEN = 8
local PLATFORM_OS_TIZEN   = 9
local PLATFORM_OS_WINRT   = 10
local PLATFORM_OS_WP8     = 11

-- 根据平台添加搜索路径
local platform = cc.Application:getInstance():getTargetPlatform()
if platform == PLATFORM_OS_WINDOWS or platform == PLATFORM_OS_MAC then
    -- mac or win
    cc.FileUtils:getInstance():addSearchPath("src/")
    cc.FileUtils:getInstance():addSearchPath("res/")
    cc.FileUtils:getInstance():addSearchPath("../../../res/")
end

require "config"
require "cocos.init"

local function main()
    local game = require("game.Game").new("game")
    game:startup()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
