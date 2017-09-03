
cc.FileUtils:getInstance():setPopupNotify(false)

local platform = cc.Application:getInstance():getTargetPlatform()
if platform == cc.PLATFORM_OS_ANDROID then
    cc.FileUtils:getInstance():addSearchPath("assets/")
elseif platform == cc.PLATFORM_OS_IPHONE
    or platform == cc.PLATFORM_OS_IPAD then
    cc.FileUtils:getInstance():addSearchPath("Raw/")
else
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
