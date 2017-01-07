--
-- User: wangys
-- BaseBlock 俄罗斯方块 - 方块3
--   |   |   |   |   |
--   | 1 | 2 | 3 | 4 |
--   |   |   |   |   |
--   |   |   |   |   |

--   |   | 1 |   |   |
--   |   | 2 |   |   |
--   |   | 3 |   |   |
--   |   | 4 |   |   |



local BaseBlock = import(".BaseBlock")

local Block3 = class("Block3", BaseBlock)


--------------------------------
-- 构造函数
-- @function [parent=#Block3] ctor
function Block3:ctor(angle, min, max, pic)
    BaseBlock.ctor(self, 3, angle, min, max, pic)
    self.max = self.max - self.blockWidth
    self.nextOffset = -self.blockWidth / 2

    self:createBlock()
    self:rotation()
end

--------------------------------
-- 创建Block
-- @function [parent=#Block3] createBlock
function Block3:createBlock()
    local bg = cc.Sprite:create() --cc.LayerColor:create(ccc4(0xFF, 0x00, 0x00, 0x80), 120, self.blockWidth)
    bg:setContentSize(cc.size(120,self.blockWidth))
    bg:setAnchorPoint(0, 0)
    
    local sprite1 = cc.Sprite:create(self.pic)
    local sprite2 = cc.Sprite:create(self.pic)
    local sprite3 = cc.Sprite:create(self.pic)
    local sprite4 = cc.Sprite:create(self.pic)

    sprite1:setPosition(cc.p(0, 0))
    sprite1:setAnchorPoint(cc.p(0, 0))

    sprite2:setPosition(cc.p(self.blockWidth, 0))
    sprite2:setAnchorPoint(cc.p(0, 0))

    sprite3:setPosition(cc.p(self.blockWidth * 2, 0))
    sprite3:setAnchorPoint(cc.p(0, 0))

    sprite4:setPosition(cc.p(self.blockWidth * 3, 0))
    sprite4:setAnchorPoint(cc.p(0, 0))

    bg:addChild(sprite1)
    bg:addChild(sprite2)
    bg:addChild(sprite3)
    bg:addChild(sprite4)
    self:addChild(bg)
    self.width = 120

    self.sprite1 = sprite1
    self.sprite2 = sprite2
    self.sprite3 = sprite3
    self.sprite4 = sprite4

    return rtnSprite
end


--------------------------------
-- 进行翻转
-- @function [parent=#Block3] rotation
function Block3:rotation()
    if self.angle < 0 then
        self.angle = 0
        return
    end

    if self.angle == 0 then
        self.angle = 90
        self.sprite1:setPosition(cc.p(self.blockWidth, self.blockWidth))
        self.sprite3:setPosition(cc.p(self.blockWidth, -self.blockWidth))
        self.sprite4:setPosition(cc.p(self.blockWidth, -self.blockWidth * 2))
        self.offsetLeft = -self.blockWidth
        self.offsetRight = self.blockWidth * 2
    elseif self.angle == 90 then
        self.angle = 180
        self.sprite1:setPosition(cc.p(0, 0))
        self.sprite3:setPosition(cc.p(self.blockWidth * 2, 0))
        self.sprite4:setPosition(cc.p(self.blockWidth * 3, 0))
        self.offsetLeft = 0
        self.offsetRight = 0
    elseif self.angle == 180 then
        self.angle = 270
        self.sprite1:setPosition(cc.p(self.blockWidth, self.blockWidth))
        self.sprite3:setPosition(cc.p(self.blockWidth, -self.blockWidth))
        self.sprite4:setPosition(cc.p(self.blockWidth, -self.blockWidth * 2))
        self.offsetLeft = -self.blockWidth
        self.offsetRight = self.blockWidth * 2
    elseif self.angle == 270 then
        self.angle = 0
        self.sprite1:setPosition(cc.p(0, 0))
        self.sprite3:setPosition(cc.p(self.blockWidth * 2, 0))
        self.sprite4:setPosition(cc.p(self.blockWidth * 3, 0))
        self.offsetLeft = 0
        self.offsetRight = 0
    end

    self:fixPosition()
    
end



return Block3