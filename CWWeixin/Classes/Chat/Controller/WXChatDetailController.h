//
//  WXChatDetailController.h
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/27.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXChatDetailController : UIViewController


@property (strong, nonatomic) NSString *chatter;

@property (assign, nonatomic) EMConversationType chatType;


+ (instancetype)chatDetailVCWithChatter:(NSString *)chatter chatType:(EMConversationType)type;

@end
