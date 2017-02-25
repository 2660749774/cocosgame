#include "lua_cocos2dx_crypto_auto.hpp"
#include "crypto/CryptoUtil.h"
#include "scripting/lua-bindings/manual/tolua_fix.h"
#include "scripting/lua-bindings/manual/LuaBasicConversions.h"

#include <string>
using namespace std;

int lua_cocos2dx_crypto_CryptoUtil_decodeBase64(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"CryptoUtil",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 1)
    {
        std::string arg0;
        ok &= luaval_to_std_string(tolua_S, 2,&arg0, "CryptoUtil:decodeBase64");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_cocos2dx_crypto_CryptoUtil_decodeBase64'", nullptr);
            return 0;
        }
        std::string ret = CryptoUtil::decodeBase64(arg0);
        tolua_pushcppstring(tolua_S,ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "CryptoUtil:decodeBase64",argc, 1);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_crypto_CryptoUtil_decodeBase64'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_crypto_CryptoUtil_decryptAES256(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"CryptoUtil",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 4)
    {
        std::string arg0;
        int arg1;
        std::string arg2;
        int arg3;
        ok &= luaval_to_std_string(tolua_S, 2,&arg0, "CryptoUtil:decryptAES256");
        ok &= luaval_to_int32(tolua_S, 3,(int *)&arg1, "CryptoUtil:decryptAES256");
        ok &= luaval_to_std_string(tolua_S, 4,&arg2, "CryptoUtil:decryptAES256");
        ok &= luaval_to_int32(tolua_S, 5,(int *)&arg3, "CryptoUtil:decryptAES256");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_cocos2dx_crypto_CryptoUtil_decryptAES256'", nullptr);
            return 0;
        }
        std::string ret = CryptoUtil::decryptAES256(arg0, arg1, arg2, arg3);
        tolua_pushcppstring(tolua_S,ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "CryptoUtil:decryptAES256",argc, 4);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_crypto_CryptoUtil_decryptAES256'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_crypto_CryptoUtil_md5File(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"CryptoUtil",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 1)
    {
        std::string arg0;
        ok &= luaval_to_std_string(tolua_S, 2,&arg0, "CryptoUtil:md5File");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_cocos2dx_crypto_CryptoUtil_md5File'", nullptr);
            return 0;
        }
        std::string ret = CryptoUtil::md5File(arg0);
        tolua_pushcppstring(tolua_S,ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "CryptoUtil:md5File",argc, 1);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_crypto_CryptoUtil_md5File'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_crypto_CryptoUtil_encryptAES256(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"CryptoUtil",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 4)
    {
        std::string arg0;
        int arg1;
        std::string arg2;
        int arg3;
        ok &= luaval_to_std_string(tolua_S, 2,&arg0, "CryptoUtil:encryptAES256");
        ok &= luaval_to_int32(tolua_S, 3,(int *)&arg1, "CryptoUtil:encryptAES256");
        ok &= luaval_to_std_string(tolua_S, 4,&arg2, "CryptoUtil:encryptAES256");
        ok &= luaval_to_int32(tolua_S, 5,(int *)&arg3, "CryptoUtil:encryptAES256");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_cocos2dx_crypto_CryptoUtil_encryptAES256'", nullptr);
            return 0;
        }
        std::string ret = CryptoUtil::encryptAES256(arg0, arg1, arg2, arg3);
        tolua_pushcppstring(tolua_S,ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "CryptoUtil:encryptAES256",argc, 4);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_crypto_CryptoUtil_encryptAES256'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_crypto_CryptoUtil_encodeBase64(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"CryptoUtil",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 1)
    {
        std::string arg0;
        ok &= luaval_to_std_string(tolua_S, 2,&arg0, "CryptoUtil:encodeBase64");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_cocos2dx_crypto_CryptoUtil_encodeBase64'", nullptr);
            return 0;
        }
        std::string ret = CryptoUtil::encodeBase64(arg0);
        tolua_pushcppstring(tolua_S,ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "CryptoUtil:encodeBase64",argc, 1);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_crypto_CryptoUtil_encodeBase64'.",&tolua_err);
#endif
    return 0;
}
int lua_cocos2dx_crypto_CryptoUtil_md5(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"CryptoUtil",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 1)
    {
        std::string arg0;
        ok &= luaval_to_std_string(tolua_S, 2,&arg0, "CryptoUtil:md5");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_cocos2dx_crypto_CryptoUtil_md5'", nullptr);
            return 0;
        }
        std::string ret = CryptoUtil::md5(arg0);
        tolua_pushcppstring(tolua_S,ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "CryptoUtil:md5",argc, 1);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_cocos2dx_crypto_CryptoUtil_md5'.",&tolua_err);
#endif
    return 0;
}
static int lua_cocos2dx_crypto_CryptoUtil_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (CryptoUtil)");
    return 0;
}

int lua_register_cocos2dx_crypto_CryptoUtil(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"CryptoUtil");
    tolua_cclass(tolua_S,"CryptoUtil","CryptoUtil","",nullptr);

    tolua_beginmodule(tolua_S,"CryptoUtil");
        tolua_function(tolua_S,"decodeBase64", lua_cocos2dx_crypto_CryptoUtil_decodeBase64);
        tolua_function(tolua_S,"decryptAES256", lua_cocos2dx_crypto_CryptoUtil_decryptAES256);
        tolua_function(tolua_S,"md5File", lua_cocos2dx_crypto_CryptoUtil_md5File);
        tolua_function(tolua_S,"encryptAES256", lua_cocos2dx_crypto_CryptoUtil_encryptAES256);
        tolua_function(tolua_S,"encodeBase64", lua_cocos2dx_crypto_CryptoUtil_encodeBase64);
        tolua_function(tolua_S,"md5", lua_cocos2dx_crypto_CryptoUtil_md5);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(CryptoUtil).name();
    g_luaType[typeName] = "CryptoUtil";
    g_typeCast["CryptoUtil"] = "CryptoUtil";
    return 1;
}
TOLUA_API int register_all_cocos2dx_crypto(lua_State* tolua_S)
{
	tolua_open(tolua_S);
	
	tolua_module(tolua_S,"cc",0);
	tolua_beginmodule(tolua_S,"cc");

	lua_register_cocos2dx_crypto_CryptoUtil(tolua_S);

	tolua_endmodule(tolua_S);
	return 1;
}

