//
//  GameCenter.h
//  game
//
//  Created by 王愿生 on 2017/2/26.
//
//

#ifndef GameCenter_h
#define GameCenter_h
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface GameCenter : NSObject <GKLeaderboardViewControllerDelegate,GKAchievementViewControllerDelegate>
{
@private
    BOOL gameCenterAvailable;
    BOOL userAuthenticated;
}

@property (assign, readonly) BOOL gameCenterAvailable;
@property (nonatomic, copy) NSString* leaderboardName;
//本地成就字典，用来保存已经下载下来的成就，以避免重复从gamecenter获取成就状态
@property (nonatomic, retain) NSMutableDictionary* achievementDictionary;

//静态方法创建单例
+(GameCenter*)getInstance;

//认证用户
- (void) authUser;
//注册gameCenter认证回调
- (void) registerForAuthenticationNotification;

//显示排行榜
- (void) showLeaderboard;
//排行榜关闭时回调
- (void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController;

//上传分数到Gamecenter
- (void) reportScore:(int64_t)score forCategory:(NSString*)category;
// 下载前x个分数
- (void) retrieveTopXScores:(int)number;

//显示成就
- (void) showAchievementboard;
//成就关闭时回调
- (void) achievementViewControllerDidFinish:(GKAchievementViewController *)achievementController;

//加载成就
- (void) loadAchievement;
//清楚成就
- (void) clearAchievements;

//提交成就
- (void) reportAchievement:(NSString*)id percent:(float)percent;
//解锁成就
- (void) unlockAchievement:(GKAchievement*)achievement percent:(float)percent;

//获取成就
- (GKAchievement*) getAchievementForID:(NSString*)id;

//释放
-(void)release;

-(void)removeControlView;

@end

#endif /* GameCenter_h */
