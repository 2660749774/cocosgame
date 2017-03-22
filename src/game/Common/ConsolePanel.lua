--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:06
-- To change this template use File | Settings | File Templates.
-- ConsolePanel 控制台面板
local ConsolePanel = class("ConsolePanel", BasePanel)

ConsolePanel.ERROR = cc.c3b(255, 54, 0)
ConsolePanel.DEFAULT = cc.c3b(255, 255, 255)
ConsolePanel.HINT = cc.c3b(30, 144, 255)
ConsolePanel.FONT_SIZE = 18

ConsolePanel.MAX_WIDTH = 530

--------------------------------
-- 创建方法
-- @function [parent=#ConsolePanel] onCreate
function ConsolePanel:onCreate()
    local layout = require("layout.ConsolePanel").create()
    

    self.btnClear = layout['btn_clear']
    self.btnClose = layout['btn_close']
    self.btnSend = layout['btn_send']
    self.listView = layout['listView']
    self.textTemplate = layout['text_template']

    self.inputHolder = cc.EditBox:create(cc.size(450, 60), cc.Scale9Sprite:create(), cc.Scale9Sprite:create())
    self.inputHolder:setAnchorPoint(0.5, 0.5)
    self.inputHolder:setPosition(225, 30)
    self.inputHolder:setFontColor(cc.c3b(0, 128, 0))
    self.inputHolder:setPlaceHolder("请输入命令，帮助请输入help")
    self.inputHolder:setFontSize(24)
    self.inputHolder:setInputMode(6)
    layout['input_bg']:addChild(self.inputHolder)

    self.useage = {
        "help 查看帮助",
        "log [n=100] 查看最近100条日志",
        "error  查看错误日志"

    }
    
    self:addLayoutWithMask(layout, 'layout.ModalMask')

    -- 绑定事件
    self.btnSend:addClickEventListener(handler(self, self.sendCommand))
    self.btnClose:addClickEventListener(function() 
        self:getScene():popPanel()
    end)
    self.btnClear:addClickEventListener(function() 
        self.listView:removeAllItems()
    end)
    log:info("添加控制台")
end

--------------------------------
-- 发送命令
-- @function [parent=#ConsolePanel] sendCommand
function ConsolePanel:sendCommand()
    local text = self.inputHolder:getText()
    if text == nil or text == "" then
        self:pushTextToList("请输入命令", ConsolePanel.ERROR)
        return
    end

    self.inputHolder:setText("")

    -- 解析命令
    text = trim(text)
    local commandArray = trimArray(string.split(text, ' '))
    local func = "do" .. string.upper(commandArray[1])
    if self[func] then
        self[func](self, commandArray)
    else
        self:pushTextToList("错误的指令:" .. commandArray[1], ConsolePanel.ERROR)
        return
    end
end

--------------------------------
-- 帮助指令
-- @function [parent=#ConsolePanel] doHELP
function ConsolePanel:doHELP(args)
    for _, value in pairs(self.useage) do
        self:pushTextToList(value)
    end
end

--------------------------------
-- 日志查询
-- @function [parent=#ConsolePanel] doLOG
function ConsolePanel:doLOG(args)
    local num = 100
    if #args > 1 then
        num = tonumber(args[2])
    end

    if num <= 0 then
        self:pushTextToList("参数错误，请输入一个大于0的数字", ConsolePanel.ERROR)
        return
    end

    self:pushTextToList("日志查询结果如下：", ConsolePanel.HINT)
    local logArray = log:getHistory(num)
    local len = #logArray
    for i=1, len do
        self:pushTextToList(string.format("L%s:%s", i, logArray[len - i + 1]))
    end
end

--------------------------------
-- 错误日志查询
-- @function [parent=#ConsolePanel] doERROR
function ConsolePanel:doERROR(args)
    self:pushTextToList("错误日志查询结果如下：", ConsolePanel.HINT)
    local logArray = log:getErrorHistory()
    local len = #logArray
    log:info("error len:%s", #logArray)
    for i=1, len do
        self:pushTextToList(string.format("-----------第%s条错误日志开始-----------", i))
        self:pushTextToList(logArray[len - i + 1])
        self:pushTextToList(string.format("-----------第%s条错误日志结束-----------", i))
    end
end

--------------------------------
-- 添加文本到控制台
-- @function [parent=#ConsolePanel] pushTextToList
function ConsolePanel:pushTextToList(text, color)
    color = color or ConsolePanel.DEFAULT

    -- 按照字符个数划分text
    local maxWidth = ConsolePanel.MAX_WIDTH
    local textArray = {}
    local textWidthArray = {}
    local len  = string.len(text)
    local left = len
    local arr  = {0, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc}
    local totalWidth = 0
    while left ~= 0 do
        local tmp = string.byte(text, -left)
        local i   = #arr
        while arr[i] do
            if tmp >= arr[i] then
                left = left - i
                break
            end
            i = i - 1
        end
        -- log:info("text, left:%s, i:%s", left, i)
        -- log:info("text:%s", string.sub(text, -left - i, -left - 1))
        table.insert(textArray, string.sub(text, -left - i, -left - 1))
        if i == 3 then
            -- 中文字符，宽度=字体大小
            local width = ConsolePanel.FONT_SIZE
            totalWidth = totalWidth + width
            table.insert(textWidthArray, width)
        else
            -- 其他字符，宽度=字体大小 / 2
            local width = ConsolePanel.FONT_SIZE / 2
            totalWidth = totalWidth + width
            table.insert(textWidthArray, width)
        end
    end

    -- 插入换行符
    local txt = ""
    if totalWidth < maxWidth then
        txt = text
    else
        local width = 0
        local wrapLine = 1
        for i=1, #textWidthArray do 
            width = width + textWidthArray[i]
            if width >= maxWidth then
                table.insert(textArray, i + wrapLine, '\n')
                width = 0
                wrapLine = wrapLine + 1
            end
        end
        txt = table.concat(textArray, "")
    end

    -- 显示文本
    local textLabel = self.textTemplate:clone()
    textLabel:setFontSize(ConsolePanel.FONT_SIZE)
    textLabel:setString(txt)
    textLabel:setTextColor(color)
    textLabel:setVisible(true)

    self.listView:pushBackCustomItem(textLabel)
end

--------------------------------
-- 卸载资源
-- @function [parent=#ConsolePanel] onExit
function ConsolePanel:onExit()
    -- 卸载资源
end

return ConsolePanel

