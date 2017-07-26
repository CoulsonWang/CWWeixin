//
//  WXContactCell.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/26.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXContactCell.h"

@interface WXContactCell ()
@property (weak, nonatomic) IBOutlet UIImageView *userIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end

@implementation WXContactCell

- (void)setBuddy:(EMBuddy *)buddy {
    _buddy = buddy;
    self.userIconImageView.image = [UIImage imageNamed:@"add_friend_icon_offical"];
    self.userNameLabel.text = buddy.username;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
