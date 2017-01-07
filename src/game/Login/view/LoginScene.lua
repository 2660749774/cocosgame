--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- MainScene 2048主场景
local LoginScene = class("LoginScene", BaseScene)


--------------------------------
-- 创建方法
-- @function [parent=#LoginScene] onCreate
function LoginScene:onCreate()
    local layout = require("layout.2048Scene").create()
    self.gamePanel = layout['gamePanel']
    self.btnPlay = layout['btn_play']
    self.lbScore = layout['lb_score']
    self.grid = initGrid(4, 4)
    self.gridShow = {}
    self:createGridShow()

    -- 添加事件
    self.btnPlay:addClickEventListener(handler(self, self.playGame))

    self:addObject(layout["root"], "scene")
end

--------------------------------
-- 开始游戏
-- @function [parent=#MainScene] playGame
function MainScene:playGame()
    -- 重新初始化
    self.gamePanel:removeAllChildren()
    self.grid = initGrid(4, 4)
    self.gridShow = {}
    self:createGridShow()
    self.btnPlay:setVisible(false)
    self.totalScore = 0
    self.lbScore:setString(string.format("SCORE: %d", self.totalScore))
    self.isOver = false

    self.gamePanel:setTouchEnabled(true)
    self.gamePanel:addTouchEventListener(handler(self, self.onTouch))

end

--------------------------------
-- 处理触摸事件
-- @function [parent=#MainScene] onTouch
function MainScene:onTouch(target , event)
    if self.isOver then
        return
    end

    if event == ccui.TouchEventType.began then
        local location = target:getTouchBeganPosition()
        self.touchStart = location
    elseif event == ccui.TouchEventType.moved then
    elseif event == ccui.TouchEventType.ended then
        local location = target:getTouchEndPosition()
        local tx,ty=location.x-self.touchStart.x,location.y-self.touchStart.y
        if tx==0 then
            tx = tx+1
            ty = ty+1
        end
        local dis = tx*tx+ty*ty
        if dis<3 then   -- touch move too short will ignore
            return true
        end
        local dt = ty/tx
        local op_list,score,win
        if dt>=-1 and dt<=1 then
            if tx>0 then
                op_list,score,win = touch_op(self.grid,'right')
            else
                op_list,score,win = touch_op(self.grid,'left')
            end
        else
            if ty>0 then
                op_list,score,win = touch_op(self.grid,'up')
            else
                op_list,score,win = touch_op(self.grid,'down')
            end
        end
        self:doOpList(op_list)

        if win then
        --            WINSTR = "YOUR ARE WINER"
        end
        self.totalScore = self.totalScore + score
        self.lbScore:setString(string.format("SCORE: %d", self.totalScore))
        self.isOver = not canMove(self.grid)
        log:info("can Move")
        log:info(canMove(self.grid))
        if self.isOver then
            self.btnPlay:setVisible(true)
            self.btnPlay:setTitleText("Play Again")
        end
    end

end

--------------------------------
-- 更新格子显示
-- @function [parent=#MainScene] doOpList
function MainScene:doOpList(op_list)
    for _,op in ipairs(op_list or {}) do
        local o = op[1]
        if o=='setnum' then
            local i,j,num = op[2],op[3],op[4]
            self:setnum(self.gridShow[i][j],num,i,j)
        end
    end
end

--------------------------------
-- 更新格子数字
-- @function [parent=#MainScene] setnum
function MainScene:setnum(grid,num,i,j)
    local s = tostring(num)
    --s = s.."("..i..","..j..")"
    if s=='0' then 
        s=''
        grid.background:setOpacity(100)
    else
        grid.background:setOpacity(255)
    end
    local c=colors[num]
    if not c then
        c=colors[4096]
    end
    grid.num:setString(s)
    grid.background:setColor(c)
    local nc = numcolors[num]
    if not nc then
        nc = numcolors[128]
    end
    grid.num:setColor(nc)
end

--------------------------------
-- 初始化表格
-- @function [parent=#MainScene] createGridShow
function MainScene:createGridShow()
    self.gridShow = {}
    for tmp=0,15 do
        local i,j = math.floor(tmp/4)+1,math.floor(tmp%4)+1
        local num = self.grid[i][j]
        local s = tostring(num)
        --s = s.."("..i..","..j..")"
        if s=='0' then
            s=''
        end
        if not self.gridShow[i] then
            self.gridShow[i] = {}
        end

        local num = ccui.Text:create()
        num:setFontSize(40)
        num:setString(s)
        num:setColor(numcolors[self.grid[i][j]])
        local cell = {
            backgroundsize = 140,
            background = cc.LayerColor:create(colors[-1], 140, 140),
            num = num
        }
        self.gridShow[i][j] = cell
        self:addCell(self.gridShow[i][j],i,j)
    end
end

--------------------------------
-- 计算格子位置
-- @function [parent=#MainScene] getPosFormIdx
function MainScene:getPosFormIdx(mx,my)
    local cellsize = 150   -- cell size
    local cdis = 2*cellsize - cellsize / 2
    local origin = {x=display.cx-cdis,y=display.cy+cdis}
    local x = (my-1)*cellsize+origin.x
    local y = -(mx-1)*cellsize+origin.y - 18

    return x,y
end

--------------------------------
-- 增加格子
-- @function [parent=#MainScene] addCell
function MainScene:addCell(cell,mx,my)
    local x,y = self:getPosFormIdx(mx,my)
    local bsz = cell.backgroundsize/2
    cell.background:setPosition(cc.p(x-bsz,y-bsz))
    self.gamePanel:addChild(cell.background)
    cell.background:addChild(cell.num)
    cell.num:setPosition(cc.p(70,70))
    if self.grid[mx][my] > 0 then
        cell.background:setOpacity(255)
    end
end


--------------------------------
-- 卸载资源
-- @function [parent=#MainScene] onExit
function MainScene:onExit()
-- 卸载资源
end


return MainScene

