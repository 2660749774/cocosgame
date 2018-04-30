//
//  LuaBridge.m
//  game
//
//  Created by 王愿生 on 2017/5/13.
//
// 用于Lua和Objective-C进行交互
#include "cocos2d.h"
#include "cocos/scripting/lua-bindings/manual/CCLuaValue.h"
#include "cocos/scripting/lua-bindings/manual/CCLuaBridge.h"
#import <AdSupport/AdSupport.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <AudioToolbox/AudioToolbox.h>
#import <UIKit/UIDevice.h>
#import "NetworkConnectivityBinding.h"
#import "NetworkConnectivityHandler.h"
#include <sys/socket.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <err.h>
#import "LuaBridge.h"
#import "GameCenter.h"

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
        // 初始化
        lua_listener = [[dict valueForKey:@"listener"] intValue];
        
        // 注册网络监听
        NSString* host =[[dict valueForKey:@"host"] stringValue];
        cpnpNetworkConnectivitySetHostAddress([host UTF8String]);
    } else if ([action isEqualToString:@"loginGameCenter"])
    {
        [[GameCenter getInstance] authUser];
    }
}

+(NSString*) callObjectCMethodWithReturn:(NSDictionary *)dict
{
    // 获取action名称
    NSString* action = [dict valueForKey:@"action"];
    NSLog(@"[LuaBridge] lua call object c return method action: %@", action);
    
    if( [action isEqualToString:@"getDeviceId"] )
    {
        return [LuaBridge getDeviceId];
    }
    if ([action isEqualToString:@"getDeviceInfo"])
    {
        NSDictionary* dict = [LuaBridge getDeviceInfo];
        // 序列化为JSON格式
        NSError *error;
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        
        if (! jsonData)
        {
            NSLog(@"[LuaBridge]json解析失败：%@", error);
            return @"";
        }
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    if ([action isEqualToString:@"getNetworkName"])
    {
        return [LuaBridge getNetworkName];
    }
    if ([action isEqualToString:@"getDeviceSSID"])
    {
        return [LuaBridge getDeviceSSID];
    }
    if ([action isEqualToString:@"getGameCenterUserInfo"])
    {
        return [[GameCenter getInstance] getUserInfo];
        
    }
    return @"";
}


+(void) callLua:(NSString*) action args:(NSDictionary*) args;
{
    NSLog(@"[LuaBridge] call lua: %@", action);
    if(lua_listener == 0)
    {
        return;
    }
    
    NSMutableDictionary *dictRoot = nil;
    if(args != nil) {
        dictRoot = [NSMutableDictionary dictionaryWithDictionary: args];
    } else {
        dictRoot = [[NSMutableDictionary alloc] init];
    }
    
    [dictRoot setObject:action forKey:@"action"];
    
    // 序列化为JSON格式
    NSError *error;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dictRoot options:NSJSONWritingPrettyPrinted error:&error];
    
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


+(NSString*) getDeviceId
{
    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    return idfa;
}

+(NSString*) getDeviceSSID
{
    
    NSArray *ifs = (__bridge id)CNCopySupportedInterfaces();
    
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count]) {
            break;
        }
    }
    
    if (nil != info) {
        NSDictionary *dctySSID = (NSDictionary *)info;
        NSString *ssid = [[dctySSID objectForKey:@"SSID"] lowercaseString];
        return ssid;
    }
    
    return @"";
}

+(NSString*) getNetworkName
{
    return [[NetworkConnectivityHandler Instance] getNetworkName];
}

+(NSDictionary*) getDeviceInfo
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    // 手机别名： 用户定义的名称
    NSString* userPhoneName = [[UIDevice currentDevice] name];
    NSLog(@"手机别名: %@", userPhoneName);
    [dict setObject:userPhoneName forKey:@"phoneName"];
    
    // 设备名称
    NSString* deviceName = [[UIDevice currentDevice] systemName];
    NSLog(@"设备名称: %@",deviceName );
    [dict setObject:deviceName forKey:@"deviceName"];
    
    // 手机系统版本
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    NSLog(@"手机系统版本: %@", phoneVersion);
    [dict setObject:phoneVersion forKey:@"phoneVersion"];
    
    // 手机型号
    NSString* phoneModel = [[UIDevice currentDevice] model];
    NSLog(@"手机型号: %@",phoneModel );
    [dict setObject:phoneModel forKey:@"phoneModel"];
    
    // 手机内存
    NSString* maxRamSize =[LuaBridge sizeFormat:[NSProcessInfo processInfo].physicalMemory];
    NSLog(@"手机内存: %@",maxRamSize );
    [dict setObject:maxRamSize forKey:@"maxRamSize"];
    
    // opengl版本号
//    NSString* opengles = [LuaBridge openGLVersion];
//    NSLog(@"opengl: %@",opengles );
//    [dict setObject:opengles forKey:@"opengles"];
    
    // 手机分辨率
    NSString* screenResolution = [LuaBridge currentResolution];
    NSLog(@"手机分辨率: %@",screenResolution );
    [dict setObject:screenResolution forKey:@"screenResolution"];
    
    // 地方型号  （国际化区域名称）
    NSString* localPhoneModel = [[UIDevice currentDevice] localizedModel];
    NSLog(@"国际化区域名称: %@",localPhoneModel );
    [dict setObject:localPhoneModel forKey:@"localPhoneModel"];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // 当前应用名称
    NSString *appCurName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSLog(@"当前应用名称：%@",appCurName);
    [dict setObject:appCurName forKey:@"appName"];
    
    // 当前应用软件版本  比如：1.0.1
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"当前应用软件版本:%@",appCurVersion);
    [dict setObject:appCurVersion forKey:@"appVersion"];
    
    // 当前应用版本号码   int类型
    NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSLog(@"当前应用版本号码：%@",appCurVersionNum);
    [dict setObject:appCurVersionNum forKey:@"appBuildVersion"];
    
    return dict;
}

+(void) openURL:(NSString*)url
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
}

+(void)networkChanged:(bool)connected
{
    NSString* value = nil;
    if (connected) {
        value = @"true";
    } else {
        value = @"false";
    }
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:value, @"connected", nil];
    [LuaBridge callLua:@"networkChanged" args:dic];
}

// 震动
+(void)vibrate:(int)seconds
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

// 大小格式化
+(NSString *)sizeFormat:(unsigned long long)size
{
    NSInteger KB = 1024;
    NSInteger MB = KB*KB;
    NSInteger GB = MB*KB;
    
    if (size < 10)
    {
        return @"0 B";
        
    }else if (size < KB)
    {
        return @"< 1 KB";
        
    }else if (size < MB)
    {
        return [NSString stringWithFormat:@"%.1fK",((CGFloat)size)/KB];
        
    }else if (size < GB)
    {
        return [NSString stringWithFormat:@"%.1fM",((CGFloat)size)/MB];
        
    }else
    {
        return [NSString stringWithFormat:@"%.1fG",((CGFloat)size)/GB];
    }
}

// 获取当前分辨率
+(NSString*) currentResolution
{
    CGSize result = [[UIScreen mainScreen] bounds].size;
    result = CGSizeMake(result.width * [UIScreen mainScreen].scale, result.height * [UIScreen mainScreen].scale);
    return [NSString stringWithFormat:@"%d,%d", (int)result.width, (int)result.height];
}

@end

