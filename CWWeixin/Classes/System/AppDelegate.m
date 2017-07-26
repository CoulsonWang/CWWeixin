//
//  AppDelegate.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/25.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "AppDelegate.h"
#import "WXLogRegistController.h"

#define kEaseMobKey @"1110170725178017#suibiantian"

@interface AppDelegate () <EMChatManagerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[EaseMob sharedInstance] registerSDKWithAppKey:kEaseMobKey apnsCertName:nil otherConfig:@{kSDKConfigEnableConsoleLogger: @NO}];
    
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIViewController *rootVC;
    if ([EaseMob sharedInstance].chatManager.isAutoLoginEnabled) {
        rootVC = MainStoryBoard.instantiateInitialViewController;
        
    } else {
        rootVC = [[WXLogRegistController alloc] init];
    }
    self.window.rootViewController = rootVC;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
    [[EaseMob sharedInstance] applicationWillResignActive:application];
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [[EaseMob sharedInstance] applicationDidEnterBackground:application];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [[EaseMob sharedInstance] applicationWillEnterForeground:application];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    [[EaseMob sharedInstance] applicationDidBecomeActive:application];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
    [[EaseMob sharedInstance] applicationWillTerminate:application];
    
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
    
}

#pragma mark - EMChatManagerDelegate 




@end
