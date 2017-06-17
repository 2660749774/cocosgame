#include "lua_cocos2dx_httpdownload_auto.hpp"
#include "network/HTTPDownload.h"
#include "scripting/lua-bindings/manual/tolua_fix.h"
#include "scripting/lua-bindings/manual/LuaBasicConversions.h"

int lua_cocos2dx_httpdownload_HTTPDownload_getErrorCode(lua_State* tolua_S)
{
    int argc = 0;
    HTTPDownload* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"HTTPDownload",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (HTTPDownload*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_httpdownload_HTTPDownload_getErrorCode'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_cocos2dx_httpdownload_HTTPDownload_getErrorCode'", nullptr);
            return 0;
        }
        int ret = cobj->getErrorCode();
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "HTTPDownload:getErrorCode",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_httpdownload_HTTPDownload_getErrorCode'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_httpdownload_HTTPDownload_getState(lua_State* tolua_S)
{
    int argc = 0;
    HTTPDownload* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"HTTPDownload",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (HTTPDownload*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_httpdownload_HTTPDownload_getState'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_cocos2dx_httpdownload_HTTPDownload_getState'", nullptr);
            return 0;
        }
        int ret = cobj->getState();
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "HTTPDownload:getState",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_httpdownload_HTTPDownload_getState'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_httpdownload_HTTPDownload_setAcceptEncoding(lua_State* tolua_S)
{
    int argc = 0;
    HTTPDownload* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"HTTPDownload",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (HTTPDownload*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_httpdownload_HTTPDownload_setAcceptEncoding'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        int arg0;

        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0, "HTTPDownload:setAcceptEncoding");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_cocos2dx_httpdownload_HTTPDownload_setAcceptEncoding'", nullptr);
            return 0;
        }
        cobj->setAcceptEncoding(arg0);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "HTTPDownload:setAcceptEncoding",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_httpdownload_HTTPDownload_setAcceptEncoding'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_httpdownload_HTTPDownload_getResponseStatusCode(lua_State* tolua_S)
{
    int argc = 0;
    HTTPDownload* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"HTTPDownload",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (HTTPDownload*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_httpdownload_HTTPDownload_getResponseStatusCode'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_cocos2dx_httpdownload_HTTPDownload_getResponseStatusCode'", nullptr);
            return 0;
        }
        int ret = cobj->getResponseStatusCode();
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "HTTPDownload:getResponseStatusCode",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_httpdownload_HTTPDownload_getResponseStatusCode'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_httpdownload_HTTPDownload_start(lua_State* tolua_S)
{
    int argc = 0;
    HTTPDownload* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"HTTPDownload",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (HTTPDownload*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_httpdownload_HTTPDownload_start'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_cocos2dx_httpdownload_HTTPDownload_start'", nullptr);
            return 0;
        }
        bool ret = cobj->start();
        tolua_pushboolean(tolua_S,(bool)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "HTTPDownload:start",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_httpdownload_HTTPDownload_start'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_httpdownload_HTTPDownload_getErrorMessage(lua_State* tolua_S)
{
    int argc = 0;
    HTTPDownload* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"HTTPDownload",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (HTTPDownload*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_httpdownload_HTTPDownload_getErrorMessage'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_cocos2dx_httpdownload_HTTPDownload_getErrorMessage'", nullptr);
            return 0;
        }
        const std::string ret = cobj->getErrorMessage();
        tolua_pushcppstring(tolua_S,ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "HTTPDownload:getErrorMessage",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_httpdownload_HTTPDownload_getErrorMessage'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_httpdownload_HTTPDownload_setConnectTimeout(lua_State* tolua_S)
{
    int argc = 0;
    HTTPDownload* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"HTTPDownload",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (HTTPDownload*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_cocos2dx_httpdownload_HTTPDownload_setConnectTimeout'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        int arg0;

        ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0, "HTTPDownload:setConnectTimeout");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_cocos2dx_httpdownload_HTTPDownload_setConnectTimeout'", nullptr);
            return 0;
        }
        cobj->setConnectTimeout(arg0);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "HTTPDownload:setConnectTimeout",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_httpdownload_HTTPDownload_setConnectTimeout'.",&tolua_err);
#endif

    return 0;
}
int lua_cocos2dx_httpdownload_HTTPDownload_createWithUrlLua(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"HTTPDownload",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 3)
    {
		LUA_FUNCTION arg0;
        const char* arg1;
        const char* arg2;

#if COCOS2D_DEBUG >= 1
		if (!toluafix_isfunction(tolua_S, 2, "LUA_FUNCTION", 0, &tolua_err))
		{
			goto tolua_lerror;
		}
#endif
		arg0 = (toluafix_ref_function(tolua_S, 2, 0));
        // ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0, "HTTPDownload:createWithUrlLua");
        std::string arg1_tmp; ok &= luaval_to_std_string(tolua_S, 3, &arg1_tmp, "HTTPDownload:createWithUrlLua"); arg1 = arg1_tmp.c_str();
        std::string arg2_tmp; ok &= luaval_to_std_string(tolua_S, 4, &arg2_tmp, "HTTPDownload:createWithUrlLua"); arg2 = arg2_tmp.c_str();
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_cocos2dx_httpdownload_HTTPDownload_createWithUrlLua'", nullptr);
            return 0;
        }
        HTTPDownload* ret = HTTPDownload::createWithUrlLua(arg0, arg1, arg2);
        object_to_luaval<HTTPDownload>(tolua_S, "HTTPDownload",(HTTPDownload*)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "HTTPDownload:createWithUrlLua",argc, 3);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_httpdownload_HTTPDownload_createWithUrlLua'.",&tolua_err);
#endif
    return 0;
}
static int lua_cocos2dx_httpdownload_HTTPDownload_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (HTTPDownload)");
    return 0;
}

int lua_register_cocos2dx_httpdownload_HTTPDownload(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"HTTPDownload");
    tolua_cclass(tolua_S,"HTTPDownload","HTTPDownload","cc.Ref",nullptr);

    tolua_beginmodule(tolua_S,"HTTPDownload");
        tolua_function(tolua_S,"getErrorCode",lua_cocos2dx_httpdownload_HTTPDownload_getErrorCode);
        tolua_function(tolua_S,"getState",lua_cocos2dx_httpdownload_HTTPDownload_getState);
        tolua_function(tolua_S,"setAcceptEncoding",lua_cocos2dx_httpdownload_HTTPDownload_setAcceptEncoding);
        tolua_function(tolua_S,"getResponseStatusCode",lua_cocos2dx_httpdownload_HTTPDownload_getResponseStatusCode);
        tolua_function(tolua_S,"start",lua_cocos2dx_httpdownload_HTTPDownload_start);
        tolua_function(tolua_S,"getErrorMessage",lua_cocos2dx_httpdownload_HTTPDownload_getErrorMessage);
        tolua_function(tolua_S,"setConnectTimeout",lua_cocos2dx_httpdownload_HTTPDownload_setConnectTimeout);
        tolua_function(tolua_S,"createWithUrlLua", lua_cocos2dx_httpdownload_HTTPDownload_createWithUrlLua);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(HTTPDownload).name();
    g_luaType[typeName] = "HTTPDownload";
    g_typeCast["HTTPDownload"] = "HTTPDownload";
    return 1;
}
TOLUA_API int register_all_cocos2dx_httpdownload(lua_State* tolua_S)
{
	tolua_open(tolua_S);
	
	tolua_module(tolua_S,"cc",0);
	tolua_beginmodule(tolua_S,"cc");

	lua_register_cocos2dx_httpdownload_HTTPDownload(tolua_S);

	tolua_endmodule(tolua_S);
	return 1;
}

