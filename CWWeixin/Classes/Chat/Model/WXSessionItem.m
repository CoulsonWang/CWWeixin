//
//  WXSessionItem.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/30.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXSessionItem.h"
#import "NSString+WXTimestamp.h"

@implementation WXSessionItem

+ (instancetype)itemWithConversation:(EMConversation *)conversation {
    WXSessionItem *item = [[WXSessionItem alloc] init];
    item.icon = [UIImage imageNamed:@"add_friend_icon_offical"];
    item.userName = conversation.chatter;
    
    item.unreadBadgeValue = [[EaseMob sharedInstance].chatManager unreadMessagesCountForConversation:conversation.chatter];
    
    EMMessage *msg = [conversation latestMessage];
    if (!msg) {
        item.lastChat = nil;
        item.timeStr = nil;
    } else {
        // 设置时间标签
        item.timeStr = [NSString convastionTimeStr:msg.timestamp];
        
        // 设置最近聊天内容
        id<IEMFileMessageBody> body = msg.messageBodies.lastObject;
        MessageBodyType type = body.messageBodyType;
        switch (type) {
            case eMessageBodyType_Text:
                item.lastChat = ((EMTextMessageBody *)body).text;
                break;
            case eMessageBodyType_Image:
                item.lastChat = @"[图片]";
                break;
            case eMessageBodyType_Video:
                item.lastChat = @"[视频]";
                break;
            case eMessageBodyType_Voice:
                item.lastChat = @"[语音消息]";
                break;
            default:
                break;
        }
    }
    return item;
}

@end
