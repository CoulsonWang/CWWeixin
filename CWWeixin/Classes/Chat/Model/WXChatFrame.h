//
//  WXChatFrame.h
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/27.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kTimeFont [UIFont systemFontOfSize:12.0]
#define kContentTextFont [UIFont systemFontOfSize:16.0]

@class WXChatItem;

@interface WXChatFrame : NSObject

@property (strong, nonatomic) WXChatItem *item;

@property (assign, nonatomic, readonly) CGRect timeFrame;

@property (assign, nonatomic, readonly) CGRect userIconFrame;

@property (assign, nonatomic, readonly) CGRect contentFrame;

@property (assign, nonatomic, readonly) CGFloat rowHeight;

@end
