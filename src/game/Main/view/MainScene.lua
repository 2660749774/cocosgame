--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- MainScene 主场景
local MainScene = class("MainScene", BaseScene)
local RichTextView = import(".RichTextView")

--------------------------------
-- 创建方法
-- @function [parent=#Game] onCreate
function MainScene:onCreate()
    -- add background image
--    display.newSprite("MainSceneBg.jpg")
--    :move(display.center)
--    :addTo(self)
--
--    -- add play button
--    local playButton = cc.MenuItemImage:create("PlayButton.png", "PlayButton.png")
--    :onClicked(function()
--        self.app:changeScene("Play")
--    end)
--    cc.Menu:create(playButton)
--    :move(display.cx, display.cy - 200)
--    :addTo(self)
     
     -- 加载资源
     rmgr:loadSpriteFrames("pack.plist", "Main")
     
     local layout = require("layout.MainLayout").create()
     local btnPlay = layout.btn_play
     local btnPlay = layout["root"]:getChildByName("btn_play")
     btnPlay:addClickEventListener(function()
         self.app:changeScene("Play")
     end)
     self:addObject(layout["root"], "ui")

--    -- 建立连接
--    cmgr:open("127.0.0.1", 8010)
--    
--
--    self.richView = RichTextView:create(self, "gameView")
--    self.richView:show("ui")


end


--------------------------------
-- 卸载资源
-- @function [parent=#Game] onExit
function MainScene:onExit()
     -- 卸载资源
     rmgr:removeSpriteFramesByGroup("Main")
end

return MainScene

