--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- PlayScene 游戏试玩场景
local PlayScene = class("PlayScene", BaseScene)
local GameView = import(".GameView")

--------------------------------
-- 创建方法
-- @function [parent=#Game] onCreate
function PlayScene:onCreate()
    -- 加载资源
    rmgr:loadSpriteFrames("pack.plist", "Play")

    self.gameView_ = GameView:create(self, "gameView")
    self.gameView_:addEventListener(GameView.events.PLAYER_DEAD_EVENT, handler(self, self.onPlayerDead))
    self.gameView_:start()
    self.gameView_:show("ui")
end

--------------------------------
-- 游戏结束回调
-- @function [parent=#PlayScene] onCreate
function PlayScene:onPlayerDead(event)
    -- add game over text
    printInfo("onPlayerDead call")
    local text = string.format("You killed %d bugs", self.gameView_:getKills())
    local label = cc.Label:createWithSystemFont(text, "Arial", 96)
    :align(display.CENTER, display.center)
    self:addObject(label, "ui")

    -- add exit button
    local exitButton = cc.MenuItemImage:create("ExitButton.png", "ExitButton.png")
    :onClicked(function()
        self.app:changeScene("Main")
    end)
    local menu = cc.Menu:create(exitButton)
    :move(display.cx, display.cy - 200)
    self:addObject(menu, "ui")
end

--------------------------------
-- 卸载资源
-- @function [parent=#PlayScene] onCreate
function PlayScene:onExit()
    -- 卸载资源
    rmgr:removeSpriteFramesByGroup("Play")
end

return PlayScene

