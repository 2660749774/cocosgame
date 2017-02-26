//
//  SDKGameCenter.m
//  game
//
//  Created by 王愿生 on 2017/2/26.
//
//
#import "SDKGameCenter.h"
#import "GameCenter.h"

@implementation SDKGameCenter

#pragma mark Initialization

static GameCenter * _ins = nil;

+(void)init
{
    if (!_ins) {
        _ins = [[GameCenter alloc] init];
    }
}

+(void)authUser
{
    [_ins authUser];
}

+(void)showLeaderboard
{
    [_ins showLeaderboard];
}

+(void)reportScoreLua:(NSDictionary*)data
{
    int score=[[data objectForKey:@"score"] intValue];
    NSString* category=[data objectForKey:@"category"];
    [SDKGameCenter reportScore:score forCategory:category];
}

+(void)reportScore:(int64_t)score forCategory:(NSString *)category
{
    [_ins reportScore:score forCategory:category];
}

+(void)retrieveTopXScoresLua:(NSDictionary *)dic
{
    int number=[[dic objectForKey:@"number"] intValue];
    [SDKGameCenter retrieveTopXScores:number];
}

+(void)retrieveTopXScores:(int)number
{
    [_ins retrieveTopXScores:number];
}

+(void)showAchievementboard
{
    [_ins showAchievementboard];
}

+(void)loadAchievement
{
    [_ins loadAchievement];
}

+(void)clearAchievements
{
    [_ins clearAchievements];
}

+(void)reportAchievementLua:(NSDictionary *)dic
{
    NSString* id=[dic objectForKey:@"id"];
    float percent=[[dic objectForKey:@"percent"] floatValue];
    [SDKGameCenter reportAchievement:id percent:percent];
}

+(void)reportAchievement:(NSString *)id percent:(float)percent
{
    [_ins reportAchievement:id percent:percent];
}

+(void)unlockAchievement:(GKAchievement *)achievement percent:(float)percent
{
    [_ins unlockAchievement:achievement percent:percent];
}

+(GKAchievement*)getAchievementForIDLua:(NSDictionary *)dic
{
    NSString* id=[dic objectForKey:@"id"];
    return [SDKGameCenter getAchievementForID:id];
}

+(GKAchievement*)getAchievementForID:(NSString *)id
{
    return [_ins getAchievementForID:id];
}

@end
