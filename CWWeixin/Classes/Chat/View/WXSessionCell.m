//
//  WXSessionCell.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/30.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXSessionCell.h"
#import "WXSessionItem.h"
#import "WXSessionBadgeView.h"

@interface WXSessionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastChatLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet WXSessionBadgeView *badgeView;

@end

@implementation WXSessionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconImageView.layer.cornerRadius = self.iconImageView.bounds.size.width * 0.05;
    self.iconImageView.layer.masksToBounds = YES;
}


- (void)setItem:(WXSessionItem *)item {
    _item = item;
    self.iconImageView.image = item.icon;
    self.userNameLabel.text = item.userName;
    self.lastChatLabel.text = item.lastChat;
    self.timeLabel.text = item.timeStr;
    self.badgeView.badgeValue = item.unreadBadgeValue;
}


@end
