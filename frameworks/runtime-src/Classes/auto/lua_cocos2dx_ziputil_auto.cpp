#include "lua_cocos2dx_ziputil_auto.hpp"
#include "util/ZipUtil.h"
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

int lua_cocos2dx_ziputil_ZipUtil_getErrorCode(lua_State* tolua_S)
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
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_ziputil_ZipUtil_getErrorCode'", nullptr);
        return 0;
    }
#endif
    
    argc = lua_gettop(tolua_S)-1;
    if (argc == 0)
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_cocos2dx_ziputil_ZipUtil_getErrorCode'", nullptr);
            return 0;
        }
        int ret = cobj->getErrorCode();
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "ZipUtil:getErrorCode",argc, 0);
    return 0;
    
#if COCOS2D_DEBUG >= 1
tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_ziputil_ZipUtil_getErrorCode'.",&tolua_err);
#endif
    
    return 0;
}
int lua_cocos2dx_ziputil_ZipUtil_getState(lua_State* tolua_S)
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
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_ziputil_ZipUtil_getState'", nullptr);
        return 0;
    }
#endif
    
    argc = lua_gettop(tolua_S)-1;
    if (argc == 0)
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_cocos2dx_ziputil_ZipUtil_getState'", nullptr);
            return 0;
        }
        int ret = cobj->getState();
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "ZipUtil:getState",argc, 0);
    return 0;
    
#if COCOS2D_DEBUG >= 1
tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_ziputil_ZipUtil_getState'.",&tolua_err);
#endif
    
    return 0;
}
int lua_cocos2dx_ziputil_ZipUtil_getErrorMessage(lua_State* tolua_S)
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
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_ziputil_ZipUtil_getErrorMessage'", nullptr);
        return 0;
    }
#endif
    
    argc = lua_gettop(tolua_S)-1;
    if (argc == 0)
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_cocos2dx_ziputil_ZipUtil_getErrorMessage'", nullptr);
            return 0;
        }
        const std::string ret = cobj->getErrorMessage();
        tolua_pushcppstring(tolua_S,ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "ZipUtil:getErrorMessage",argc, 0);
    return 0;
    
#if COCOS2D_DEBUG >= 1
tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_ziputil_ZipUtil_getErrorMessage'.",&tolua_err);
#endif
    
    return 0;
}
int lua_cocos2dx_ziputil_ZipUtil_createWithLua(lua_State* tolua_S)
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
        LUA_FUNCTION arg0;
        std::string arg1;
        std::string arg2;
        
#if COCOS2D_DEBUG >= 1
        if (!toluafix_isfunction(tolua_S, 2, "LUA_FUNCTION", 0, &tolua_err))
        {
            goto tolua_lerror;
        }
#endif
        arg0 = (toluafix_ref_function(tolua_S, 2, 0));
//        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0, "ZipUtil:createWithLua");
        ok &= luaval_to_std_string(tolua_S, 3,&arg1, "ZipUtil:createWithLua");
        ok &= luaval_to_std_string(tolua_S, 4,&arg2, "ZipUtil:createWithLua");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_cocos2dx_ziputil_ZipUtil_createWithLua'", nullptr);
            return 0;
        }
        ZipUtil* ret = ZipUtil::createWithLua(arg0, arg1, arg2);
        object_to_luaval<ZipUtil>(tolua_S, "ZipUtil",(ZipUtil*)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "ZipUtil:createWithLua",argc, 3);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_ziputil_ZipUtil_createWithLua'.",&tolua_err);
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
        tolua_function(tolua_S,"decompress",lua_cocos2dx_ziputil_ZipUtil_decompress);
        tolua_function(tolua_S,"getErrorCode",lua_cocos2dx_ziputil_ZipUtil_getErrorCode);
        tolua_function(tolua_S,"getState",lua_cocos2dx_ziputil_ZipUtil_getState);
        tolua_function(tolua_S,"getErrorMessage",lua_cocos2dx_ziputil_ZipUtil_getErrorMessage);
        tolua_function(tolua_S,"createWithLua", lua_cocos2dx_ziputil_ZipUtil_createWithLua);
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

