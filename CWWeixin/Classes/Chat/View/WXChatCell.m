//
//  WXChatCell.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/27.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXChatCell.h"
#import "WXChatFrame.h"
#import "WXChatItem.h"
#import "WXLongPressButton.h"
#import "UIImage+WXCreateColorImage.h"

@interface WXChatCell ()

@property (weak, nonatomic) UILabel *timeLabel;

@property (weak, nonatomic) WXLongPressButton *userIconButton;

@property (weak, nonatomic) WXLongPressButton *contentButton;

@end

@implementation WXChatCell

- (void)setChatFrame:(WXChatFrame *)chatFrame {
    _chatFrame = chatFrame;
    
    WXChatItem *item = chatFrame.item;
    self.timeLabel.text = item.timeStr;
    [self.userIconButton setImage:[UIImage imageNamed:item.userIcon] forState:UIControlStateNormal];
    [self.contentButton setTitle:item.contentText forState:UIControlStateNormal];
    [self.contentButton setBackgroundImage:[item.contentTextBackgroundImage imageWithStretch] forState:UIControlStateNormal];
    [self.contentButton setBackgroundImage:[item.contentTextBackgroundHighlightImage imageWithStretch] forState:UIControlStateHighlighted];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        UILabel *timeLable = [[UILabel alloc] init];
        timeLable.backgroundColor = [UIColor lightGrayColor];
        timeLable.textColor = [UIColor whiteColor];
        timeLable.layer.cornerRadius = 3;
        timeLable.layer.masksToBounds = YES;
        timeLable.font = kTimeFont;
        timeLable.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:timeLable];
        self.timeLabel = timeLable;
        
        // 添加头像
        WXLongPressButton *userIconButton = [WXLongPressButton buttonWithType:UIButtonTypeCustom];
        userIconButton.operation = ^(WXLongPressButton *btn) {
            
        };
        [userIconButton addTarget:self action:@selector(showUserDetail) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:userIconButton];
        self.userIconButton = userIconButton;
        
        // 添加对话框
        WXLongPressButton *contentButton = [WXLongPressButton buttonWithType:UIButtonTypeCustom];
        contentButton.titleLabel.font = kContentTextFont;
        [contentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        contentButton.titleLabel.numberOfLines = 0;
        contentButton.operation = ^(WXLongPressButton *btn) {
            
        };
        [contentButton addTarget:self action:@selector(contentDidClick) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:contentButton];
        self.contentButton = contentButton;

    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.timeLabel.frame = self.chatFrame.timeFrame;
    self.userIconButton.frame = self.chatFrame.userIconFrame;
    
    self.contentButton.frame = self.chatFrame.contentFrame;
    CGFloat sideEdge = self.chatFrame.contentFrame.size.width * 0.04;
    self.contentButton.titleEdgeInsets = UIEdgeInsetsMake(-10, sideEdge, 0, sideEdge);
}

#pragma mark - 私有方法
- (void)showUserDetail {
    
}

- (void)contentDidClick {
    
}

@end
