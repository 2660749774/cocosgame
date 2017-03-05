--- init net package
-- @author zrong(zengrong.net)
-- Creation 2014-01-02
local net = {}

net.SocketTCP = import(".SocketTCP")
net.SocketUDP = import(".SocketUDP")
net.WebUtil = import(".WebUtil")

return net
