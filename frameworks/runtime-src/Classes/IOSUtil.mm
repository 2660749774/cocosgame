//
//  IOSUtil.m
//  game
//
//  Created by 王愿生 on 2017/5/13.
//
// IOS工具类

#import <AdSupport/AdSupport.h>

@implementation IOSUtil

+(NSString*) getDeviceId
{
    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    return idfa;
}

+(void) openURL:(NSString*)url
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
}

@end

