local Test = {}

function Test.testHttpDownload()
    -- Test下载文件
    local request = cc.HTTPDownload:createWithUrlLua(function(event) 
            local request = event.request
            log:info("event name:%s, request:%s", event.name, request)
            if event.name == "progress" then
                log:info("progress total = %s dltotal = %s", event.total, event.dltotal)
            end
        end, "http://192.168.1.4:81/officesp2010-kb2687455-fullfile-x86-zh-cn.exe", "/Workspace/bb.exe")
    request:start()
end

function Test.testunzip()
    -- Test解压文件
    local zip = cc.ZipUtil:createWithLua(function(event)
        local util = event.zipUtil
        log:info("event name:%s, util:%s", event.name, util)
        if event.name == "progress" then
            log:info("progress total = %s dltotal = %s", event.total, event.uctotal)
        end
    end, "/Users/wangys/Downloads/jldj_cn_1.0.1.75_android_20170616180237_static_dynamic.zip", "/Workspace/ziptest/")
    zip:decompress()
end

function Test.md5file()
    local md5 = cc.CryptoUtil:md5File("/Users/wangys/Downloads/jldj_cn_1.0.1.75_android_20170616180237_static_dynamic.zip")
    log:info("file md5 %s", md5)
end

return Test