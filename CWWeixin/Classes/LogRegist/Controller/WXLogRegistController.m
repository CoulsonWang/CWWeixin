//
//  WXLogRegistController.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/26.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXLogRegistController.h"
#import <SVProgressHUD.h>

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
    [SVProgressHUD showWithStatus:@"正在注册..."];
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:self.userNameTF.text password:self.passwordTF.text withCompletion:^(NSString *username, NSString *password, EMError *error) {
        [SVProgressHUD dismiss];
        if (!error) {
            [SVProgressHUD showSuccessWithStatus:@"注册成功!"];
        } else {
            [SVProgressHUD showErrorWithStatus:@"注册失败!"];
        }
    } onQueue:nil];
}

- (IBAction)loginButtonClick:(UIButton *)sender {
    [SVProgressHUD showWithStatus:@"登录中..."];
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:self.userNameTF.text password:self.passwordTF.text completion:^(NSDictionary *loginInfo, EMError *error) {
        [SVProgressHUD dismiss];
        if (!error && loginInfo) {
            [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
            UIApplication.sharedApplication.keyWindow.rootViewController = MainStoryBoard.instantiateInitialViewController;
        } else {
            [SVProgressHUD showErrorWithStatus:@"登录失败!"];
        }
    } onQueue:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [SVProgressHUD dismiss];
}


@end
