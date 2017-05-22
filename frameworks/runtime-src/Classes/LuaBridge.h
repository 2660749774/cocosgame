//
//  LuaBridge.h
//  game
//
//  Created by 王愿生 on 2017/5/13.
//
// 用于Lua和Objective-C进行交互

#ifndef LuaBridge_h
#define LuaBridge_h

#import <Foundation/Foundation.h>

@interface LuaBridge : NSObject

/**
 * 调用Objective-C方法
 */
+(void) callObjectCMethod:(NSDictionary*)dict;

/**
 * 调用Lua方法
 */
+(void) callLua:(NSDictionary*)dict;

@end

#endif /* LuaBridge_h */
