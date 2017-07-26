//
//  WXTabBarController.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/26.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXTabBarController.h"

@interface WXTabBarController ()

@end

@implementation WXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *tintColor = [UIColor colorWithRed:0 green:190/255.0 blue:12/255.0 alpha:1];
    
    for (UINavigationController *nav in self.childViewControllers) {
        [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName: tintColor} forState:UIControlStateSelected];
    }
    
    self.tabBar.tintColor = tintColor;
}


@end
