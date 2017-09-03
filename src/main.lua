
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
cc.exports.log = (require "core.log").new()

local function main()
    -- 添加搜索路径
    local TAG = "main"

    -- 获取底包版本号
    local originVersion = require("game.version")
    log:tag(TAG, "底包资源版本号:%s", originVersion.resVersion)
    log:tag(TAG, "底包客户端版本号:%s", originVersion.clientVersion)
    log:tag(TAG, "底包编译版本号:%s", originVersion.buildNo)
    log:tag(TAG, "底包类型:%s", originVersion.packType)

    -- 获取动更资源版本号
    local userDefault = cc.UserDefault:getInstance()
    local fileUtils = cc.FileUtils:getInstance()
    local resMove = userDefault:getStringForKey("resMoving", "false")
    local resVersion = userDefault:getStringForKey("resVersion", "")
    local updateDir = userDefault:getStringForKey("resDir", "")

    log:tag(TAG, "资源版本号:%s", resVersion)
    log:tag(TAG, "资源移动标志位:%s", resMove)
    log:tag(TAG, "资源所在目录:%s", updateDir)

    if resVersion ~= "" then
        -- 动更过
        local appCoverInstall = false

        local originVersionArray = string.split(originVersion.resVersion, ".")
        for i=1, 4 do
            originVersionArray[i] = tonumber(originVersionArray[i])
        end
        local resVersionArray = string.split(resVersion, ".")
        for i=1, 4 do
            resVersionArray[i] = tonumber(resVersionArray[i])
        end
        for i=1, 4 do
            if originVersionArray[i] > resVersionArray[i] then
                appCoverInstall = true
            end
        end

        local writePath = fileUtils:getWritablePath()
        if string.sub(writePath, -1, -1) ~= "/" then
            writePath = writePath .. "/"
        end

        log:tag(TAG, "覆盖安装:%s", appCoverInstall)
        log:tag(TAG, "是否在移动:%s", resMove)
        if updateDir == "" then
            updateDir = "update"
        end
        if updateDir and resMove == "false" then
            local updatePath = writePath .. updateDir
            log:tag(TAG, "添加搜索路径:%s, front:%s", updatePath, appCoverInstall == false)
            fileUtils:addSearchPath(updatePath, appCoverInstall == false)
        end
    end

    -- 启动游戏
    local game = require("game.Game").new("game")
    game:startup()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
