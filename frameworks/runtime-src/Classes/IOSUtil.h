//
//  IOSUtil.h
//  game
//
//  Created by 王愿生 on 2017/5/13.
//
// IOS工具类的一些封装

#ifndef IOSUtil_h
#define IOSUtil_h

#import <Foundation/Foundation.h>

@interface IOSUtil : NSObject

/**
 * 获取设备Id，这里返回IDFA
 */
+(NSString*) getDeviceId;

/**
 * 打开指定URL
 */
+(void) openURL:(NSString*)url;

@end


#endif /* IOSUtil_h */
