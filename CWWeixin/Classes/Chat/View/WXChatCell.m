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
#import <SDWebImageManager.h>
#import <UIButton+WebCache.h>
#import "WXMusicTool.h"

@interface WXChatCell ()

@property (weak, nonatomic) UILabel *timeLabel;

@property (weak, nonatomic) WXLongPressButton *userIconButton;

@property (weak, nonatomic) WXLongPressButton *contentButton;

@property (weak, nonatomic) UILabel *durationLabel;

@end

@implementation WXChatCell

- (void)setChatFrame:(WXChatFrame *)chatFrame {
    _chatFrame = chatFrame;
    
    WXChatItem *item = chatFrame.item;
    self.timeLabel.text = item.timeStr;
    [self.userIconButton setImage:[UIImage imageNamed:item.userIcon] forState:UIControlStateNormal];
    [self.contentButton setBackgroundImage:[item.contentTextBackgroundImage imageWithStretch] forState:UIControlStateNormal];
    [self.contentButton setBackgroundImage:[item.contentTextBackgroundHighlightImage imageWithStretch] forState:UIControlStateHighlighted];
    self.durationLabel.hidden = (item.chatType != WXChatTypeVoice);
    [self.contentButton setImage:nil forState:UIControlStateNormal];
    switch (item.chatType) {
        case WXChatTypeText:{
            [self.contentButton setTitle:item.contentText forState:UIControlStateNormal];
        }
            break;
        case WXChatTypeImage:{
            if (item.contentThumbnailImage) {
                [self.contentButton setImage:item.contentThumbnailImage forState:UIControlStateNormal];
            } else {
                [self.contentButton sd_setImageWithURL:item.contentThumbnailImageUrl forState:UIControlStateNormal];
            }
        }
            break;
        case WXChatTypeVoice:{
            [self.contentButton setImage:item.voiceImage forState:UIControlStateNormal];
            self.durationLabel.text = [NSString stringWithFormat:@"%ld\"",item.voiceDuration];
        }
            break;
        default:
            break;
    }
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
        
        
        UILabel *durationLabel = [[UILabel alloc] init];
        durationLabel.textColor = [UIColor lightGrayColor];
        durationLabel.font = kTimeFont;
        durationLabel.textAlignment = NSTextAlignmentCenter;
        durationLabel.hidden = YES;
        [self.contentView addSubview:durationLabel];
        self.durationLabel = durationLabel;

    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.timeLabel.frame = self.chatFrame.timeFrame;
    
    self.userIconButton.frame = self.chatFrame.userIconFrame;
    
    self.contentButton.frame = self.chatFrame.contentFrame;
    
    self.durationLabel.frame = self.chatFrame.durationFrame;
    
    
    CGFloat sideEdge = self.chatFrame.contentFrame.size.width * 0.04;
    self.contentButton.contentEdgeInsets = UIEdgeInsetsMake(-10, sideEdge, 0, sideEdge);
}

#pragma mark - 私有方法
- (void)showUserDetail {
    
}

- (void)contentDidClick {
    switch (self.chatFrame.item.chatType) {
        case WXChatTypeText:
        {
            
        }
            break;
        case WXChatTypeImage:
        {
            if ([self.delegate respondsToSelector:@selector(chatCell:contentDidClick:)]) {
                [self.delegate chatCell:self contentDidClick:WXChatTypeImage];
            }
        }
            break;
        case WXChatTypeVoice:
        {
            if ([WXMusicTool sharedInstance].isPlaying) {
                [[WXMusicTool sharedInstance] stopPlaying];
            } else {
                [[WXMusicTool sharedInstance] playVoice:self.chatFrame.item.voicePath];
            }
        }
            break;
        default:
            break;
    }
}

@end
