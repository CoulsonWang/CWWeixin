//
//  WXVoiceCallController.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/31.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXVoiceCallController.h"
#import "UIView+CWFrame.h"

@interface WXVoiceCallController ()
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancleButton;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation WXVoiceCallController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cancleButton.layer.cornerRadius = self.iconImageView.width * 0.5;
    self.cancleButton.layer.masksToBounds = YES;
}

- (IBAction)cancleButtonClick:(UIButton *)sender {
}


@end
