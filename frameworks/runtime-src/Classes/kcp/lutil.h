#ifndef __LUA_LUTIL_H_
#define __LUA_LUTIL_H_
/*=========================================================================*\
* LuaSocket toolkit
* Networking support for the Lua language
* Diego Nehab
* 9/11/1999
\*=========================================================================*/
#ifdef __cplusplus
extern "C" {
#endif

#include "lua.h"
#include "lauxlib.h"

#ifdef __cplusplus
}
#endif

/*-------------------------------------------------------------------------*\
* Current socket library version
\*-------------------------------------------------------------------------*/


/*-------------------------------------------------------------------------*\
* This macro prefixes all exported API functions
\*-------------------------------------------------------------------------*/

/*-------------------------------------------------------------------------*\
* Initializes the library.
\*-------------------------------------------------------------------------*/
LUALIB_API int luaopen_lutil(lua_State *L);
#endif /* __LUA_LUTIL_H_ */
