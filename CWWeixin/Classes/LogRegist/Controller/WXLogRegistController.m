//
//  WXLogRegistController.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/26.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXLogRegistController.h"

@interface WXLogRegistController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;

@end

@implementation WXLogRegistController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *lastUserName = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
    self.userNameTF.text = lastUserName;
}

- (IBAction)registButtonClick:(UIButton *)sender {
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:self.userNameTF.text password:self.passwordTF.text withCompletion:^(NSString *username, NSString *password, EMError *error) {
        if (!error) {
            NSLog(@"注册成功");
        } else {
            NSLog(@"注册失败,失败信息：%@",error);
        }
    } onQueue:nil];
}

- (IBAction)loginButtonClick:(UIButton *)sender {
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:self.userNameTF.text password:self.passwordTF.text completion:^(NSDictionary *loginInfo, EMError *error) {
        if (!error && loginInfo) {
            NSLog(@"登陆成功");
            [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
            UIApplication.sharedApplication.keyWindow.rootViewController = MainStoryBoard.instantiateInitialViewController;
        } else {
            NSLog(@"登录失败");
        }
    } onQueue:nil];
}


@end
