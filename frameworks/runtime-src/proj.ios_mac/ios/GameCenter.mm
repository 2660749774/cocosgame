//
//  GameCenter.m
//  game
//
//  Created by 王愿生 on 2017/2/26.
//
//
#import "GameCenter.h"
#import "LuaBridge.h"

@implementation GameCenter

@synthesize gameCenterAvailable;

#pragma mark Initialization

static GameCenter* _ins = nil;
static UIViewController* currentModalViewController = nil;
+ (GameCenter*) getInstance {
    if (!_ins) {
        _ins = [[GameCenter alloc] init];
    }
    return _ins;
}

//用于验证gameCenter是否可用
- (BOOL)isGameCenterAvailable {
    // check for presence of GKLocalPlayer API
    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
    
    // check if the device is running iOS 4.1 or later
    NSString *reqSysVer =@"4.1";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer
                                           options:NSNumericSearch] != NSOrderedAscending);
    
    return (gcClass && osVersionSupported);
}

//初始化时验证gameCenter是否可用，同时对gameCenter进行监听
- (id)init {
    if ((self = [super init])) {
        gameCenterAvailable = [self isGameCenterAvailable];
        if (gameCenterAvailable) {
            NSNotificationCenter *nc =
            [NSNotificationCenter defaultCenter];
            [nc addObserver:self
                   selector:@selector(authenticationChanged)
                       name:GKPlayerAuthenticationDidChangeNotificationName
                     object:nil];
        }
    }
    return self;
}

//监听GameCenter认证回调
- (void)authenticationChanged {
    
    if ([GKLocalPlayer localPlayer].isAuthenticated && !userAuthenticated) {
        NSLog(@"Authentication changed: player authenticated.");
        userAuthenticated = TRUE;
    } else if (![GKLocalPlayer localPlayer].isAuthenticated && userAuthenticated) {
        NSLog(@"Authentication changed: player not authenticated");
        userAuthenticated = FALSE;
    }
}

/**********************认证用户***********************/
- (void)authUser{
    if (!gameCenterAvailable) {
        return;
    }
    
    NSLog(@"Authenticating local user...");
    
    if ([GKLocalPlayer localPlayer].authenticated == NO) {
        GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
        localPlayer.authenticateHandler = ^(UIViewController *viewController,NSError *error) {
            if (localPlayer.authenticated) {
                //already authenticated
                NSLog(@"already authenticated");
                [[GameCenter getInstance] removeControlView];
                
                //认证完毕后从gamecenter中获取成就状态，以备后面上传成就时查询
                [[GameCenter getInstance] loadAchievement];
            } else if(viewController) {
                UIWindow *window = [[UIApplication sharedApplication] keyWindow];
                currentModalViewController = [[UIViewController alloc] init];
                [window addSubview:currentModalViewController.view];
                [currentModalViewController presentViewController:viewController animated:YES completion:nil];
                NSLog(@"no login,show login");
            } else {
                NSLog(@"problem with authentication,probably bc the user doesn't use Game Center");
                [_ins removeControlView];
            }
        };
    } else {
        NSLog(@"Already authenticated!");
    }
}

-(NSString*) getUserInfo
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    if (!gameCenterAvailable) {
        // 状态，不可用
        [dict setObject:@1 forKey:@"state"];
        
    } else {
        GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
        if (localPlayer.isAuthenticated) {
            // 认证过了
            [localPlayer generateIdentityVerificationSignatureWithCompletionHandler:^(NSURL * _Nullable publicKeyUrl, NSData * _Nullable signature, NSData * _Nullable salt, uint64_t timestamp, NSError * _Nullable error) {
                if (error) {
                    NSLog(@"ERROR: %@",error);
                    [dict setObject:@3 forKey:@"state"];
                    [dict setObject:[error localizedDescription] forKey:@"error"];
                } else {
                    [dict setObject:@0 forKey:@"state"];
                    [dict setObject:[publicKeyUrl absoluteString] forKey:@"publicKeyUrl"];
                    [dict setObject:[signature base64EncodedStringWithOptions:0]  forKey:@"signature"];
                    [dict setObject:[salt base64EncodedStringWithOptions:0] forKey:@"salt"];
                    [dict setObject:[NSString stringWithFormat:@"%llu", timestamp] forKey:@"timestamp"];
                    [dict setObject:localPlayer.playerID forKey:@"player_id"];
                    [dict setObject:[[NSBundle mainBundle] bundleIdentifier] forKey:@"app_bundle_id"];
                }
                [LuaBridge callLua:@"gamecenterUserInfo" args:dict];
            }];
        } else {
            // 没认证过
            [dict setObject:@2 forKey:@"state"];
            
        }
    }
    
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

-(void)removeControlView
{
    if(currentModalViewController !=nil){
        [currentModalViewController dismissViewControllerAnimated:NO completion:nil];
        [currentModalViewController.view removeFromSuperview];
        [currentModalViewController release];
        currentModalViewController = nil;
    }
}

- (void) registerForAuthenticationNotification
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(authenticationChanged)
               name:GKPlayerAuthenticationDidChangeNotificationName
             object:nil];
}

//显示排行榜
- (void) showLeaderboard
{
    if (!gameCenterAvailable) return;
    
    GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
    if (leaderboardController != nil) {
        leaderboardController.leaderboardDelegate = self;
        
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        currentModalViewController = [[UIViewController alloc] init];
        [window addSubview:currentModalViewController.view];
        [currentModalViewController presentViewController:leaderboardController animated:YES completion:nil];
    }
}

//关闭排行榜回调
- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController{
    [_ins removeControlView];
}

//上传分数到排行榜
- (void) reportScore: (int64_t) score forCategory: (NSString*) category
{
    GKScore *scoreReporter = [[[GKScore alloc] initWithCategory:category] autorelease];
    scoreReporter.value = score;
    
    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
        if (error != nil)
        {
            NSLog(@"上传分数出错.");
        }
        else
        {
            NSLog(@"上传分数成功");
        }
    }];
}

//下载分数
- (void) retrieveTopXScores:(int)number
{
    GKLeaderboard *leaderboardRequest = [[GKLeaderboard alloc] init];
    if (leaderboardRequest != nil)
    {
        leaderboardRequest.playerScope = GKLeaderboardPlayerScopeGlobal;
        leaderboardRequest.timeScope = GKLeaderboardTimeScopeAllTime;
        leaderboardRequest.range = NSMakeRange(1,number);
        leaderboardRequest.category = _leaderboardName;
        [leaderboardRequest loadScoresWithCompletionHandler: ^(NSArray *scores, NSError *error) {
            if (error != nil){
                // handle the error.
                NSLog(@"下载失败");
            }
            if (scores != nil){
                // process the score information.
                NSLog(@"下载成功....");
                //NSArray *tempScore = [NSArray arrayWithArray:leaderboardRequest.scores];
                //for (GKScore *obj in tempScore) {
                //    NSLog(@"    playerID            : %@",obj.playerID);
                //    NSLog(@"    category            : %@",obj.category);
                //    NSLog(@"    date                : %@",obj.date);
                //    NSLog(@"    formattedValue    : %@",obj.formattedValue);
                //    NSLog(@"    value                : %d",obj.value);
                //    NSLog(@"    rank                : %d",obj.rank);
                //    NSLog(@"**************************************");
                //}
            }
        }];
    }
}

/*******************成就相关***********************************/

//加载所有成就。经测试，只能获取到已经上传过的成就状态。
- (void) loadAchievement
{
    if ( self.achievementDictionary == nil )
    {
        self.achievementDictionary = [[NSMutableDictionary alloc] init];
    }
    [GKAchievement loadAchievementsWithCompletionHandler:^(NSArray* achievements, NSError* error){
        if ( error == nil && achievements != nil )
        {
            NSArray* tempArray = [NSArray arrayWithArray:achievements];
            for(GKAchievement* tempAchievement in tempArray)
            {
                [self.achievementDictionary setObject:tempAchievement
                                               forKey:tempAchievement.identifier];
                [self displayAchievement:tempAchievement];
            }
        }
    }];
}

//显示成就
- (void) showAchievementboard
{
    if (!gameCenterAvailable) return;
    
    GKAchievementViewController *achievementController = [[GKAchievementViewController alloc] init];
    if (achievementController != nil) {
        achievementController.achievementDelegate = self;
        
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        currentModalViewController = [[UIViewController alloc] init];
        [window addSubview:currentModalViewController.view];
        [currentModalViewController presentViewController:achievementController animated:YES completion:nil];
    }
}

//关闭成就回调
- (void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController{
    [_ins removeControlView];
}

//通过ID汇报成就
- (void) reportAchievement:(NSString*)id percent:(float)percent
{
    if ( !gameCenterAvailable ) {
        NSLog(@"ERROR: GameCenter is not available currently");
        return;
    }
    
    GKAchievement* achievement = [[[GKAchievement alloc] initWithIdentifier:id] autorelease];
    [self unlockAchievement:achievement percent:percent];
}

//通过成就指针汇报成就
- (void) unlockAchievement:(GKAchievement *)achievement percent:(float)percent
{
    if ( achievement != nil )
    {
        achievement.percentComplete = percent;
        achievement.showsCompletionBanner = YES;
        [achievement reportAchievementWithCompletionHandler:^(NSError* error){
            if ( error != nil)
            {
                NSLog(@"上传成就错误，错误提示为\n%@", error);
            }
            else
            {
                NSLog(@"上传成就成功\n");
                [self displayAchievement:achievement];
            }
        }];
    }
}

//打印某个成就
- (void) displayAchievement:(GKAchievement*)achievement
{
    if ( achievement == nil) return;
    
    NSLog(@"completed:%d", achievement.completed);
    NSLog(@"lastReportDate:%@", achievement.lastReportedDate);
    NSLog(@"percentComplete:%f", achievement.percentComplete);
    NSLog(@"identifier:%@", achievement.identifier);
}

//通过成就id生成成就。首先从本地成就字典查询，查询不到则生成一个。
- (GKAchievement*) getAchievementForID: (NSString*) id
{
    if ( self.achievementDictionary == nil )
    {
        self.achievementDictionary = [[NSMutableDictionary alloc] init];
    }
    GKAchievement *achievement = [self.achievementDictionary objectForKey:id];
    if (achievement == nil)
    {
        achievement = [[[GKAchievement alloc] initWithIdentifier:id] autorelease];
        [self.achievementDictionary setObject:achievement
                                       forKey:achievement.identifier];
    }
    [self displayAchievement:achievement];
    return [[achievement retain] autorelease];
}

//初始化所有成就状态。经测试，这段代码暂时无效。
- (void) clearAchievements
{
    NSEnumerator* enumerator = [self.achievementDictionary objectEnumerator];
    for(NSObject* obj in enumerator)
    {
        [self unlockAchievement:(GKAchievement*)obj percent:0.0];
    }
}

-(void)release
{
    
}

@end
