//
//  WXContactCell.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/26.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXContactCell.h"
#import "WXContactHeaderItem.h"
#import "WXGroupItem.h"

@interface WXContactCell ()
@property (weak, nonatomic) IBOutlet UIImageView *userIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end

@implementation WXContactCell

- (void)setHeaderItem:(WXContactHeaderItem *)headerItem {
    _headerItem = headerItem;
    self.userNameLabel.text = headerItem.title;
    self.userIconImageView.image = headerItem.icon;
}

- (void)setBuddy:(EMBuddy *)buddy {
    _buddy = buddy;
    self.userIconImageView.image = [UIImage imageNamed:@"xhr"];
    self.userNameLabel.text = buddy.username;
}

- (void)setGroupItem:(WXGroupItem *)groupItem {
    _groupItem = groupItem;
    self.userIconImageView.image = groupItem.icon;
    self.userNameLabel.text = groupItem.title;
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
