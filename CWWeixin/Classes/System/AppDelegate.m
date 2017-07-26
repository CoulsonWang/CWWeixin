//
//  AppDelegate.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/25.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "AppDelegate.h"
#import "WXLogRegistController.h"
#import <SVProgressHUD.h>

#define kEaseMobKey @"1110170725178017#suibiantian"

@interface AppDelegate () <EMChatManagerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[EaseMob sharedInstance] registerSDKWithAppKey:kEaseMobKey apnsCertName:nil otherConfig:@{kSDKConfigEnableConsoleLogger: @NO}];
    
    [[EaseMob sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[WXLogRegistController alloc] init];
    if ([EaseMob sharedInstance].chatManager.isAutoLoginEnabled) {
        [SVProgressHUD showWithStatus:@"正在自动登录..."];
    }
    
    
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

- (void)didAutoLoginWithInfo:(NSDictionary *)loginInfo error:(EMError *)error {
    [SVProgressHUD dismiss];
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"登录失败！"];
    } else {
        self.window.rootViewController = MainStoryBoard.instantiateInitialViewController;
    }
}

- (void)didRemovedFromServer {
    [self passiveLogout];
}

- (void)didLoginFromOtherDevice {
    [self passiveLogout];
}

- (void)passiveLogout {
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:NO completion:^(NSDictionary *info, EMError *error) {
        if (!error) {
            UIApplication.sharedApplication.keyWindow.rootViewController = [[WXLogRegistController alloc] init];
        }
        
    } onQueue:nil];
}

@end
