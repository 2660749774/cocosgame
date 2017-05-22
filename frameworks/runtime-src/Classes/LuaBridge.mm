//
//  LuaBridge.m
//  game
//
//  Created by 王愿生 on 2017/5/13.
//
// 用于Lua和Objective-C进行交互

#import "LuaBridge.h"
#include "cocos2d.h"
#include "cocos/scripting/lua-bindings/manual/CCLuaValue.h"
#include "cocos/scripting/lua-bindings/manual/CCLuaBridge.h"

@implementation LuaBridge

// lua回调函数
static int lua_listener = 0;

+(void) callObjectCMethod:(NSDictionary *)dict
{
    // 获取action名称
    NSString* action = [dict valueForKey:@"action"];
    NSLog(@"[LuaBridge] lua call object c method action: %@", action);
    
    if( [action isEqualToString:@"registerScriptHandler"] )
    {
        lua_listener = [[dict valueForKey:@"listener"] intValue];
    }
}

+(void) callLua:(NSDictionary*)dict;
{
    NSLog(@"[LuaBridge] call lua");
    if(lua_listener == 0)
    {
        return;
    }
    
    // 序列化为JSON格式
    NSError *error;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    if (! jsonData)
    {
        NSLog(@"[LuaBridge]json解析失败：%@", error);
        return;
    }
    
    // 调用Lua
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    const char* str = [jsonStr UTF8String];
    cocos2d::LuaBridge::pushLuaFunctionById(lua_listener);
    cocos2d::LuaBridge::getStack()->pushString(str);
    cocos2d::LuaBridge::getStack()->executeFunction(1);
    cocos2d::LuaBridge::getStack()->clean();
}

@end

