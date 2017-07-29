//
//  WXChatCell.h
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/27.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXChatItem.h"

@class WXChatCell;

@protocol WXChatCellDelegate <NSObject>

@optional
- (void)chatCell:(WXChatCell *)chatCell contentDidClick:(WXChatType)chatType;

@end

@class WXChatFrame;

@interface WXChatCell : UITableViewCell

@property (strong, nonatomic) WXChatFrame *chatFrame;

@property (weak, nonatomic) id<WXChatCellDelegate> delegate;

@end
