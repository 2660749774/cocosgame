--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2017/6/17
-- Time: 15:02
-- To change this template use File | Settings | File Templates.
-- HotswapController 热更管理器
local HotswapController = class("HotswapController")

require "lfs"
local UserDefaultUtil = require("core.util.UserDefaultUtil")
local HotswapData = require("game.Hotswap.HotswapData")
local WebUtil = require("core.net.WebUtil")

--------------------------------
-- 构造函数
-- @function [parent=#HotswapController] ctor
function HotswapController:ctor(view, confmgr)
    -- 配置管理器
    self.confmgr = confmgr
    -- 视图信息
    self.view = view
    self.TAG = "hotswap"

    -- 当前版本信息
    self.localVersion = {}

    

    -- 当前状态
    self.state = 0

    -- 文件管理器
    self.fileUtils = cc.FileUtils:getInstance()
    -- ziputil
    self.zipUtil = cc.ZipUtil
    -- 计算md5的工具
    self.cryptoUtil = cc.CryptoUtil


    -- 动更根目录
    self.updateRootDir = self.fileUtils:getWritablePath()
    -- 动更目录
    self.updateDir = self:joinPath(self.updateRootDir, "update")
    -- 临时解压目录
    self.tempDir = self:joinPath(self.updateRootDir, "tmp")
    -- 下载目录
    self.downloadDir = self:joinPath(self.updateRootDir, "download")
    -- 重试次数
    self.retryCount = 0
    -- 是否有更新
    self.hasUpdate = false
    -- 更新信息
    self.updateInfo = nil
    -- cdn游标
    self.cdnIndex = 1

    -- test
    -- local files = self:listFiles("D:/D/Cocos/tools/ant/")
    -- log:tag(self.TAG, "list file %s", self.updateRootDir)
    -- log:showTable(files)
end

--------------------------------
-- 检查动更
-- @function [parent=#HotswapController] start
function HotswapController:start()
    log:tag(self.TAG, "checkUpdate start")

    -- 请求服务器动更信息
    self.retryCount = 0
    self:checkUpdate()
end

--------------------------------
-- 动更结束
-- @function [parent=#HotswapController] over
function HotswapController:over()
    log:tag(self.TAG, "checkUpdate end")

    app:changeScene("Login")
end

--------------------------------
-- 检查版本号
-- @function [parent=#HotswapController] checkUpdate
function HotswapController:checkUpdate()
    -- 获取本地版本号
    self:getLocalVersion()

    -- 构建参数
    local resVersion = self.localVersion.resVersion
    local clientVersion = self.localVersion.clientVersion
    local buildNo = self.localVersion.buildNo
    local game = self.confmgr.config.game
    local channelId = self.confmgr:getChannelId()
    local packType = self.localVersion.packType

    local url = self.confmgr.config.hotswapUrl
    local paramPattern = "game=%s&channelId=%s&resVersion=%s&clientVersion=%s&buildNo=%s&packType=%s"
    local param = string.format(paramPattern, game, channelId, resVersion, clientVersion, buildNo, packType)

    log:tag(self.TAG, "check update, url:%s, param:%s", url, param)

    WebUtil.sendRequest(url, handler(self, self.checkUpdateCallback), "GET")
end


--------------------------------
-- 处理版本检查回调
-- @function [parent=#HotswapController] checkUpdateCallback
function HotswapController:checkUpdateCallback(data)
    if data.state == cc.HTTP.StateProgress then
        return
    end

    if data.state ~= cc.HTTP.StateCompleted then
        log:tag(self.TAG, "check update failed, errorCode:%s, errorMessage:%s", data.errorCode, data.errorMessage)

        -- 下载失败
        self.retryCount = self.retryCount + 1
        if self.retryCount >= 3 then
            -- 检测版本信息失败
            self:over()
            return
        end

        -- 再次检查
        self:checkUpdate()
        return
    end

    --[[
        {
            "state":1,
            -- 动更
            "data":{
                "state":1,
                "tips":"动更提示消息",
                "file":"1.0.0.0/2.0.0.0",
                "cdnList":[
                    "http://res.cdn.com/game/cn_android"
                ]
                "md5":"123456",
                "fileSize":1212121
            }
            -- 推荐强更
            "data":{
                "state":2,
                "forceTips":"推荐新版本更新",
                "forceUrl":"推荐强更的地址",
                "tips":"动更提示消息",
                "file":"1.0.0.0/2.0.0.0",
                "cdnList":[
                    "http://res.cdn.com/game/cn_android"
                ]
                "md5":"123456",
                "fileSize":1212121
            }

            -- 强制强更
            "data":{
                "state":3,
                "forceTips":"推荐新版本更新",
                "forceUrl":"推荐强更的地址"
            }
        }
    ]]--

    local content = data.request:getResponseString()
    log:tag(self.TAG, "check update response:%s", content)

    local response = json.decode(content)
    if response and response.state == 1 then
        if response.data.state == 0 then
            -- 没有动更
            self:over()
        elseif response.data.state == 1 then
            -- 资源更新
            self:doResUpdate(response.data)
        elseif response.data.state == 2 then
            -- 推荐强更
            self:doClientUpdate(response.data)
        elseif response.data.state == 3 then
            -- 强制更新
            self:doClientUpdate(response.data)
        else
            -- 不正常的state
            self:over()
        end
    else
        -- 服务器异常
        self:over()
    end
end

--------------------------------
-- 获取资源更新
-- @function [parent=#HotswapController] doResUpdate
function HotswapController:doResUpdate(data)
    --[[
        "data":{
            "state":1,
            "tips":"动更提示消息",
            "file":"1.0.0.0/2.0.0.0",
            "cdnList":[
                "http://res.cdn.com/game/cn_android"
            ]
            "md5":"123456",
            "fileSize":1212121
        }
    ]]--
    -- 存储更新信息
    log:tag(self.TAG, "doResUpdate start")
    self.updateInfo = data
    self.retryCount = 0
    self:showUpdatePopup(data.tips, data.fileSize, handler(self, self.downloadResUpdate))
end

--------------------------------
-- 下载资源更新
-- @function [parent=#HotswapController] downloadResUpdate
function HotswapController:downloadResUpdate()
    if self.cdnIndex > #self.updateInfo.cdnList then
        self.cdnIndex = 1
    end

    local url = self.updateInfo.cdnList[self.cdnList]
    url = self:getURL(url, self.updateInfo.file) 

    log:tag(self.TAG, "download resUpdate url:%s", url)
    log:tag(self.TAG, "download resUpdate cdnIndex:%s", self.cdnIndex)

    WebUtil.downloadFile(handler(self, self.downloadResUpdateCallback), url, self:joinPath(self.downloadDir, self.updateInfo.file))
end

--------------------------------
-- 下载文件回调
-- @function [parent=#HotswapController] downloadResUpdateCallback
function HotswapController:downloadResUpdateCallback(event)
    if event.name == "progress" then
        -- 更新进度
    elseif event.name ~= "completed" then
        -- 下载出错
        log:tag(self.TAG, "download resUpdate failed, errorCode:%s, errorMessage:%s", data.errorCode, data.errorMessage)

        -- 重试
        self.retryCount = self.retryCount + 1
        if self.retryCount >= 3 then
            log:info("doResUpdate end")

            -- 下载更新失败
            self:over()
            return
        end

        -- 更新cdn游标
        self.cdnIndex = self.cdnIndex + 1
        self:downloadResUpdate()
        return
    else
        log:info("doResUpdate end")

        -- 下载完成，解压文件
        self:unzipResUpdate()
    end
end

--------------------------------
-- 解压动更文件
-- @function [parent=#HotswapController] unzipResUpdate
function HotswapController:unzipResUpdate()
    log:tag(self.TAG, "unzipResUpdate start")
    local file = self:joinPath(self.downloadDir, self.updateInfo.file)

    log:tag(self.TAG, "unzip filepath:%s", file)

    -- 判断文件是否存在
    if not self.fileUtils:isFileExist(file) then
        log:tag(self.TAG, "download file not exists, file:%s", file)
        -- 重试
        self:doResUpdate(self.updateInfo)
        return
    end

    -- 校验md5
    local md5 = self.cryptoUtil:md5File(file)
    log:tag(self.TAG, "unzip filemd5:%s", md5)

    if md5 ~= self.updateInfo.md5 then
        log:tag(self.TAG, "download file md5 error, excepted:%s, actual:%s", self.updateInfo.md5, md5)
        -- 删除错误文件
        self.fileUtils:removeFile(file)
        -- 重试
        self:doResUpdate(self.updateInfo)
        return
    end

    -- 解压文件
    self.fileUtils:removeDirectory(self.tempDir)
    self.zipUtil:create(handler(self, self.unZipCallback), file, self.tempDir)
end

--------------------------------
-- 解压文件回调
-- @function [parent=#HotswapController] unZipCallback
function HotswapController:unZipCallback(event)
    if event.name == "progress" then
        -- 更新进度
    elseif event.name ~= "completed" then
        -- 解压失败
        log:tag(self.TAG, "unzip file failed, errorCode:%s, errorMessage:%s", data.errorCode, data.errorMessage)
        log:tag("unzipResUpdate end")

        -- 清空临时目录
        self.fileUtils:removeDirectory(self.tempDir)
        -- 删除下载目录
        self.fileUtils:removeDirectory(self.downloadDir)

        -- 重试
        self:doResUpdate(self.updateInfo)
        return
    else
        log:tag("unzipResUpdate end")
        -- 解压成功
        self:doUnZipOver()
    end
end

--------------------------------
-- 移动文件
-- @function [parent=#HotswapController] doUnZipOver
function HotswapController:doUnZipOver()
    log:tag(self.TAG, "moving resUpdate start")
    -- 标记正在移动资源
    UserDefaultUtil.setStringForKey(HotswapData.version.resMoveKey, "true")

    -- 临时目录资源拷贝到正式目录
    local files = self:listFiles(self.tempDir)
    for _, file in pairs(files) do
        local destFile = self:joinPath(self.updateDir, string.sub(file.path, string.len(self.tempDir)))
        log:info("move file src:%s, dest:%s", file.path, destFile)
        self.fileUtils:renameFile(file.path, destFile)
    end

    -- 拷贝完成，删除临时目录
    self.fileUtils:removeDirectory(self.tempDir)

    -- 标记移动结束
    UserDefaultUtil.setStringForKey(HotswapData.version.resMoveKey, "false")

    -- 更新资源版本号
    UserDefaultUtil.setStringForKey(HotswapData.version.resKey, self.updateInfo.version)
    UserDefaultUtil.setStringForKey(HotswapData.version.resDir, self.updateDir)

    log:tag(self.TAG, "moving resUpdate end")

    -- 添加搜索路径
    self.fileUtils:addSearchPath(self.updateDir, true)
    
    -- 再次检查更新
    self:cleanup()
    self:checkUpdate()
end

--------------------------------
-- 清理动更残留
-- @function [parent=#HotswapController] cleanup
function HotswapController:cleanup()
    log:tag(self.TAG, "cleanup start")
    -- 移除临时目录
    self.fileUtils:removeDirectory(self.tempDir)

    -- 移除下载目录
    self.fileUtils:removeDirectory(self.downloadDir)

    -- 重置临时变量
    self.retryCount = 0
    log:tag(self.TAG, "cleanup end")
end

--------------------------------
-- 弹出动更提示框
-- @function [parent=#HotswapController] getLocalVersion
function HotswapController:showUpdatePopup(tips, fileSize, callback)
    if self.view then
        self.view:showUpdatePopup(tips, fileSize, callback)
    else
        callback()
    end
end

--------------------------------
-- 获取本地版本号
-- @function [parent=#HotswapController] getLocalVersion
function HotswapController:getLocalVersion()
    log:tag(self.TAG, "getLocalVersion")
    -- 获取底包版本号
    local originVersion = require("game.version")

    log:tag(self.TAG, "底包资源版本号:%s", originVersion.resVersion)
    log:tag(self.TAG, "底包客户端版本号:%s", originVersion.clientVersion)
    log:tag(self.TAG, "底包编译版本号:%s", originVersion.buildNo)
    log:tag(self.TAG, "底包类型:%s", originVersion.packType)

    -- 获取资源版本号
    local resVersion = UserDefaultUtil.getStringForKey(HotswapData.version.resKey, "")
    if resVersion == "" then
        resVersion = originVersion.resVersion
        UserDefaultUtil.setStringForKey(HotswapData.version.resKey, resVersion)
    end

    -- 获取客户端版本号
    local clientVersion = UserDefaultUtil.getStringForKey(HotswapData.version.clientKey, "")
    if clientVersion == "" then
        clientVersion = originVersion.clientVersion
        UserDefaultUtil.setStringForKey(HotswapData.version.clientKey, clientVersion)
    end
    clientVersion = originVersion.clientVersion

    -- 获取底包类型
    local packType = UserDefaultUtil.getStringForKey(HotswapData.version.packType, "")
    if packType == "" then
        packType = originVersion.packType
        UserDefaultUtil.setStringForKey(HotswapData.version.packType, packType)
    end

    log:tag(self.TAG, "当前资源版本号:%s", resVersion)
    log:tag(self.TAG, "当前包类型:%s", packType)


    self.localVersion = {resVersion = resVersion, clientVersion = clientVersion, buildNo = originVersion.buildNo, packType = packType}
end

--------------------------------
-- 清除缓存重新载入模块
-- @function [parent=#HotswapController] reloadModule
function HotswapController:reloadModule(moduleName)
    if package.loaded[moduleName] ~= nil then
        package.loaded[moduleName] = nil
    end
    return require(moduleName)
end

--------------------------------
-- 获取URL
-- @function [parent=#HotswapController] getURL
function HotswapController:getURL(rootUrl, value)
    if string.endwith(rootUrl, "/") then
        return rootUrl .. value
    else
        return rootUrl .. "/" .. value
    end
end

--------------------------------
-- 获取文件路径
-- @function [parent=#HotswapController] joinPath
function HotswapController:joinPath(root, path)
    if string.endwith(root, "/") then
        return root .. path
    else
        return root .. "/" .. path
    end
end

--------------------------------
-- 获取指定目录下所有文件
-- @function [parent=#HotswapController] listFiles
function HotswapController:listFiles(rootPath, files)
    files = files or {}  
    for entry in lfs.dir(rootPath) do  
        if entry ~= '.' and entry ~= '..' then  
            local path = self:joinPath(rootPath, entry)  
            local attr = lfs.attributes(path)  
            if attr ~= nil then
                if attr.mode == 'directory' then  
                    self:listFiles(path, files)  
                else  
                    table.insert(files, {path=path, filename=entry})  
                end  
            end
        end  
    end  
    return files
end


return HotswapController