--[[
    网络工具类
    @author wangys
]]

local WebUtil = {}

cc = cc or {}
cc.HTTP = cc.HTTP or {}

-- HTTP请求方法
cc.kCCHTTPRequestMethodGET = 0
cc.kCCHTTPRequestMethodPOST = 1

-- HTTP事件名称定义
cc.kCCHTTPRequestStateCompletedEventName = "completed"
cc.kCCHTTPRequestStateCancelledEventName = "cancelled"
cc.kCCHTTPRequestStateFailedEventName = "failed"
cc.kCCHTTPRequestStateUnknownEventName = "unknown"
cc.kCCHTTPRequestStateProgressEventName = "progress"

-- HTTP定义
cc.HTTP.GET = "GET"
cc.HTTP.POST = "POST"

cc.HTTP.StateProgress = 1
cc.HTTP.StateCompleted = 2
cc.HTTP.StateServerError = 3
cc.HTTP.StateCancelled = 4
cc.HTTP.StateFailed = 5
cc.HTTP.StateUnknown = 6

-- TAG定义
WebUtil.TAG = "HTTP"

-------------------------
-- 发送HTTP请求
-- @function [parent=#WebUtil] sendRequest
-- @param function callbock 回调函数
-- @param url string 请求URL
-- @param method string HTTP请求方式(GET|POST)
function WebUtil.sendRequest(url, callback, method)
    local request = WebUtil.createRequest(url, callback, nil, nil, method)
    request:start()
end

-------------------------
-- 发送HTTP请求
-- @function [parent=#WebUtil] sendRequest
-- @param function callbock 回调函数
-- @param url string 请求URL
-- @param params table 请求参数
-- @param method string HTTP请求方式(GET|POST)
function WebUtil.sendRequestWithData(url, callback, params, method)
    local request = WebUtil.createRequest(url, callback, nil, params, method)
    request:start()
end

-------------------------
-- 发送HTTP请求
-- @function [parent=#WebUtil] sendRequest
-- @param function callbock 回调函数
-- @param url string 请求URL
-- @param params table 请求参数
-- @param method string HTTP请求方式(GET|POST)
function WebUtil.sendRequestWithHeader(url, callback, heads, params, method)
    local request = WebUtil.createRequest(url, callback, heads, params, method)
    request:start()
end

-------------------------
-- 发送HTTP请求
-- @function [parent=#WebUtil] sendRequest
-- @param function callbock 回调函数
-- @param url string 请求URL
-- @param params table 请求参数
-- @param method string HTTP请求方式(GET|POST)
function WebUtil.sendRequestWithHost(url, callback, host, params, method)
    local request = WebUtil.createRequest(url, callback, {Host=host}, params, method)
    request:start()
end

-------------------------
-- 构建HTTP请求
-- @function [parent=#WebUtil] sendRequest
-- @param function callbock 回调函数
-- @param url string 请求URL
-- @param params table 请求参数
-- @param heads table http头信息
-- @param method string HTTP请求方式(GET|POST)
function WebUtil.createRequest(url, callback, heads, params, method)
    -- 解析请求方法
    local methodStr = "GET"
    if not method then method = "GET" end
    if string.upper(tostring(method)) == "GET" then
        url = WebUtil.buildURL(url, params)
        method = cc.kCCHTTPRequestMethodGET
    else
        methodStr = "POST"
        method = cc.kCCHTTPRequestMethodPOST
    end

    -- 创建请求
    local _wrapperFunc = WebUtil.wrapperCallback(callback)
    local request = cc.HTTPRequest:createWithUrlLua(_wrapperFunc, url, method)
    log:tag(WebUtil.TAG, "send request url:%s, method:%s", url, methodStr)
    
    -- 组装POST参数
    if method == cc.kCCHTTPRequestMethodPOST and nil ~= params then
        for key, value in pairs(params) do
            log:tag(WebUtil.TAG, "add postValue key:%s, value:%s", key, value)
            request:addPOSTValue(key, value)
        end
    end

    -- 添加Header
    if heads ~= nil then
        for name, value in pairs(heads) do
            log:tag(WebUtil.TAG, "add header name:%s, value:%s", name, value)
            request:addRequestHeader(tostring(name) .. ":" .. tostring(value))
        end
    end

   
    return request
end

-------------------------
-- 下载文件
-- @function [parent=#WebUtil] downloadFile
-- @param url string 请求URL
-- @param savePath string 保存的路径
-- @param callback function 回调函数
function WebUtil.downloadFile(url, savePath, callback)
    local _wrapperFunc = WebUtil.wrapperCallback(callback)
    log:tag(WebUtil.TAG, "send down request url:%s savePath:%s", url, savePath)
    local request = cc.HTTPDownload:createWithUrlLua(_wrapperFunc, url, savePath)
    request:start()
end


-------------------------
-- 构建URL
-- @function [parent=#WebUtil] buildURL
-- @param url string 请求URL
-- @param params table 请求参数
function WebUtil.buildURL(url, params)
    -- 参数为空
    if nil == params then
        return url
    end

    -- 拼装参数
    local param = ""
    local index = 1
    for key, value in pairs(params) do
        if index > 1 then
            param = param .. "&"
        end
        param = param .. tostring(key) .. "=" .. string.urlencode(tostring(value))
        index = index + 1
    end
    if param == "" then
        return url
    else
        return url .. "?" .. param
    end
end

-------------------------
-- 包裹callback
-- @function [parent=#WebUtil] wrapperCallback
-- @param callback function 回调函数
function WebUtil.wrapperCallback(callback)
    local _wrapperFunc = function(event)
        local data = {}
        local request = event.request
        data.request = request
        if event.name == "completed" then
            local code = request:getResponseStatusCode()
            if code ~= 200 then 
                data.state = cc.HTTP.StateServerError
                data.responseCode = request:getResponseStatusCode()
            else
                data.state = cc.HTTP.StateCompleted
            end
        elseif event.name == "progress" then
            data.state = cc.HTTP.StateProgress
            data.total = event.total
            data.dltotal = event.dltotal
        elseif event.name == "cancelled" then
            data.state = cc.HTTP.StateCancelled
            data.errorCode = request:getErrorCode()
            data.errorMessage = request:getErrorMessage()
        elseif event.name == "failed" then
            data.state = cc.HTTP.StateFailed
            data.errorCode = request:getErrorCode()
            data.errorMessage = request:getErrorMessage()
        elseif event.name == "unknown" then
            data.state = cc.HTTP.StateUnknown
            data.errorCode = request:getErrorCode()
            data.errorMessage = request:getErrorMessage()
        end

        -- 回调玩家callback
        callback(data)
    end
    return _wrapperFunc
end


return WebUtil