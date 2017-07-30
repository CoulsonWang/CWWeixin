//
//  WXSessionItem.h
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/30.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXSessionItem : NSObject

@property (strong, nonatomic) UIImage *icon;

@property (strong, nonatomic) NSString *userName;

@property (strong, nonatomic) NSString *lastChat;

@property (strong, nonatomic) NSString *timeStr;

@property (assign, nonatomic) NSUInteger unreadBadgeValue;

+ (instancetype)itemWithConversation:(EMConversation *)conversation;

@end
