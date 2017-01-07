#include "lua_cocos2dx_util_auto.hpp"
#include "Util.h"
#include "scripting/lua-bindings/manual/tolua_fix.h"
#include "scripting/lua-bindings/manual/LuaBasicConversions.h"

int lua_cocos2dx_util_Util_getCurrentTime(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"Util",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 0)
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_cocos2dx_util_Util_getCurrentTime'", nullptr);
            return 0;
        }
        long long ret = Util::getCurrentTime();
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "Util:getCurrentTime",argc, 0);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_util_Util_getCurrentTime'.",&tolua_err);
#endif
    return 0;
}
static int lua_cocos2dx_util_Util_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (Util)");
    return 0;
}

int lua_register_cocos2dx_util_Util(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"Util");
    tolua_cclass(tolua_S,"Util","Util","",nullptr);

    tolua_beginmodule(tolua_S,"Util");
        tolua_function(tolua_S,"getCurrentTime", lua_cocos2dx_util_Util_getCurrentTime);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(Util).name();
    g_luaType[typeName] = "Util";
    g_typeCast["Util"] = "Util";
    return 1;
}
TOLUA_API int register_all_cocos2dx_util(lua_State* tolua_S)
{
	tolua_open(tolua_S);
	
	tolua_module(tolua_S,"cc",0);
	tolua_beginmodule(tolua_S,"cc");

	lua_register_cocos2dx_util_Util(tolua_S);

	tolua_endmodule(tolua_S);
	return 1;
}

