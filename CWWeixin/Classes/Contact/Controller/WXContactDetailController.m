//
//  WXContactDetailController.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/27.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXContactDetailController.h"
#import "UIImage+WXCreateColorImage.h"

@interface WXContactDetailController ()
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end

@implementation WXContactDetailController

+ (instancetype)contactDetailVC {
    return [UIStoryboard storyboardWithName:NSStringFromClass(self) bundle:nil].instantiateInitialViewController;
}

- (void)setBuddy:(EMBuddy *)buddy {
    _buddy = buddy;
    self.userNameLabel.text = buddy.username;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addMsgButton];
}

#pragma mark - 添加发送消息按钮

- (void)addMsgButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    button.frame = CGRectMake(30, 0, self.view.bounds.size.width - 60, 44);
    
    [button addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:28/255.0 green:188/255.0 blue:36/255.0 alpha:1]] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"发消息" forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    [self.tableView.tableFooterView addSubview:button];
}

- (void)sendMessage {
    // 进入聊天界面
}

@end
