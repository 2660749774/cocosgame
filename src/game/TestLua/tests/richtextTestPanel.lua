
--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- uiTestScene 测试场景
-- local BaseTestScene = require("game.TestLua.tests.BaseTestScene")
local richtextTestPanel = class("richtextTestPanel", BasePanel)
local RichLabel = require("core.component.richlabel.RichLabel")
function richtextTestPanel:onCreate()
    -- BaseTestScene.onCreate(self)

    -- local test_text = {
    --     "<div fontcolor=#ff0000>hello</div><div fontcolor=#00ff00>hello</div><div fontsize=12>你</div><div fontSize=26 fontcolor=#ff00bb>好</div>ok",
    --     "<div outline=1,#ff0000>hello</div>",
    --     "<div glow=#ff0000 >hello</div>"
    -- }
    -- for i=1, #test_text do
	--     local label = RichLabel.new {
	--         fontSize = 20,
	--         fontColor = cc.c3b(255, 255, 255),
	--         maxWidth=200,
	--         lineSpace=0,
	--         charSpace=0,
	--     }
	--     label:setString(test_text[i])
	--     label:setPosition(cc.p(380,500-i*30))
	--     label:playAnimation()
		-- local _richText = ccui.RichText:create()
		local _richText = ccui.RichText:createWithXML("<font face='Arial' size='24'>you should see an image here</font>: <img src='ui/button/choose.png'/> and this is text again. and this is the same image, but bigger: <img src='ui/button/choose.png' width='30' height='30' /> and here goes text again",{
		})
		-- local _richText = ccui.RichText:create()
		_richText:ignoreContentAdaptWithSize(false)
        _richText:setContentSize(cc.size(300, 100))
        
		-- local re1 = ccui.RichElementText:create(1, cc.WHITE, 255, "HELLO", "Arial", 28)
		-- local re2 = ccui.RichElementText:create(2, cc.YELLOW, 255, "And this is yellow. ", "Arial", 24)
		-- local re3 = ccui.RichElementText:create(3, cc.BLUE, 255, "Yu Mincho", "Arial", 24)
		-- local re4 = ccui.RichElementText:create(4, cc.GREEN, 255, "And green with TTF support. ", "Arial", 24)
		-- local re5 = ccui.RichElementText:create(5, cc.RED, 255, "Last one is red ", "Arial", 24)

		-- _richText:pushBackElement(re1)
        -- _richText:insertElement(re2, 1)
        -- _richText:pushBackElement(re3)
        -- _richText:pushBackElement(re4)
        -- _richText:pushBackElement(re5)
		-- _richText:setLocalZOrder(10)

		_richText:setPosition(cc.p(400, 500))
	    self:addChild(_richText)
		

	    -- label:debugDraw()
	-- end 
end

function richtextTestPanel:onExit()
    -- 重新注册事件
    self:getScene().btn:addClickEventListener(function (event)
        app:changeScene("TestLua", {}, "random", 1)
    end)
end



return richtextTestPanel
