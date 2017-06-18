#include "scripting/lua-bindings/auto/lua_cocos2dx_ziputil_auto.hpp"
#include "ZipUtil.h"
#include "scripting/lua-bindings/manual/tolua_fix.h"
#include "scripting/lua-bindings/manual/LuaBasicConversions.h"

int lua_cocos2dx_ziputil_ZipUtil_decompressAsync(lua_State* tolua_S)
{
    int argc = 0;
    ZipUtil* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"ZipUtil",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (ZipUtil*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_ziputil_ZipUtil_decompressAsync'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_cocos2dx_ziputil_ZipUtil_decompressAsync'", nullptr);
            return 0;
        }
        bool ret = cobj->decompressAsync();
        tolua_pushboolean(tolua_S,(bool)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "ZipUtil:decompressAsync",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_ziputil_ZipUtil_decompressAsync'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_ziputil_ZipUtil_update(lua_State* tolua_S)
{
    int argc = 0;
    ZipUtil* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"ZipUtil",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (ZipUtil*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_ziputil_ZipUtil_update'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        double arg0;

        ok &= luaval_to_number(tolua_S, 2,&arg0, "ZipUtil:update");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_cocos2dx_ziputil_ZipUtil_update'", nullptr);
            return 0;
        }
        cobj->update(arg0);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "ZipUtil:update",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_ziputil_ZipUtil_update'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_ziputil_ZipUtil_decompress(lua_State* tolua_S)
{
    int argc = 0;
    ZipUtil* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"ZipUtil",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (ZipUtil*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_ziputil_ZipUtil_decompress'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_cocos2dx_ziputil_ZipUtil_decompress'", nullptr);
            return 0;
        }
        bool ret = cobj->decompress();
        tolua_pushboolean(tolua_S,(bool)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "ZipUtil:decompress",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_ziputil_ZipUtil_decompress'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_ziputil_ZipUtil_createWithUrlLua(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"ZipUtil",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 3)
    {
        int arg0;
        std::string arg1;
        std::string arg2;
        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0, "ZipUtil:createWithUrlLua");
        ok &= luaval_to_std_string(tolua_S, 3,&arg1, "ZipUtil:createWithUrlLua");
        ok &= luaval_to_std_string(tolua_S, 4,&arg2, "ZipUtil:createWithUrlLua");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_cocos2dx_ziputil_ZipUtil_createWithUrlLua'", nullptr);
            return 0;
        }
        ZipUtil* ret = ZipUtil::createWithUrlLua(arg0, arg1, arg2);
        object_to_luaval<ZipUtil>(tolua_S, "ZipUtil",(ZipUtil*)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "ZipUtil:createWithUrlLua",argc, 3);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_ziputil_ZipUtil_createWithUrlLua'.",&tolua_err);
#endif
    return 0;
}
static int lua_cocos2dx_ziputil_ZipUtil_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (ZipUtil)");
    return 0;
}

int lua_register_cocos2dx_ziputil_ZipUtil(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"ZipUtil");
    tolua_cclass(tolua_S,"ZipUtil","ZipUtil","cc.Ref",nullptr);

    tolua_beginmodule(tolua_S,"ZipUtil");
        tolua_function(tolua_S,"decompressAsync",lua_cocos2dx_ziputil_ZipUtil_decompressAsync);
        tolua_function(tolua_S,"update",lua_cocos2dx_ziputil_ZipUtil_update);
        tolua_function(tolua_S,"decompress",lua_cocos2dx_ziputil_ZipUtil_decompress);
        tolua_function(tolua_S,"createWithUrlLua", lua_cocos2dx_ziputil_ZipUtil_createWithUrlLua);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(ZipUtil).name();
    g_luaType[typeName] = "ZipUtil";
    g_typeCast["ZipUtil"] = "ZipUtil";
    return 1;
}
TOLUA_API int register_all_cocos2dx_ziputil(lua_State* tolua_S)
{
	tolua_open(tolua_S);
	
	tolua_module(tolua_S,"cc",0);
	tolua_beginmodule(tolua_S,"cc");

	lua_register_cocos2dx_ziputil_ZipUtil(tolua_S);

	tolua_endmodule(tolua_S);
	return 1;
}

