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
