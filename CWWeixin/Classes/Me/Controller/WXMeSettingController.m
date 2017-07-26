//
//  WXMeSettingController.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/26.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXMeSettingController.h"
#import "WXLogRegistController.h"

@interface WXMeSettingController ()

@end

@implementation WXMeSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)logoutButtonClick:(UIButton *)sender {
    [[NSUserDefaults standardUserDefaults] setObject:[[EaseMob sharedInstance].chatManager loginInfo][@"username"] forKey:@"username"];
    [[EaseMob sharedInstance].chatManager asyncLogoffWithUnbindDeviceToken:YES completion:^(NSDictionary *info, EMError *error) {
        if (!error) {
            NSLog(@"退出登陆成功");
            
            UIApplication.sharedApplication.keyWindow.rootViewController = [[WXLogRegistController alloc] init];
        } else {
            NSLog(@"退出登录失败");
        }
    } onQueue:nil];
}

@end
