--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2017/1/2
-- Time: 12:28
-- To change this template use File | Settings | File Templates.
-- init 用来初始化该模块

-- 常量定义
require "game.Data.Constants"

-- 初始化Actions
require "game.Net.Actions"

-- model manager
cc.exports.mmgr = require("game.Common.ModelManager").new()
-- config manager
cc.exports.confmgr = require("game.Common.ConfigManager").new("")

-- 申明全局Tips
cc.exports.Tips = require "game.Common.Tips"





