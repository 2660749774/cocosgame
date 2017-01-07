
--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- TestLuaScene 测试场景
-- local BaseTestScene = require("game.TestLua.tests.BaseTestScene")
local fileTestPanel = class("fileTestPanel", BasePanel)

function fileTestPanel:onCreate()
    local label = cc.Label:createWithSystemFont("正在读取文件...","Arial",12)
    label:setPosition(cc.p(display.cx, display.cy))
    self:addChild(label)

    local file = "config.lua"
    local path = cc.FileUtils:getInstance():fullPathForFilename(file)
    if (io.exists(path)) then
        local content = io.readfile(path)
        label:setString(content)
    else
        label:setString("读取不到对应文件：" .. file)
    end
end

function fileTestPanel:getFileDataTest()
end

return fileTestPanel
