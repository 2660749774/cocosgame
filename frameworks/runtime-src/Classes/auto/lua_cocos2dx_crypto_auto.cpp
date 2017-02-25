#include "scripting/lua-bindings/auto/lua_cocos2dx_crypto_auto.hpp"
#include "CryptoUtil.h"
#include "scripting/lua-bindings/manual/tolua_fix.h"
#include "scripting/lua-bindings/manual/LuaBasicConversions.h"
TOLUA_API int register_all_cocos2dx_crypto(lua_State* tolua_S)
{
	tolua_open(tolua_S);
	
	tolua_module(tolua_S,"cc",0);
	tolua_beginmodule(tolua_S,"cc");


	tolua_endmodule(tolua_S);
	return 1;
}

