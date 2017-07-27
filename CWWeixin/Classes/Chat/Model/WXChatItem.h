//
//  WXChatItem.h
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/27.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXChatItem : NSObject

@property (strong, nonatomic) EMMessage *message;

@property (strong, nonatomic, readonly) NSString *contentText;

@property (strong, nonatomic, readonly) NSString *userIcon;

@property (strong, nonatomic, readonly) NSString *timeStr;

@property (assign, nonatomic, getter=isMe, readonly) BOOL me;

@property (strong, nonatomic, readonly) UIImage *contentTextBackgroundImage;

@property (strong, nonatomic, readonly) UIImage *contentTextBackgroundHighlightImage;

@end
