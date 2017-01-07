
--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- uiTestScene 测试场景
-- local BaseTestScene = require("game.TestLua.tests.BaseTestScene")
local particleTestPanel = class("particleTestPanel", BasePanel)

function particleTestPanel:onCreate()
    local bgSprite = cc.Sprite:create("ui/particle/bg.jpg")
    bgSprite:setAnchorPoint(0, 0)
    bgSprite:setPosition(cc.p(display.cx / 2, 0))
    self:addChild(bgSprite, 0)

    -- 添加粒子特效
    local particle = cc.ParticleSystemQuad:create("particle/snow.plist")    
    particle:retain()
    local particleBatch = cc.ParticleBatchNode:createWithTexture(particle:getTexture())
    particleBatch:addChild(particle)
    particle:setPosition(cc.p(250, 640))
    bgSprite:addChild(particleBatch, 10)
    particle:release()

end



return particleTestPanel
