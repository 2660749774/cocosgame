-- Date: 2016/6/4
-- Time: 13:09
-- To change this template use File | Settings | File Templates.
-- ModelManager model管理器
local ModelManager = class("ModelManager")

--------------------------------
-- 构造函数
-- @function [parent=#ModelManager] ctor
function ModelManager:ctor()
end

--------------------------------
-- 处理玩家数据更新
-- @function [parent=#ModelManager] handlePlayerUpdate
function ModelManager:handlePlayerUpdate(response)
    self.player:update(response.data.update)
end

return ModelManager
