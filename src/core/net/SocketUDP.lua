--
-- Created by IntelliJ IDEA.
-- User: wangys
-- Date: 2016/3/5
-- Time: 11:49
-- To change this template use File | Settings | File Templates.
-- SocketUDP SocketUDP支持UDP

local socket = require "socket"
local kcp = require "kcp"
local kcputil = require "kcputil"

local SocketUDP = class("SocketUDP")

-- 常量定义
SocketUDP.EVENT_DATA = "SOCKET_UDP_DATA"
SocketUDP.EVENT_CLOSE = "SOCKET_UDP_CLOSE"
SocketUDP.EVENT_CONNECTED = "SOCKET_UDP_CONNECTED"

SocketUDP._VERSION = socket._VERSION
SocketUDP._DEBUG = socket._DEBUG

--------------------------------
-- 构造函数
-- @function [parent=#SocketUDP] connect
function SocketUDP:ctor()
	--cc(self):addComponent("components.behavior.EventProtocol"):exportMethods()
    self.host = __host
    self.port = __port
	self.name = 'SocketUDP'
	self.udp = nil
	self.kcp = nil
	self.tickHandler = nil
	self.isConnected = false
	
    cc.bind(self, "event")
end

--------------------------------
-- 连接指定socket
-- @function [parent=#SocketUDP] connect
function SocketUDP:connect(__conv, __host, __port)
	if __conv then self.conv = __conv end
	if __host then self.host = __host end
	if __port then self.port = __port end

	assert(self.host or self.port, "Host and port are necessary!")
	assert(self.conv, "conv ar necessary!")

	--printInfo("%s.connect(%s, %d)", self.name, self.host, self.port)
	self.udp = socket.udp()
	self.udp:setpeername(self.host, self.port)
	self.udp:settimeout(0)

	-- init kcp 设置最大收发窗口为128
	self.kcp = kcp.lkcp_create(self.conv, handler(self, self._rawsend))
	self.kcp:lkcp_wndsize(128, 128)
	--第一个参数 启动快速模式
	--第二个参数 nodelay-启用以后若干常规加速将启动
	--第三个参数 interval为内部处理时钟，默认设置为 10ms
	--第四个参数 resend为快速重传指标，设置为2
	--第五个参数 为是否禁用常规流控，这里禁止
	self.kcp:lkcp_nodelay(1, 10, 2, 1)

	self.tickHandler = scheduler.scheduleUpdateGlobal(handler(self, self._tick))
	self.isConnected = true
	-- self.seq_map = {}
	-- self.seq = 1

	self:dispatchEvent({name=SocketUDP.EVENT_CONNECTED})
end

--------------------------------
-- 发送数据，发送给KCP
-- @function [parent=#SocketUDP] send
function SocketUDP:send(data)
	if self.kcp then
		self.kcp:lkcp_send(data)

		-- table.insert(self.seq_map, self.seq)
		
		-- 记录延迟
        -- actions.recordDelay(self.seq, "kcpsend", cc.Util:getCurrentTime())

		-- self.seq = self.seq + 1
	end
end

--------------------------------
-- 关闭连接
-- @function [parent=#SocketUDP] close
function SocketUDP:close()
	if self.udp then
		self.udp:close()
	end
	if self.tickHandler then
		scheduler.unscheduleGlobal(self.tickHandler)
	end
	self.isConnected = false
	self:dispatchEvent({name=SocketUDP.EVENT_CLOSE})
end

--------------------------------
-- 定时tick
-- 1. 从socket接受数据
-- 2. tick kcp
-- 3. 从kcp接受数据
-- @function [parent=#SocketUDP] _tick
function SocketUDP:_tick()
	-- 接受数据
	local data, error = self.udp:receive()
	if data then
		self.kcp:lkcp_input(data)
	end

	-- recv data
	local dataLen, data = self.kcp:lkcp_recv()
	if dataLen > 0 then
		self:dispatchEvent({name=SocketUDP.EVENT_DATA, data=data})
	end

	-- update
	local currTime = cc.Util:getCurrentTime()
	local nextUpdateTime = self.kcp:lkcp_check(currTime)
	local diff = nextUpdateTime - currTime 
	if diff <= 0 then
		self.kcp:lkcp_update(currTime)
	end
end

--------------------------------
-- 发送数据
-- @function [parent=#SocketUDP] _rawsend
function SocketUDP:_rawsend(buf)
	if self.udp then
		self.udp:send(buf)

		-- local seq = table.remove(self.seq_map)

		-- 记录延迟
        -- actions.recordDelay(seq, "rawsend", cc.Util:getCurrentTime())
	end
end

return SocketUDP
