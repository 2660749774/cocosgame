#include "lua_cocos2dx_httprequest_auto.hpp"
#include "network/CCHTTPRequest.h"
#include "scripting/lua-bindings/manual/tolua_fix.h"
#include "scripting/lua-bindings/manual/LuaBasicConversions.h"

int lua_cocos2dx_httprequest_HTTPRequest_setCookieString(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::extra::HTTPRequest* cobj = nullptr;
    bool ok = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S, 1, "cc.HTTPRequest", 0, &tolua_err)) goto tolua_lerror;
#endif

    cobj = (cocos2d::extra::HTTPRequest*)tolua_tousertype(tolua_S, 1, 0);

#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S, "invalid 'cobj' in function 'lua_cocos2dx_httprequest_HTTPRequest_setCookieString'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S) - 1;
    if (argc == 1)
    {
        const char* arg0;

        std::string arg0_tmp; ok &= luaval_to_std_string(tolua_S, 2, &arg0_tmp, "cc.HTTPRequest:setCookieString"); arg0 = arg0_tmp.c_str();
        if (!ok)
        {
            tolua_error(tolua_S, "invalid arguments in function 'lua_cocos2dx_httprequest_HTTPRequest_setCookieString'", nullptr);
            return 0;
        }
        cobj->setCookieString(arg0);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "cc.HTTPRequest:setCookieString", argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
                tolua_error(tolua_S, "#ferror in function 'lua_cocos2dx_httprequest_HTTPRequest_setCookieString'.", &tolua_err);
#endif

                return 0;
}
int lua_cocos2dx_httprequest_HTTPRequest_getResponseString(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::extra::HTTPRequest* cobj = nullptr;
    bool ok = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S, 1, "cc.HTTPRequest", 0, &tolua_err)) goto tolua_lerror;
#endif

    cobj = (cocos2d::extra::HTTPRequest*)tolua_tousertype(tolua_S, 1, 0);

#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S, "invalid 'cobj' in function 'lua_cocos2dx_httprequest_HTTPRequest_getResponseString'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S) - 1;
    if (argc == 0)
    {
        if (!ok)
        {
            tolua_error(tolua_S, "invalid arguments in function 'lua_cocos2dx_httprequest_HTTPRequest_getResponseString'", nullptr);
            return 0;
        }
        const std::string ret = cobj->getResponseString();
        tolua_pushcppstring(tolua_S, ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "cc.HTTPRequest:getResponseString", argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
                tolua_error(tolua_S, "#ferror in function 'lua_cocos2dx_httprequest_HTTPRequest_getResponseString'.", &tolua_err);
#endif

                return 0;
}
int lua_cocos2dx_httprequest_HTTPRequest_addFormContents(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::extra::HTTPRequest* cobj = nullptr;
    bool ok = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S, 1, "cc.HTTPRequest", 0, &tolua_err)) goto tolua_lerror;
#endif

    cobj = (cocos2d::extra::HTTPRequest*)tolua_tousertype(tolua_S, 1, 0);

#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S, "invalid 'cobj' in function 'lua_cocos2dx_httprequest_HTTPRequest_addFormContents'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S) - 1;
    if (argc == 2)
    {
        const char* arg0;
        const char* arg1;

        std::string arg0_tmp; ok &= luaval_to_std_string(tolua_S, 2, &arg0_tmp, "cc.HTTPRequest:addFormContents"); arg0 = arg0_tmp.c_str();

        std::string arg1_tmp; ok &= luaval_to_std_string(tolua_S, 3, &arg1_tmp, "cc.HTTPRequest:addFormContents"); arg1 = arg1_tmp.c_str();
        if (!ok)
        {
            tolua_error(tolua_S, "invalid arguments in function 'lua_cocos2dx_httprequest_HTTPRequest_addFormContents'", nullptr);
            return 0;
        }
        cobj->addFormContents(arg0, arg1);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "cc.HTTPRequest:addFormContents", argc, 2);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
                tolua_error(tolua_S, "#ferror in function 'lua_cocos2dx_httprequest_HTTPRequest_addFormContents'.", &tolua_err);
#endif

                return 0;
}
int lua_cocos2dx_httprequest_HTTPRequest_getResponseStatusCode(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::extra::HTTPRequest* cobj = nullptr;
    bool ok = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S, 1, "cc.HTTPRequest", 0, &tolua_err)) goto tolua_lerror;
#endif

    cobj = (cocos2d::extra::HTTPRequest*)tolua_tousertype(tolua_S, 1, 0);

#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S, "invalid 'cobj' in function 'lua_cocos2dx_httprequest_HTTPRequest_getResponseStatusCode'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S) - 1;
    if (argc == 0)
    {
        if (!ok)
        {
            tolua_error(tolua_S, "invalid arguments in function 'lua_cocos2dx_httprequest_HTTPRequest_getResponseStatusCode'", nullptr);
            return 0;
        }
        int ret = cobj->getResponseStatusCode();
        tolua_pushnumber(tolua_S, (lua_Number)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "cc.HTTPRequest:getResponseStatusCode", argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
                tolua_error(tolua_S, "#ferror in function 'lua_cocos2dx_httprequest_HTTPRequest_getResponseStatusCode'.", &tolua_err);
#endif

                return 0;
}
int lua_cocos2dx_httprequest_HTTPRequest_cancel(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::extra::HTTPRequest* cobj = nullptr;
    bool ok = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S, 1, "cc.HTTPRequest", 0, &tolua_err)) goto tolua_lerror;
#endif

    cobj = (cocos2d::extra::HTTPRequest*)tolua_tousertype(tolua_S, 1, 0);

#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S, "invalid 'cobj' in function 'lua_cocos2dx_httprequest_HTTPRequest_cancel'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S) - 1;
    if (argc == 0)
    {
        if (!ok)
        {
            tolua_error(tolua_S, "invalid arguments in function 'lua_cocos2dx_httprequest_HTTPRequest_cancel'", nullptr);
            return 0;
        }
        cobj->cancel();
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "cc.HTTPRequest:cancel", argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
                tolua_error(tolua_S, "#ferror in function 'lua_cocos2dx_httprequest_HTTPRequest_cancel'.", &tolua_err);
#endif

                return 0;
}
int lua_cocos2dx_httprequest_HTTPRequest_getResponseHeaders(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::extra::HTTPRequest* cobj = nullptr;
    bool ok = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S, 1, "cc.HTTPRequest", 0, &tolua_err)) goto tolua_lerror;
#endif

    cobj = (cocos2d::extra::HTTPRequest*)tolua_tousertype(tolua_S, 1, 0);

#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S, "invalid 'cobj' in function 'lua_cocos2dx_httprequest_HTTPRequest_getResponseHeaders'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S) - 1;
    if (argc == 0)
    {
        if (!ok)
        {
            tolua_error(tolua_S, "invalid arguments in function 'lua_cocos2dx_httprequest_HTTPRequest_getResponseHeaders'", nullptr);
            return 0;
        }
        const std::vector<std::string>& ret = cobj->getResponseHeaders();
        ccvector_std_string_to_luaval(tolua_S, ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "cc.HTTPRequest:getResponseHeaders", argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
                tolua_error(tolua_S, "#ferror in function 'lua_cocos2dx_httprequest_HTTPRequest_getResponseHeaders'.", &tolua_err);
#endif

                return 0;
}
int lua_cocos2dx_httprequest_HTTPRequest_getResponseDataLength(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::extra::HTTPRequest* cobj = nullptr;
    bool ok = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S, 1, "cc.HTTPRequest", 0, &tolua_err)) goto tolua_lerror;
#endif

    cobj = (cocos2d::extra::HTTPRequest*)tolua_tousertype(tolua_S, 1, 0);

#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S, "invalid 'cobj' in function 'lua_cocos2dx_httprequest_HTTPRequest_getResponseDataLength'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S) - 1;
    if (argc == 0)
    {
        if (!ok)
        {
            tolua_error(tolua_S, "invalid arguments in function 'lua_cocos2dx_httprequest_HTTPRequest_getResponseDataLength'", nullptr);
            return 0;
        }
        int ret = cobj->getResponseDataLength();
        tolua_pushnumber(tolua_S, (lua_Number)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "cc.HTTPRequest:getResponseDataLength", argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
                tolua_error(tolua_S, "#ferror in function 'lua_cocos2dx_httprequest_HTTPRequest_getResponseDataLength'.", &tolua_err);
#endif

                return 0;
}
int lua_cocos2dx_httprequest_HTTPRequest_getResponseData(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::extra::HTTPRequest* cobj = nullptr;
    bool ok = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S, 1, "cc.HTTPRequest", 0, &tolua_err)) goto tolua_lerror;
#endif

    cobj = (cocos2d::extra::HTTPRequest*)tolua_tousertype(tolua_S, 1, 0);

#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S, "invalid 'cobj' in function 'lua_cocos2dx_httprequest_HTTPRequest_getResponseData'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S) - 1;
    if (argc == 0)
    {
        if (!ok)
        {
            tolua_error(tolua_S, "invalid arguments in function 'lua_cocos2dx_httprequest_HTTPRequest_getResponseData'", nullptr);
            return 0;
        }
        void* ret = cobj->getResponseData();
#pragma warning NO CONVERSION FROM NATIVE FOR void*;
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "cc.HTTPRequest:getResponseData", argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
                tolua_error(tolua_S, "#ferror in function 'lua_cocos2dx_httprequest_HTTPRequest_getResponseData'.", &tolua_err);
#endif

                return 0;
}
int lua_cocos2dx_httprequest_HTTPRequest_checkCURLState(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::extra::HTTPRequest* cobj = nullptr;
    bool ok = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S, 1, "cc.HTTPRequest", 0, &tolua_err)) goto tolua_lerror;
#endif

    cobj = (cocos2d::extra::HTTPRequest*)tolua_tousertype(tolua_S, 1, 0);

#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S, "invalid 'cobj' in function 'lua_cocos2dx_httprequest_HTTPRequest_checkCURLState'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S) - 1;
    if (argc == 1)
    {
        double arg0;

        ok &= luaval_to_number(tolua_S, 2, &arg0, "cc.HTTPRequest:checkCURLState");
        if (!ok)
        {
            tolua_error(tolua_S, "invalid arguments in function 'lua_cocos2dx_httprequest_HTTPRequest_checkCURLState'", nullptr);
            return 0;
        }
        cobj->checkCURLState(arg0);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "cc.HTTPRequest:checkCURLState", argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
                tolua_error(tolua_S, "#ferror in function 'lua_cocos2dx_httprequest_HTTPRequest_checkCURLState'.", &tolua_err);
#endif

                return 0;
}
int lua_cocos2dx_httprequest_HTTPRequest_setAcceptEncoding(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::extra::HTTPRequest* cobj = nullptr;
    bool ok = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S, 1, "cc.HTTPRequest", 0, &tolua_err)) goto tolua_lerror;
#endif

    cobj = (cocos2d::extra::HTTPRequest*)tolua_tousertype(tolua_S, 1, 0);

#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S, "invalid 'cobj' in function 'lua_cocos2dx_httprequest_HTTPRequest_setAcceptEncoding'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S) - 1;
    if (argc == 1)
    {
        int arg0;

        ok &= luaval_to_int32(tolua_S, 2, (int *)&arg0, "cc.HTTPRequest:setAcceptEncoding");
        if (!ok)
        {
            tolua_error(tolua_S, "invalid arguments in function 'lua_cocos2dx_httprequest_HTTPRequest_setAcceptEncoding'", nullptr);
            return 0;
        }
        cobj->setAcceptEncoding(arg0);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "cc.HTTPRequest:setAcceptEncoding", argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
                tolua_error(tolua_S, "#ferror in function 'lua_cocos2dx_httprequest_HTTPRequest_setAcceptEncoding'.", &tolua_err);
#endif

                return 0;
}
int lua_cocos2dx_httprequest_HTTPRequest_getDelegate(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::extra::HTTPRequest* cobj = nullptr;
    bool ok = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S, 1, "cc.HTTPRequest", 0, &tolua_err)) goto tolua_lerror;
#endif

    cobj = (cocos2d::extra::HTTPRequest*)tolua_tousertype(tolua_S, 1, 0);

#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S, "invalid 'cobj' in function 'lua_cocos2dx_httprequest_HTTPRequest_getDelegate'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S) - 1;
    if (argc == 0)
    {
        if (!ok)
        {
            tolua_error(tolua_S, "invalid arguments in function 'lua_cocos2dx_httprequest_HTTPRequest_getDelegate'", nullptr);
            return 0;
        }
        cocos2d::extra::HTTPRequestDelegate* ret = cobj->getDelegate();
        object_to_luaval<cocos2d::extra::HTTPRequestDelegate>(tolua_S, "cc.HTTPRequestDelegate", (cocos2d::extra::HTTPRequestDelegate*)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "cc.HTTPRequest:getDelegate", argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
                tolua_error(tolua_S, "#ferror in function 'lua_cocos2dx_httprequest_HTTPRequest_getDelegate'.", &tolua_err);
#endif

                return 0;
}
int lua_cocos2dx_httprequest_HTTPRequest_start(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::extra::HTTPRequest* cobj = nullptr;
    bool ok = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S, 1, "cc.HTTPRequest", 0, &tolua_err)) goto tolua_lerror;
#endif

    cobj = (cocos2d::extra::HTTPRequest*)tolua_tousertype(tolua_S, 1, 0);

#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S, "invalid 'cobj' in function 'lua_cocos2dx_httprequest_HTTPRequest_start'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S) - 1;
    if (argc == 0)
    {
        if (!ok)
        {
            tolua_error(tolua_S, "invalid arguments in function 'lua_cocos2dx_httprequest_HTTPRequest_start'", nullptr);
            return 0;
        }
        bool ret = cobj->start();
        tolua_pushboolean(tolua_S, (bool)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "cc.HTTPRequest:start", argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
                tolua_error(tolua_S, "#ferror in function 'lua_cocos2dx_httprequest_HTTPRequest_start'.", &tolua_err);
#endif

                return 0;
}
int lua_cocos2dx_httprequest_HTTPRequest_getErrorCode(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::extra::HTTPRequest* cobj = nullptr;
    bool ok = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S, 1, "cc.HTTPRequest", 0, &tolua_err)) goto tolua_lerror;
#endif

    cobj = (cocos2d::extra::HTTPRequest*)tolua_tousertype(tolua_S, 1, 0);

#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S, "invalid 'cobj' in function 'lua_cocos2dx_httprequest_HTTPRequest_getErrorCode'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S) - 1;
    if (argc == 0)
    {
        if (!ok)
        {
            tolua_error(tolua_S, "invalid arguments in function 'lua_cocos2dx_httprequest_HTTPRequest_getErrorCode'", nullptr);
            return 0;
        }
        int ret = cobj->getErrorCode();
        tolua_pushnumber(tolua_S, (lua_Number)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "cc.HTTPRequest:getErrorCode", argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
                tolua_error(tolua_S, "#ferror in function 'lua_cocos2dx_httprequest_HTTPRequest_getErrorCode'.", &tolua_err);
#endif

                return 0;
}
int lua_cocos2dx_httprequest_HTTPRequest_getState(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::extra::HTTPRequest* cobj = nullptr;
    bool ok = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S, 1, "cc.HTTPRequest", 0, &tolua_err)) goto tolua_lerror;
#endif

    cobj = (cocos2d::extra::HTTPRequest*)tolua_tousertype(tolua_S, 1, 0);

#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S, "invalid 'cobj' in function 'lua_cocos2dx_httprequest_HTTPRequest_getState'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S) - 1;
    if (argc == 0)
    {
        if (!ok)
        {
            tolua_error(tolua_S, "invalid arguments in function 'lua_cocos2dx_httprequest_HTTPRequest_getState'", nullptr);
            return 0;
        }
        int ret = cobj->getState();
        tolua_pushnumber(tolua_S, (lua_Number)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "cc.HTTPRequest:getState", argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
                tolua_error(tolua_S, "#ferror in function 'lua_cocos2dx_httprequest_HTTPRequest_getState'.", &tolua_err);
#endif

                return 0;
}
int lua_cocos2dx_httprequest_HTTPRequest_saveResponseData(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::extra::HTTPRequest* cobj = nullptr;
    bool ok = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S, 1, "cc.HTTPRequest", 0, &tolua_err)) goto tolua_lerror;
#endif

    cobj = (cocos2d::extra::HTTPRequest*)tolua_tousertype(tolua_S, 1, 0);

#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S, "invalid 'cobj' in function 'lua_cocos2dx_httprequest_HTTPRequest_saveResponseData'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S) - 1;
    if (argc == 1)
    {
        const char* arg0;

        std::string arg0_tmp; ok &= luaval_to_std_string(tolua_S, 2, &arg0_tmp, "cc.HTTPRequest:saveResponseData"); arg0 = arg0_tmp.c_str();
        if (!ok)
        {
            tolua_error(tolua_S, "invalid arguments in function 'lua_cocos2dx_httprequest_HTTPRequest_saveResponseData'", nullptr);
            return 0;
        }
        unsigned int ret = cobj->saveResponseData(arg0);
        tolua_pushnumber(tolua_S, (lua_Number)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "cc.HTTPRequest:saveResponseData", argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
                tolua_error(tolua_S, "#ferror in function 'lua_cocos2dx_httprequest_HTTPRequest_saveResponseData'.", &tolua_err);
#endif

                return 0;
}
int lua_cocos2dx_httprequest_HTTPRequest_getCookieString(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::extra::HTTPRequest* cobj = nullptr;
    bool ok = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S, 1, "cc.HTTPRequest", 0, &tolua_err)) goto tolua_lerror;
#endif

    cobj = (cocos2d::extra::HTTPRequest*)tolua_tousertype(tolua_S, 1, 0);

#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S, "invalid 'cobj' in function 'lua_cocos2dx_httprequest_HTTPRequest_getCookieString'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S) - 1;
    if (argc == 0)
    {
        if (!ok)
        {
            tolua_error(tolua_S, "invalid arguments in function 'lua_cocos2dx_httprequest_HTTPRequest_getCookieString'", nullptr);
            return 0;
        }
        const std::string ret = cobj->getCookieString();
        tolua_pushcppstring(tolua_S, ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "cc.HTTPRequest:getCookieString", argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
                tolua_error(tolua_S, "#ferror in function 'lua_cocos2dx_httprequest_HTTPRequest_getCookieString'.", &tolua_err);
#endif

                return 0;
}
int lua_cocos2dx_httprequest_HTTPRequest_update(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::extra::HTTPRequest* cobj = nullptr;
    bool ok = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S, 1, "cc.HTTPRequest", 0, &tolua_err)) goto tolua_lerror;
#endif

    cobj = (cocos2d::extra::HTTPRequest*)tolua_tousertype(tolua_S, 1, 0);

#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S, "invalid 'cobj' in function 'lua_cocos2dx_httprequest_HTTPRequest_update'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S) - 1;
    if (argc == 1)
    {
        double arg0;

        ok &= luaval_to_number(tolua_S, 2, &arg0, "cc.HTTPRequest:update");
        if (!ok)
        {
            tolua_error(tolua_S, "invalid arguments in function 'lua_cocos2dx_httprequest_HTTPRequest_update'", nullptr);
            return 0;
        }
        cobj->update(arg0);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "cc.HTTPRequest:update", argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
                tolua_error(tolua_S, "#ferror in function 'lua_cocos2dx_httprequest_HTTPRequest_update'.", &tolua_err);
#endif

                return 0;
}
int lua_cocos2dx_httprequest_HTTPRequest_getResponseHeadersString(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::extra::HTTPRequest* cobj = nullptr;
    bool ok = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S, 1, "cc.HTTPRequest", 0, &tolua_err)) goto tolua_lerror;
#endif

    cobj = (cocos2d::extra::HTTPRequest*)tolua_tousertype(tolua_S, 1, 0);

#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S, "invalid 'cobj' in function 'lua_cocos2dx_httprequest_HTTPRequest_getResponseHeadersString'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S) - 1;
    if (argc == 0)
    {
        if (!ok)
        {
            tolua_error(tolua_S, "invalid arguments in function 'lua_cocos2dx_httprequest_HTTPRequest_getResponseHeadersString'", nullptr);
            return 0;
        }
        const std::string ret = cobj->getResponseHeadersString();
        tolua_pushcppstring(tolua_S, ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "cc.HTTPRequest:getResponseHeadersString", argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
                tolua_error(tolua_S, "#ferror in function 'lua_cocos2dx_httprequest_HTTPRequest_getResponseHeadersString'.", &tolua_err);
#endif

                return 0;
}
int lua_cocos2dx_httprequest_HTTPRequest_getErrorMessage(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::extra::HTTPRequest* cobj = nullptr;
    bool ok = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S, 1, "cc.HTTPRequest", 0, &tolua_err)) goto tolua_lerror;
#endif

    cobj = (cocos2d::extra::HTTPRequest*)tolua_tousertype(tolua_S, 1, 0);

#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S, "invalid 'cobj' in function 'lua_cocos2dx_httprequest_HTTPRequest_getErrorMessage'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S) - 1;
    if (argc == 0)
    {
        if (!ok)
        {
            tolua_error(tolua_S, "invalid arguments in function 'lua_cocos2dx_httprequest_HTTPRequest_getErrorMessage'", nullptr);
            return 0;
        }
        const std::string ret = cobj->getErrorMessage();
        tolua_pushcppstring(tolua_S, ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "cc.HTTPRequest:getErrorMessage", argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
                tolua_error(tolua_S, "#ferror in function 'lua_cocos2dx_httprequest_HTTPRequest_getErrorMessage'.", &tolua_err);
#endif

                return 0;
}
int lua_cocos2dx_httprequest_HTTPRequest_getRequestUrl(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::extra::HTTPRequest* cobj = nullptr;
    bool ok = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S, 1, "cc.HTTPRequest", 0, &tolua_err)) goto tolua_lerror;
#endif

    cobj = (cocos2d::extra::HTTPRequest*)tolua_tousertype(tolua_S, 1, 0);

#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S, "invalid 'cobj' in function 'lua_cocos2dx_httprequest_HTTPRequest_getRequestUrl'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S) - 1;
    if (argc == 0)
    {
        if (!ok)
        {
            tolua_error(tolua_S, "invalid arguments in function 'lua_cocos2dx_httprequest_HTTPRequest_getRequestUrl'", nullptr);
            return 0;
        }
        const std::string ret = cobj->getRequestUrl();
        tolua_pushcppstring(tolua_S, ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "cc.HTTPRequest:getRequestUrl", argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
                tolua_error(tolua_S, "#ferror in function 'lua_cocos2dx_httprequest_HTTPRequest_getRequestUrl'.", &tolua_err);
#endif

                return 0;
}
int lua_cocos2dx_httprequest_HTTPRequest_setTimeout(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::extra::HTTPRequest* cobj = nullptr;
    bool ok = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S, 1, "cc.HTTPRequest", 0, &tolua_err)) goto tolua_lerror;
#endif

    cobj = (cocos2d::extra::HTTPRequest*)tolua_tousertype(tolua_S, 1, 0);

#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S, "invalid 'cobj' in function 'lua_cocos2dx_httprequest_HTTPRequest_setTimeout'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S) - 1;
    if (argc == 1)
    {
        int arg0;

        ok &= luaval_to_int32(tolua_S, 2, (int *)&arg0, "cc.HTTPRequest:setTimeout");
        if (!ok)
        {
            tolua_error(tolua_S, "invalid arguments in function 'lua_cocos2dx_httprequest_HTTPRequest_setTimeout'", nullptr);
            return 0;
        }
        cobj->setTimeout(arg0);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "cc.HTTPRequest:setTimeout", argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
                tolua_error(tolua_S, "#ferror in function 'lua_cocos2dx_httprequest_HTTPRequest_setTimeout'.", &tolua_err);
#endif

                return 0;
}
int lua_cocos2dx_httprequest_HTTPRequest_addPOSTValue(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::extra::HTTPRequest* cobj = nullptr;
    bool ok = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S, 1, "cc.HTTPRequest", 0, &tolua_err)) goto tolua_lerror;
#endif

    cobj = (cocos2d::extra::HTTPRequest*)tolua_tousertype(tolua_S, 1, 0);

#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S, "invalid 'cobj' in function 'lua_cocos2dx_httprequest_HTTPRequest_addPOSTValue'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S) - 1;
    if (argc == 2)
    {
        const char* arg0;
        const char* arg1;

        std::string arg0_tmp; ok &= luaval_to_std_string(tolua_S, 2, &arg0_tmp, "cc.HTTPRequest:addPOSTValue"); arg0 = arg0_tmp.c_str();

        std::string arg1_tmp; ok &= luaval_to_std_string(tolua_S, 3, &arg1_tmp, "cc.HTTPRequest:addPOSTValue"); arg1 = arg1_tmp.c_str();
        if (!ok)
        {
            tolua_error(tolua_S, "invalid arguments in function 'lua_cocos2dx_httprequest_HTTPRequest_addPOSTValue'", nullptr);
            return 0;
        }
        cobj->addPOSTValue(arg0, arg1);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "cc.HTTPRequest:addPOSTValue", argc, 2);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
                tolua_error(tolua_S, "#ferror in function 'lua_cocos2dx_httprequest_HTTPRequest_addPOSTValue'.", &tolua_err);
#endif

                return 0;
}
int lua_cocos2dx_httprequest_HTTPRequest_addRequestHeader(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::extra::HTTPRequest* cobj = nullptr;
    bool ok = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S, 1, "cc.HTTPRequest", 0, &tolua_err)) goto tolua_lerror;
#endif

    cobj = (cocos2d::extra::HTTPRequest*)tolua_tousertype(tolua_S, 1, 0);

#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S, "invalid 'cobj' in function 'lua_cocos2dx_httprequest_HTTPRequest_addRequestHeader'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S) - 1;
    if (argc == 1)
    {
        const char* arg0;

        std::string arg0_tmp; ok &= luaval_to_std_string(tolua_S, 2, &arg0_tmp, "cc.HTTPRequest:addRequestHeader"); arg0 = arg0_tmp.c_str();
        if (!ok)
        {
            tolua_error(tolua_S, "invalid arguments in function 'lua_cocos2dx_httprequest_HTTPRequest_addRequestHeader'", nullptr);
            return 0;
        }
        cobj->addRequestHeader(arg0);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "cc.HTTPRequest:addRequestHeader", argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
                tolua_error(tolua_S, "#ferror in function 'lua_cocos2dx_httprequest_HTTPRequest_addRequestHeader'.", &tolua_err);
#endif

                return 0;
}
int lua_cocos2dx_httprequest_HTTPRequest_setPOSTData(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::extra::HTTPRequest* cobj = nullptr;
    bool ok = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S, 1, "cc.HTTPRequest", 0, &tolua_err)) goto tolua_lerror;
#endif

    cobj = (cocos2d::extra::HTTPRequest*)tolua_tousertype(tolua_S, 1, 0);

#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S, "invalid 'cobj' in function 'lua_cocos2dx_httprequest_HTTPRequest_setPOSTData'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S) - 1;
    if (argc == 1)
    {
        const char* arg0;

        std::string arg0_tmp; ok &= luaval_to_std_string(tolua_S, 2, &arg0_tmp, "cc.HTTPRequest:setPOSTData"); arg0 = arg0_tmp.c_str();
        if (!ok)
        {
            tolua_error(tolua_S, "invalid arguments in function 'lua_cocos2dx_httprequest_HTTPRequest_setPOSTData'", nullptr);
            return 0;
        }
        cobj->setPOSTData(arg0);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "cc.HTTPRequest:setPOSTData", argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
                tolua_error(tolua_S, "#ferror in function 'lua_cocos2dx_httprequest_HTTPRequest_setPOSTData'.", &tolua_err);
#endif

                return 0;
}
int lua_cocos2dx_httprequest_HTTPRequest_addFormFile(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::extra::HTTPRequest* cobj = nullptr;
    bool ok = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S, 1, "cc.HTTPRequest", 0, &tolua_err)) goto tolua_lerror;
#endif

    cobj = (cocos2d::extra::HTTPRequest*)tolua_tousertype(tolua_S, 1, 0);

#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S, "invalid 'cobj' in function 'lua_cocos2dx_httprequest_HTTPRequest_addFormFile'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S) - 1;
    if (argc == 2)
    {
        const char* arg0;
        const char* arg1;

        std::string arg0_tmp; ok &= luaval_to_std_string(tolua_S, 2, &arg0_tmp, "cc.HTTPRequest:addFormFile"); arg0 = arg0_tmp.c_str();

        std::string arg1_tmp; ok &= luaval_to_std_string(tolua_S, 3, &arg1_tmp, "cc.HTTPRequest:addFormFile"); arg1 = arg1_tmp.c_str();
        if (!ok)
        {
            tolua_error(tolua_S, "invalid arguments in function 'lua_cocos2dx_httprequest_HTTPRequest_addFormFile'", nullptr);
            return 0;
        }
        cobj->addFormFile(arg0, arg1);
        lua_settop(tolua_S, 1);
        return 1;
    }
    if (argc == 3)
    {
        const char* arg0;
        const char* arg1;
        const char* arg2;

        std::string arg0_tmp; ok &= luaval_to_std_string(tolua_S, 2, &arg0_tmp, "cc.HTTPRequest:addFormFile"); arg0 = arg0_tmp.c_str();

        std::string arg1_tmp; ok &= luaval_to_std_string(tolua_S, 3, &arg1_tmp, "cc.HTTPRequest:addFormFile"); arg1 = arg1_tmp.c_str();

        std::string arg2_tmp; ok &= luaval_to_std_string(tolua_S, 4, &arg2_tmp, "cc.HTTPRequest:addFormFile"); arg2 = arg2_tmp.c_str();
        if (!ok)
        {
            tolua_error(tolua_S, "invalid arguments in function 'lua_cocos2dx_httprequest_HTTPRequest_addFormFile'", nullptr);
            return 0;
        }
        cobj->addFormFile(arg0, arg1, arg2);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "cc.HTTPRequest:addFormFile", argc, 2);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
                tolua_error(tolua_S, "#ferror in function 'lua_cocos2dx_httprequest_HTTPRequest_addFormFile'.", &tolua_err);
#endif

                return 0;
}
int lua_cocos2dx_httprequest_HTTPRequest_setRequestUrl(lua_State* tolua_S)
{
    int argc = 0;
    cocos2d::extra::HTTPRequest* cobj = nullptr;
    bool ok = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S, 1, "cc.HTTPRequest", 0, &tolua_err)) goto tolua_lerror;
#endif

    cobj = (cocos2d::extra::HTTPRequest*)tolua_tousertype(tolua_S, 1, 0);

#if COCOS2D_DEBUG >= 1
    if (!cobj)
    {
        tolua_error(tolua_S, "invalid 'cobj' in function 'lua_cocos2dx_httprequest_HTTPRequest_setRequestUrl'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S) - 1;
    if (argc == 1)
    {
        const char* arg0;

        std::string arg0_tmp; ok &= luaval_to_std_string(tolua_S, 2, &arg0_tmp, "cc.HTTPRequest:setRequestUrl"); arg0 = arg0_tmp.c_str();
        if (!ok)
        {
            tolua_error(tolua_S, "invalid arguments in function 'lua_cocos2dx_httprequest_HTTPRequest_setRequestUrl'", nullptr);
            return 0;
        }
        cobj->setRequestUrl(arg0);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "cc.HTTPRequest:setRequestUrl", argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
                tolua_error(tolua_S, "#ferror in function 'lua_cocos2dx_httprequest_HTTPRequest_setRequestUrl'.", &tolua_err);
#endif

                return 0;
}
int lua_cocos2dx_httprequest_HTTPRequest_createWithUrl(lua_State* tolua_S)
{
    int argc = 0;
    bool ok = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S, 1, "cc.HTTPRequest", 0, &tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 2)
    {
        cocos2d::extra::HTTPRequestDelegate* arg0;
        const char* arg1;
        ok &= luaval_to_object<cocos2d::extra::HTTPRequestDelegate>(tolua_S, 2, "cc.HTTPRequestDelegate", &arg0, "cc.HTTPRequest:createWithUrl");
        std::string arg1_tmp; ok &= luaval_to_std_string(tolua_S, 3, &arg1_tmp, "cc.HTTPRequest:createWithUrl"); arg1 = arg1_tmp.c_str();
        if (!ok)
        {
            tolua_error(tolua_S, "invalid arguments in function 'lua_cocos2dx_httprequest_HTTPRequest_createWithUrl'", nullptr);
            return 0;
        }
        cocos2d::extra::HTTPRequest* ret = cocos2d::extra::HTTPRequest::createWithUrl(arg0, arg1);
        object_to_luaval<cocos2d::extra::HTTPRequest>(tolua_S, "cc.HTTPRequest", (cocos2d::extra::HTTPRequest*)ret);
        return 1;
    }
    if (argc == 3)
    {
        cocos2d::extra::HTTPRequestDelegate* arg0;
        const char* arg1;
        int arg2;
        ok &= luaval_to_object<cocos2d::extra::HTTPRequestDelegate>(tolua_S, 2, "cc.HTTPRequestDelegate", &arg0, "cc.HTTPRequest:createWithUrl");
        std::string arg1_tmp; ok &= luaval_to_std_string(tolua_S, 3, &arg1_tmp, "cc.HTTPRequest:createWithUrl"); arg1 = arg1_tmp.c_str();
        ok &= luaval_to_int32(tolua_S, 4, (int *)&arg2, "cc.HTTPRequest:createWithUrl");
        if (!ok)
        {
            tolua_error(tolua_S, "invalid arguments in function 'lua_cocos2dx_httprequest_HTTPRequest_createWithUrl'", nullptr);
            return 0;
        }
        cocos2d::extra::HTTPRequest* ret = cocos2d::extra::HTTPRequest::createWithUrl(arg0, arg1, arg2);
        object_to_luaval<cocos2d::extra::HTTPRequest>(tolua_S, "cc.HTTPRequest", (cocos2d::extra::HTTPRequest*)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "cc.HTTPRequest:createWithUrl", argc, 2);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
                tolua_error(tolua_S, "#ferror in function 'lua_cocos2dx_httprequest_HTTPRequest_createWithUrl'.", &tolua_err);
#endif
                return 0;
}
int lua_cocos2dx_httprequest_HTTPRequest_createWithUrlLua(lua_State* tolua_S)
{
    int argc = 0;
    bool ok = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S, 1, "cc.HTTPRequest", 0, &tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 2)
    {
        LUA_FUNCTION arg0;
        const char* arg1;

#if COCOS2D_DEBUG >= 1
        if (!toluafix_isfunction(tolua_S, 2, "LUA_FUNCTION", 0, &tolua_err))
        {
            goto tolua_lerror;
        }
#endif
        arg0 = (toluafix_ref_function(tolua_S, 2, 0));
        // ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0, "cc.HTTPRequest:createWithUrlLua");
        std::string arg1_tmp; ok &= luaval_to_std_string(tolua_S, 3, &arg1_tmp, "cc.HTTPRequest:createWithUrlLua"); arg1 = arg1_tmp.c_str();
        if (!ok)
        {
            tolua_error(tolua_S, "invalid arguments in function 'lua_cocos2dx_httprequest_HTTPRequest_createWithUrlLua'", nullptr);
            return 0;
        }
        cocos2d::extra::HTTPRequest* ret = cocos2d::extra::HTTPRequest::createWithUrlLua(arg0, arg1);
        object_to_luaval<cocos2d::extra::HTTPRequest>(tolua_S, "cc.HTTPRequest", (cocos2d::extra::HTTPRequest*)ret);
        return 1;
    }
    if (argc == 3)
    {
        LUA_FUNCTION arg0;
        const char* arg1;
        int arg2;

#if COCOS2D_DEBUG >= 1
        if (!toluafix_isfunction(tolua_S, 2, "LUA_FUNCTION", 0, &tolua_err))
        {
            goto tolua_lerror;
        }
#endif
        arg0 = (toluafix_ref_function(tolua_S, 2, 0));
        //ok &= luaval_to_int32(tolua_S, 2,(int *)&arg0, "cc.HTTPRequest:createWithUrlLua");
        std::string arg1_tmp; ok &= luaval_to_std_string(tolua_S, 3, &arg1_tmp, "cc.HTTPRequest:createWithUrlLua"); arg1 = arg1_tmp.c_str();
        ok &= luaval_to_int32(tolua_S, 4, (int *)&arg2, "cc.HTTPRequest:createWithUrlLua");
        if (!ok)
        {
            tolua_error(tolua_S, "invalid arguments in function 'lua_cocos2dx_httprequest_HTTPRequest_createWithUrlLua'", nullptr);
            return 0;
        }
        cocos2d::extra::HTTPRequest* ret = cocos2d::extra::HTTPRequest::createWithUrlLua(arg0, arg1, arg2);
        object_to_luaval<cocos2d::extra::HTTPRequest>(tolua_S, "cc.HTTPRequest", (cocos2d::extra::HTTPRequest*)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "cc.HTTPRequest:createWithUrlLua", argc, 2);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
                tolua_error(tolua_S, "#ferror in function 'lua_cocos2dx_httprequest_HTTPRequest_createWithUrlLua'.", &tolua_err);
#endif
                return 0;
}
static int lua_cocos2dx_httprequest_HTTPRequest_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (HTTPRequest)");
    return 0;
}

int lua_register_cocos2dx_httprequest_HTTPRequest(lua_State* tolua_S)
{
    tolua_usertype(tolua_S, "cc.HTTPRequest");
    tolua_cclass(tolua_S, "HTTPRequest", "cc.HTTPRequest", "cc.Ref", nullptr);

    tolua_beginmodule(tolua_S, "HTTPRequest");
    tolua_function(tolua_S, "setCookieString", lua_cocos2dx_httprequest_HTTPRequest_setCookieString);
    tolua_function(tolua_S, "getResponseString", lua_cocos2dx_httprequest_HTTPRequest_getResponseString);
    tolua_function(tolua_S, "addFormContents", lua_cocos2dx_httprequest_HTTPRequest_addFormContents);
    tolua_function(tolua_S, "getResponseStatusCode", lua_cocos2dx_httprequest_HTTPRequest_getResponseStatusCode);
    tolua_function(tolua_S, "cancel", lua_cocos2dx_httprequest_HTTPRequest_cancel);
    tolua_function(tolua_S, "getResponseHeaders", lua_cocos2dx_httprequest_HTTPRequest_getResponseHeaders);
    tolua_function(tolua_S, "getResponseDataLength", lua_cocos2dx_httprequest_HTTPRequest_getResponseDataLength);
    tolua_function(tolua_S, "getResponseData", lua_cocos2dx_httprequest_HTTPRequest_getResponseData);
    tolua_function(tolua_S, "checkCURLState", lua_cocos2dx_httprequest_HTTPRequest_checkCURLState);
    tolua_function(tolua_S, "setAcceptEncoding", lua_cocos2dx_httprequest_HTTPRequest_setAcceptEncoding);
    tolua_function(tolua_S, "getDelegate", lua_cocos2dx_httprequest_HTTPRequest_getDelegate);
    tolua_function(tolua_S, "start", lua_cocos2dx_httprequest_HTTPRequest_start);
    tolua_function(tolua_S, "getErrorCode", lua_cocos2dx_httprequest_HTTPRequest_getErrorCode);
    tolua_function(tolua_S, "getState", lua_cocos2dx_httprequest_HTTPRequest_getState);
    tolua_function(tolua_S, "saveResponseData", lua_cocos2dx_httprequest_HTTPRequest_saveResponseData);
    tolua_function(tolua_S, "getCookieString", lua_cocos2dx_httprequest_HTTPRequest_getCookieString);
    tolua_function(tolua_S, "update", lua_cocos2dx_httprequest_HTTPRequest_update);
    tolua_function(tolua_S, "getResponseHeadersString", lua_cocos2dx_httprequest_HTTPRequest_getResponseHeadersString);
    tolua_function(tolua_S, "getErrorMessage", lua_cocos2dx_httprequest_HTTPRequest_getErrorMessage);
    tolua_function(tolua_S, "getRequestUrl", lua_cocos2dx_httprequest_HTTPRequest_getRequestUrl);
    tolua_function(tolua_S, "setTimeout", lua_cocos2dx_httprequest_HTTPRequest_setTimeout);
    tolua_function(tolua_S, "addPOSTValue", lua_cocos2dx_httprequest_HTTPRequest_addPOSTValue);
    tolua_function(tolua_S, "addRequestHeader", lua_cocos2dx_httprequest_HTTPRequest_addRequestHeader);
    tolua_function(tolua_S, "setPOSTData", lua_cocos2dx_httprequest_HTTPRequest_setPOSTData);
    tolua_function(tolua_S, "addFormFile", lua_cocos2dx_httprequest_HTTPRequest_addFormFile);
    tolua_function(tolua_S, "setRequestUrl", lua_cocos2dx_httprequest_HTTPRequest_setRequestUrl);
    tolua_function(tolua_S, "createWithUrl", lua_cocos2dx_httprequest_HTTPRequest_createWithUrl);
    tolua_function(tolua_S, "createWithUrlLua", lua_cocos2dx_httprequest_HTTPRequest_createWithUrlLua);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(cocos2d::extra::HTTPRequest).name();
    g_luaType[typeName] = "cc.HTTPRequest";
    g_typeCast["HTTPRequest"] = "cc.HTTPRequest";
    return 1;
}
TOLUA_API int register_all_cocos2dx_httprequest(lua_State* tolua_S)
{
    tolua_open(tolua_S);

    tolua_module(tolua_S, "cc", 0);
    tolua_beginmodule(tolua_S, "cc");

    lua_register_cocos2dx_httprequest_HTTPRequest(tolua_S);

    tolua_endmodule(tolua_S);
    return 1;
}

