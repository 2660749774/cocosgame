//
//  NetworkConnectivityHandler.h
//  Cross Platform Native Plugins
//
//  Created by Ashwin kumar on 06/12/14.
//  Copyright (c) 2015 Voxel Busters Interactive LLP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "HandlerBase.h"
#include <arpa/inet.h>
#import "IOSBridge.h"

@interface NetworkConnectivityHandler : HandlerBase

// Properties
@property (nonatomic, assign)   bool                isConnected;

// Related to notification handlers
- (void)setHostAddress:(NSString *)hostAddress;

// 获取网络连接名称
- (NSString*) getNetworkName;
@end
