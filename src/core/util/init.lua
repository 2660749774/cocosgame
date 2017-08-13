--- init utils package
-- @author zrong(zengrong.net)
-- Creation 2014-01-02
local utils = {}

log:info("init utils")
import(".corefunctions")
utils.ByteArray = import(".ByteArray")
utils.ByteArrayVarint = import(".ByteArrayVarint")
utils.filter = import(".filter")
utils.crypto = import(".crypto")
utils.gameArchive = import(".GameArchiveFile").new()
cc.exports.RandomUtil = import(".RandomUtil")
cc.exports.ColorUtil = import(".ColorUtil")
cc.exports.ShaderUtil = import(".ShaderUtil")
RandomUtil:init()

return utils
