//
//  NetworkConnectivityHandler.m
//  Cross Platform Native Plugins
//
//  Created by Ashwin kumar on 06/12/14.
//  Copyright (c) 2015 Voxel Busters Interactive LLP. All rights reserved.
//

#import "NetworkConnectivityHandler.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@interface NetworkConnectivityHandler ()

@property (nonatomic, retain)   Reachability	*hostReachability;
@property (nonatomic, assign)   bool			isHostReachable;

@end

@implementation NetworkConnectivityHandler

#define kNetworkChanged		"ConnectivityChanged"

@synthesize hostReachability;

@synthesize isConnected;
@synthesize isHostReachable;

#pragma mark - init and dealloc

- (id)init
{
	self = [super init];
    
    if (self)
    {
		// Default flag values
		self.isConnected			= NO;
        self.isHostReachable    	= NO;
		
		// Register for notification
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(reachabilityChanged:)
													 name:kReachabilityChangedNotification
												   object:nil];
    }
    
    return self;
}


- (void)dealloc
{
    // Remove as observer
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kReachabilityChangedNotification
                                                  object:nil];
	
    // Release
	[self.hostReachability stopNotifier];
	self.hostReachability		= NULL;
}

#pragma mark - Methods

- (void)setHostAddress:(NSString *)hostAddress
{
	// Old reachablity handler will be released
	if (self.hostReachability != NULL)
	{
		[self.hostReachability stopNotifier];
		self.hostReachability	= NULL;
	}
	
	struct sockaddr_in6 addr;
	memset(&addr, 0, sizeof(struct sockaddr_in6));
	addr.sin6_len = sizeof(struct sockaddr_in6);
	addr.sin6_family = AF_INET6;
	inet_pton(AF_INET6, [hostAddress UTF8String], &addr.sin6_addr);
	
	self.hostReachability   	= [Reachability reachabilityWithAddress:(const struct sockaddr *)&addr];
	[self.hostReachability startNotifier];
	[self updateReachablityStatus:self.hostReachability];
}


#pragma mark - Notification

- (void)reachabilityChanged:(NSNotification *)note
{
	Reachability* curReach = [note object];
    
    if ([curReach isKindOfClass:[Reachability class]])
    {
        [self updateReachablityStatus:curReach];
    }
}

- (void)updateReachablityStatus:(Reachability *)reachability
{
	if (reachability == self.hostReachability)
	{
		BOOL connectionRequired		= [reachability connectionRequired];
		BOOL reachable				= [self checkIfReachable:reachability];
		self.isHostReachable		= reachable && !connectionRequired;
	}
	
	// Check new status
    BOOL newConnectivityStatus		= self.isHostReachable;
	
	// Send message to Unity
    if (self.isConnected)
    {
        if (!newConnectivityStatus)
        {
            NSLog(@"[NetworkConnectivityHandler] is not reachable");
            [IOSBridge networkChanged:false];
        }
    }
    else
    {
        if (newConnectivityStatus)
        {
            NSLog(@"[NetworkConnectivityHandler] is reachable");
            [IOSBridge networkChanged:true];
        }
    }
	
	// Cache the new connectivity status
	self.isConnected		= newConnectivityStatus;
}

- (bool)checkIfReachable:(Reachability *)reachability
{
    NetworkStatus status = [reachability currentReachabilityStatus];

	return (status != NotReachable);
}

- (NSString*) getNetworkName
{
    if (self.hostReachability == nil) {
        return @"";
    }
    NSString *netName = @"";
    switch ([self.hostReachability currentReachabilityStatus]) {
        case NotReachable:
        {
            // 没有网络
            netName = @"no network";
        }
            break;
            
        case ReachableViaWiFi:
        {
            // Wifi
            // 获取ssid
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
                netName= [[dctySSID objectForKey:@"SSID"] lowercaseString];
            }
        }
            break;
            
        case ReachableViaWWAN:
        {
            // 手机自带网络
            // 获取手机网络类型
            CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
            
            NSString *currentStatus = info.currentRadioAccessTechnology;
            
            if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]) {
                netName = @"GPRS";
            } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]) {
                netName = @"EDGE";
            } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]) {
                netName = @"3G";
            } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]) {
                netName = @"3.5G HSDPA";
            } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]) {
                netName = @"3.5G HSUPA";
            } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]) {
                netName = @"2G";
            } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]) {
                netName = @"3G";
            } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]) {
                netName = @"3G";
            } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]) {
                netName = @"3G";
            } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]) {
                netName = @"3G HRPD";
            } else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]) {
                netName = @"4G";
            } else {
                netName = @"unknow";
            }
        }
            break;
            
        default:
            break;
    }
    
    return netName;
}

@end
