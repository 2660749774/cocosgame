//
//  SDKGameCenter.h
//  game
//
//  Created by 王愿生 on 2017/2/26.
//
//

#ifndef SDKGameCenter_h
#define SDKGameCenter_h

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface SDKGameCenter : NSObject
{
}

//初始化
+(void)init;

//认证用户
+(void)authUser;

//显示排行榜
+(void) showLeaderboard;

//上传分数到排行榜
//lua调用{score=100,category=""}
+(void) reportScoreLua:(NSDictionary*)data;
//c++调用
+(void) reportScore:(int64_t)score forCategory:(NSString*)category;

//下载前x个分数
//lua调用{number=1}
+(void) retrieveTopXScoresLua:(NSDictionary*)dic;
//c++调用
+(void) retrieveTopXScores:(int)number;

//显示成就面板
+(void) showAchievementboard;

//加载成就数据
+(void) loadAchievement;

//清理排行榜
+(void) clearAchievements;

//提交成就
//lua调用{id=“”，percent:0.0}
+(void) reportAchievementLua:(NSDictionary*)dic;
//c++调用
+(void) reportAchievement:(NSString*)id percent:(float)percent;

//解锁成就
//lua调用{}
//+(void) unlockAchievementLua:(GKAchievement*)achievement percent:(float)percent;
+(void) unlockAchievement:(GKAchievement*)achievement percent:(float)percent;

//获取成就
//lua调用,{id=""}
+(GKAchievement*) getAchievementForIDLua:(NSDictionary*)dic;
//c++调用
+(GKAchievement*) getAchievementForID:(NSString*)id;
@end


#endif /* SDKGameCenter_h */
