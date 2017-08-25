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
 * 调用Object-C方法，带返回值
 */
+(NSString*) callObjectCMethodWithReturn:(NSDictionary*)dict;

/**
 * 调用Lua方法
 */
+(void) callLua:(NSString*) action args:(NSDictionary*) args;

// 获取设备Id
+(NSString*) getDeviceId;

// 打开指定URL
+(void) openURL:(NSString*)url;

// 获取ssid
+(NSString*) getDeviceSSID;

// 获取网络名称
+(NSString*) getNetworkName;

// 获取设备信息
+(NSDictionary*) getDeviceInfo;

// 通知网络变化
+(void) networkChanged:(bool) connected;

// 震动设备
+(void) vibrate:(int)seconds;

@end

#endif /* LuaBridge_h */
