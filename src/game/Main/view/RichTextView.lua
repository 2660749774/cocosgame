--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/8/28
-- Time: 10:43
-- To change this template use File | Settings | File Templates.
-- RichTextView
local RichTextView = class("RichTextView", BasePanel)
local RichLabel = require("core.component.RichLabel")

--------------------------------
-- 创建方法
-- @function [parent=#RichTextView] onCreate
function RichTextView:onCreate()
    self:createBtn(display.width-200, 125, "创建")
    self:createBtn1(display.width-120, 125, "删除")

    -- bind the "event" component
    cc.bind(self, "event")
end

function RichTextView:createBtn(x, y, txt)
    self.StoreBtn = ccui.Button:create()
--
--
--    self.StoreBtn:loadTextureNormal("wsk1.png",0)
--    self.StoreBtn:loadTexturePressed("wsk1.png",0)
--    self.StoreBtn:loadTextureDisabled("wsk1.png",0)
    self.StoreBtn:setTitleFontSize(24)
    self.StoreBtn:setTitleText(txt)
    self.StoreBtn:setScale9Enabled(true)
    self.StoreBtn:setCapInsets(cc.rect(15,11,210,98))


    self.StoreBtn:addClickEventListener(function(event)
        log:info("click add rich lab")
        self:createRichLab()
    end)

    self:addChild(self.StoreBtn)
    self.StoreBtn:setPosition(cc.p(x, y))
end

function RichTextView:createBtn1(x, y, txt)
    self.StoreBtn = ccui.Button:create()

--    self.StoreBtn:loadTextureNormal("wsk1.png",0)
--    self.StoreBtn:loadTexturePressed("wsk1.png",0)
--    self.StoreBtn:loadTextureDisabled("wsk1.png",0)
    self.StoreBtn:setTitleFontSize(24)
    self.StoreBtn:setTitleText(txt)
    self.StoreBtn:setScale9Enabled(true)
    self.StoreBtn:setCapInsets(cc.rect(15,11,210,98))



    self.StoreBtn:addClickEventListener(function(event)
        self:removeRichLab()
    end)

    self:addChild(self.StoreBtn)
    self.StoreBtn:setPosition(cc.p(x, y))
end

function RichTextView:removeRichLab()
    if self.ricLab then
        self.ricLab:removeFromParentAndCleanup(true)
        self.ricLab = nil
    end
end

function RichTextView:createRichLab()
    self:removeRichLab()
    -- local str = "[color=0FFFFF]清除自身所有负面状态，并向敌军上/下半场吞吐雷电,造成[/color][color=F0FF00 number=998][360][/color][image=wsk1.png]口[/image][color=FF0F00]+物攻[/color][color=F0FF00]*[0.4][/color][image=wsk1.png]口[/image][color=F0FF00]*[0.4][/color]"
    local str = [[[{"color":"0FFFFF","text":"清除自身所有负面状态，并向敌军上/下半场吞吐雷电,造成"},{"color":"F0FF00","text":"[360]","number":998},{"image":"wsk1.png","text":"口"},{"color":"FF0F00","text":"+700*法强的魔法攻击攻"}]
    ]]
    --[[
    str:字符串 fontSize:字体大小  rowWidth:行宽 rowSpace:行间距
    --]]
    local ricLab = RichLabel.new({str=str, fontSize=14, rowWidth=280})
    ricLab:setPosition(ccp(display.cx-500, display.height-50))
    self:addChild(ricLab)
    -- 添加事件监听函数
    local function listener(button, params)
        print(params.text, params.tag, params.number)
        if params.number == 998 then
            print("预约事件")
        end
    end
    ricLab:setClickEventListener(listener)
    self.ricLab = ricLab
end


function RichTextView:onCleanup()
    self:removeAllEventListeners()
end

return RichTextView
