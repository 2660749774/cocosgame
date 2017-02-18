--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/28
-- Time: 11:51
-- To change this template use File | Settings | File Templates.
-- log 日志记录工具
local Log = class("Log")

-- 日志级别
Log.TRACE = -1
Log.DEBUG = 0
Log.INFO = 1
Log.WARN = 2
Log.ERROR = 3


--------------------------------
-- 构造函数
-- @function [parent=#Log] ctor
function Log:ctor(logLevel)
    local level = logLevel or Log.INFO
    self.logLevel = level
end

--------------------------------
-- 获取时间戳
-- @function [parent=#Log] getTimeStamp
function Log:setLogLevel(level)
    if level < Log.TRACE or level > Log.ERROR then
        self:error("illegal log level %d", level)
        return
    end
    self.logLevel = level
end

--------------------------------
-- 获取时间戳
-- @function [parent=#Log] getTimeStamp
function Log:getTimeStamp()
    return os.date("%Y-%m-%d %H:%M:%S")
end

--------------------------------
-- 格式化日志
-- @param string tag 日志标记
-- @param string fmt 格式化标志
-- @param objects ... 参数
-- @function [parent=#Log] formatLog
function Log:formatLog(tag, fmt, ...)
    local t = {
        self:getTimeStamp(),
        " [",
        string.upper(tostring(tag)),
        "] ",
        string.format(tostring(fmt), ...)
    }
    return table.concat(t)
end

--------------------------------
-- 打印DEBUG日志
-- @param string fmt 格式化标志
-- @param objects ... 参数
-- @function [parent=#Log] debug
function Log:debug(fmt, ...)
    if self.logLevel > Log.DEBUG then
        return
    end
    local log = self:formatLog("DEBUG", fmt, ...)
    print(log)
end

--------------------------------
-- 打印INFO日志
-- @param string fmt 格式化标志
-- @param objects ... 参数
-- @function [parent=#Log] info
function Log:info(fmt, ...)
    if self.logLevel > Log.INFO then
        return
    end
    local log = self:formatLog("INFO", fmt, ...)
    print(log)
end

--------------------------------
-- 打印WARN日志
-- @param string fmt 格式化标志
-- @param objects ... 参数
-- @function [parent=#Log] warn
function Log:warn(fmt, ...)
    if self.logLevel > Log.WARN then
        return
    end
    local log = self:formatLog("WARN", fmt, ...)
    print(log)
end

--------------------------------
-- 打印ERROR日志
-- @param string fmt 格式化标志
-- @param objects ... 参数
-- @function [parent=#Log] error
function Log:error(fmt, ...)
    if self.logLevel > Log.ERROR then
        return
    end

   

    local log = self:formatLog("ERROR", fmt, ...)
    print(log)

    cmgr:send(actions.writeLog, nil, log)
    
end

--------------------------------
-- 打印自定义日志标记日志
-- @param string tag 自定义日志标志
-- @param string fmt 格式化标志
-- @param objects ... 参数
-- @function [parent=#Log] tag
function Log:tag(tag, fmt, ...)
    local log = self:formatLog(tag, fmt, ...)
    print(log)
end

--------------------------------
-- 打印当前堆栈
-- @param string fmt 格式化标志
-- @param objects ... 参数
-- @function [parent=#Log] traceback
function Log:traceback(fmt, ...)
    self:info(fmt, ...)
    local msg = "-------------------------------------\n"
    msg = msg .. debug.traceback()
    msg = msg .. "\n------------------------------------"
    self:info("stack:%s", msg)
end


--------------------------------
-- 打印table
-- @param table t 要打印的table
-- @function [parent=#Log] showTable
function Log:showTable(t)
    local msg = json.encode(t)
    self:info(msg)
end

--------------------------------
-- dump value
-- @param object value 要dump的value值
-- @param string desciption 描述
-- @param int nesting 递归层次，默认值3
-- @function [parent=#Log] dump
function Log:dump(value, desciption, nesting)
    if type(nesting) ~= "number" then nesting = 3 end

    local lookupTable = {}
    local result = {}

    -- traceback
    self:traceback("dump traceback")

    local function dump_(value, desciption, indent, nest, keylen)
        desciption = desciption or "<var>"
        local spc = ""
        if type(keylen) == "number" then
            spc = string.rep(" ", keylen - string.len(dump_value_(desciption)))
        end
        if type(value) ~= "table" then
            result[#result +1 ] = string.format("%s%s%s = %s", indent, dump_value_(desciption), spc, dump_value_(value))
        elseif lookupTable[tostring(value)] then
            result[#result +1 ] = string.format("%s%s%s = *REF*", indent, dump_value_(desciption), spc)
        else
            lookupTable[tostring(value)] = true
            if nest > nesting then
                result[#result +1 ] = string.format("%s%s = *MAX NESTING*", indent, dump_value_(desciption))
            else
                result[#result +1 ] = string.format("%s%s = {", indent, dump_value_(desciption))
                local indent2 = indent.."    "
                local keys = {}
                local keylen = 0
                local values = {}
                for k, v in pairs(value) do
                    keys[#keys + 1] = k
                    local vk = dump_value_(k)
                    local vkl = string.len(vk)
                    if vkl > keylen then keylen = vkl end
                    values[k] = v
                end
                table.sort(keys, function(a, b)
                    if type(a) == "number" and type(b) == "number" then
                        return a < b
                    else
                        return tostring(a) < tostring(b)
                    end
                end)
                for i, k in ipairs(keys) do
                    dump_(values[k], k, indent2, nest + 1, keylen)
                end
                result[#result +1] = string.format("%s}", indent)
            end
        end
    end
    dump_(value, desciption, "- ", 1)

    for i, line in ipairs(result) do
        self:info("---------------------dump result----------------")
        self:info(line)
    end
end


return Log

