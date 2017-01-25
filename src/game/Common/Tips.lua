--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/12/31
-- Time: 14:01
-- To change this template use File | Settings | File Templates.
-- Tips 通用Tips提示
local Tips = {}

--------------------------------
-- 创建方法
-- @function [parent=#Tips] showTips
function Tips.showTips(msg, parent, interval)
    -- 创建Tips
    local tips = Tips._createTips(msg, interval)
    
    -- 添加到父节点
    local contentSize = parent:getContentSize()
    tips:setPosition(contentSize.width / 2, contentSize.height / 2)
    parent:addChild(tips)
end

--------------------------------
-- 创建方法
-- @function [parent=#Tips] showTips
function Tips.showSceneTips(msg, interval)
    local tips = Tips._createTips(msg, interval)

    -- 添加到当前Scene
    local scene = app:getCurrScene()
    local tipLayer = scene:getLayer("tips")
    tipLayer:removeAllChildren()

    tips:setPosition(display.cx, display.cy)
    scene:addObject(tips, "tips")
end

--------------------------------
-- 创建Tips
-- @function [parent=#Tips] showTips
function Tips._createTips(msg, interval)
    -- 创建Tips
    interval = interval or 2
    local layout = require("layout.CommTips").create()
    layout['panel']:setSize(cc.size(display.width, 80))
    local lbTips = layout['lb_tips']
    lbTips:setString(msg)
    lbTips:setPositionX(display.cx)

    -- 定时移除
    local node = layout['root']
    if interval > 0 then
        scheduler.performWithDelayGlobal(function()
            if not tolua.isnull(node) then
                node:removeFromParent()
            end
        end, interval)
    end

    return node
end

return Tips