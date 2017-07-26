//
//  WXMeController.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/26.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXMeController.h"

@interface WXMeController ()
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *weixinNumberLabel;

@end

@implementation WXMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.userNameLabel.text = [[EaseMob sharedInstance].chatManager loginInfo][@"username"];
}



@end
