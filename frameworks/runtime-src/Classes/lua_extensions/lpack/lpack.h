
#ifndef __LUA_LPACK_H_
#define __LUA_LPACK_H_


#ifdef __cplusplus
extern "C" {
#endif
    
#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"

#ifdef __cplusplus
}
#endif

int luaopen_pack(lua_State *L);

#endif
