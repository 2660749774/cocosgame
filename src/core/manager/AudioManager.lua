--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2015/7/30
-- Time: 11:49
-- To change this template use File | Settings | File Templates.
-- AudioManager 音频管理器
local AudioManager = class("AudioManager")
local RandomUtil = require("core.util.RandomUtil")

local USE_AUDIO_ENGINE = 1
local USE_SIMPLE_AUDIO_ENGINE = 2

local AUDIO_ENGINE_TYPE = USE_AUDIO_ENGINE

--------------------------------
-- 构造函数
-- @function [parent=#AudioManager] ctor
function AudioManager:ctor()
    if AUDIO_ENGINE_TYPE == USE_AUDIO_ENGINE then
        self.audioEngine = ccexp.AudioEngine
        self.audioId = cc.AUDIO_INVAILD_ID
    else
        self.audioEngine = cc.SimpleAudioEngine:getInstance()
    end
    self.volume = 1
    self.index = 1
    self.randomBg = false

    self:setVolume(self.volume)
end

--------------------------------
-- 播放音效
-- @function [parent=#AudioManager] playEffect
function AudioManager:playEffect(fileName, stopAll)
    if self.audioOff then
        return
    end

    local path = "audio/" .. fileName
    log:info("play effect music %s", path)
    if AUDIO_ENGINE_TYPE == USE_SIMPLE_AUDIO_ENGINE then
        stopAll = stopAll or false
        if stopAll then
            self:stopAllEffects()
        end

        return self.audioEngine:playEffect(path, false)
    else
        self.audioEngine:play2d(path, false, self.volume)
    end
end


--------------------------------
-- 停止所有音效
-- @function [parent=#AudioManager] stopAllEffects
function AudioManager:stopAllEffects()
    if AUDIO_ENGINE_TYPE == USE_SIMPLE_AUDIO_ENGINE then
        self.audioEngine:stopAllEffects()
    end
end

--------------------------------
-- 停止所有音乐
-- @function [parent=#AudioManager] stopAll
function AudioManager:stopAll()
    if AUDIO_ENGINE_TYPE == USE_SIMPLE_AUDIO_ENGINE then
        self.audioEngine:stopAllEffects()
        self.audioEngine:stopBackgroundMusic(true)
    else
        self.audioEngine:stopAll()
    end
end

--------------------------------
-- 设置音效
-- @function [parent=#AudioManager] stopAllEffects
function AudioManager:setVolume(volume)
    if volume < 0 or volume > 1 then
        return
    end
    self.volume = volume
    if self.volume == 0 then
        self.audioOff = true
    else
        self.audioOff = false
    end

    if AUDIO_ENGINE_TYPE == USE_SIMPLE_AUDIO_ENGINE then
        self.audioEngine:setEffectsVolume(self.volume)
        self.audioEngine:setMusicVolume(self.volume * 0.3)
    elseif self.audioId ~= cc.AUDIO_INVAILD_ID then
        self.audioEngine:setVolume(self.audioId, volume * 0.3)
    end
end

--------------------------------
-- 播放背景音乐
-- @function [parent=#AudioManager] playBgMusic
function AudioManager:playBgMusic(fileList, randomBg)
    if self.audioOff then
        return
    end

    self.randomBg = randomBg or true
    self.bgFileList = fileList

    -- 选择要播放的背景音乐
    local fileName = ""
    if self.randomBg then
        fileName = self.bgFileList[RandomUtil:nextInt(#self.bgFileList)]
    else
        if self.index > #self.bgFileList then
            self.index = 1
        end
        fileName = self.bgFileList[self.index]
    end
    local path = "audio/" .. fileName
    
    -- 播放音乐
    local loop = (#self.bgFileList == 1)

    if AUDIO_ENGINE_TYPE == USE_AUDIO_ENGINE then
        -- 暂停之前的
        if self.audioId ~= cc.AUDIO_INVAILD_ID then
            self.audioEngine:stop(self.audioId)
            self.audioId = cc.AUDIO_INVAILD_ID
        end

        self.audioId = self.audioEngine:play2d(path, loop, self.volume * 0.3)
        log:info("play music %s, loop %s", path, loop)
        if self.audioId ~= cc.AUDIO_INVAILD_ID then
            -- 播放完毕切换
            self.audioEngine:setFinishCallback(self.audioId, handler(self, self.bgMusicCheck))
        else
            log:warn("play music failed, music %s, loop %s", path, loop)
        end
    else
        -- 暂停之前的
        if self.audioEngine:isMusicPlaying() then
            self.audioEngine:stopMusic(true)
        end

        self.audioEngine:playMusic(path, loop)
        log:info("play music %s, loop %s", path, loop)
        if not loop then
            -- 启动定时器切换
            self.bgMusicCheckHandler = scheduler.scheduleUpdateGlobal(handler(self, self.bgMusicCheck))
        end
    end
end

--------------------------------
-- 检测背景音乐是否播放完毕
-- @function [parent=#AudioManager] bgMusicCheck
function AudioManager:bgMusicCheck()
    if AUDIO_ENGINE_TYPE == USE_AUDIO_ENGINE then
        self.audioId = cc.AUDIO_INVAILD_ID
        self:playBgMusic(self.bgFileList, self.randomBg)
    else
        if not self.audioEngine:isMusicPlaying() then
            self.audioEngine:stopMusic(true)
        else
            return
        end
        self:playBgMusic(self.bgFileList, self.randomBg)
        scheduler.unscheduleGlobal(self.bgMusicCheckHandler)
    end
end




return AudioManager
