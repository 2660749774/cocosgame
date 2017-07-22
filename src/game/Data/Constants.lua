-- 资源相关
Resource = {}

-- plist
Resource.plist = {}
Resource.plist.pack = "res/pack.plist"               -- 打包测试资源
Resource.plist.common = "ui/plist/common.plist"      -- 公用资源
Resource.plist.main = "ui/plist/main.plist"          -- 主页资源
Resource.plist.power = "ui/plist/singlematch.plist"  -- 副本资源

-- 资源分组
Resource.group = {}
Resource.group.common = "common" -- 公用资源，永不卸载
Resource.group.scene = "scene" -- 场景资源，随场景切换卸载
Resource.group.panel = "panel" -- 面板资源，随面板关闭卸载

-- 常量
-- 生命恢复时间
Constants = {}
-- 30分钟恢复一点
Constants.RECOVERLIFE_INTERVAL = 30 * 60
-- 最大生命数
Constants.MAX_LIFES = 5