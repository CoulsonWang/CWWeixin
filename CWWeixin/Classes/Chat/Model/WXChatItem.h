//
//  WXChatItem.h
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/27.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    WXChatTypeText = eMessageBodyType_Text,
    WXChatTypeImage = eMessageBodyType_Image,
    WXChatTypeLocation = eMessageBodyType_Location,
    WXChatTypeVoice = eMessageBodyType_Voice,
    WXChatTypeVideo = eMessageBodyType_Video,
    WXChatTypeFile = eMessageBodyType_File
} WXChatType;

@interface WXChatItem : NSObject

@property (strong, nonatomic) EMMessage *message;



// 文本聊天内容属性
@property (strong, nonatomic, readonly) NSString *contentText;

// 图片聊天内容属性
@property (strong, nonatomic, readonly) UIImage *contentImage;
@property (strong, nonatomic, readonly) UIImage *contentThumbnailImage;
@property (strong, nonatomic, readonly) NSURL *contentImageUrl;
@property (strong, nonatomic, readonly) NSURL *contentThumbnailImageUrl;
@property (assign, nonatomic, getter=isVertical, readonly) BOOL vertical;

// 语音聊天内容属性
@property (assign, nonatomic, readonly) NSUInteger voiceDuration;
@property (strong, nonatomic, readonly) NSURL *voicePath;

// 聊天类型
@property (assign, nonatomic, readonly) WXChatType chatType;

@property (strong, nonatomic, readonly) NSString *userIcon;

@property (strong, nonatomic, readonly) NSString *timeStr;
@property (assign, nonatomic) long long preTimestamp;

@property (assign, nonatomic, readonly, getter=isShowTime) BOOL showTime;
@property (assign, nonatomic, getter=isMe, readonly) BOOL me;

@property (strong, nonatomic, readonly) UIImage *contentTextBackgroundImage;

@property (strong, nonatomic, readonly) UIImage *contentTextBackgroundHighlightImage;

@end
