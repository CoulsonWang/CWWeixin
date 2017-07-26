//
//  WXTabBarController.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/26.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXTabBarController.h"
#import "WXContactController.h"

typedef enum : NSUInteger {
    WXTabBarBadgeValuePlusOne,
    WXTabBarBadgeValueMinusOne,
    WXTabBarBadgeValueClear,
} WXTabBarBadgeValueChangeMode;

@interface WXTabBarController () <EMChatManagerDelegate>

@end

@implementation WXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *tintColor = [UIColor colorWithRed:0 green:190/255.0 blue:12/255.0 alpha:1];
    
    for (UINavigationController *nav in self.childViewControllers) {
        [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: tintColor} forState:UIControlStateSelected];
    }
    
    self.tabBar.tintColor = tintColor;
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}


#pragma mark - 接收到好友请求

- (void)didReceiveBuddyRequest:(NSString *)username message:(NSString *)message {
    [self changeContactBadgeValue:WXTabBarBadgeValuePlusOne];
    
    [self requestForBuddyAccept:username message:message];
}

#pragma mark - 私有工具方法

- (void)changeContactBadgeValue:(WXTabBarBadgeValueChangeMode)changeMode {
    UINavigationController *contactNavVC = self.viewControllers[1];
    NSString *badgeValue = contactNavVC.tabBarItem.badgeValue;
    NSInteger badgeNum = badgeValue.integerValue;
    switch (changeMode) {
        case WXTabBarBadgeValuePlusOne:
            badgeNum++;
            break;
        case WXTabBarBadgeValueMinusOne:
            badgeNum--;
            break;
        case WXTabBarBadgeValueClear:
            badgeNum = 0;
            break;
        default:
            break;
    }
    if (badgeNum == 0) {
        contactNavVC.tabBarItem.badgeValue = nil;
    } else {
        contactNavVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld",badgeNum];
    }
    
}


- (void)requestForBuddyAccept:(NSString *)username message:(NSString *)message {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@请求添加您为好友",username] message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拒绝" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        EMError *error = nil;
        [[EaseMob sharedInstance].chatManager rejectBuddyRequest:username reason:nil error:&error];
        if (!error) {
            NSLog(@"已拒绝");
            [self changeContactBadgeValue:WXTabBarBadgeValueMinusOne];
        }
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"接受" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        EMError *error = nil;
        [[EaseMob sharedInstance].chatManager acceptBuddyRequest:username error:&error];
        if (!error) {
            self.selectedIndex = 1;
            [self changeContactBadgeValue:WXTabBarBadgeValueMinusOne];
        }
        
    }];
    
    [alertVC addAction:action1];
    [alertVC addAction:action2];
    
    [self presentViewController:alertVC animated:NO completion:nil];
}

@end
