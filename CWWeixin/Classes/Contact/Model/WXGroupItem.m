//
//  WXGroupItem.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/30.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXGroupItem.h"

@implementation WXGroupItem

+ (instancetype)itemWithEMGroup:(EMGroup *)group {
    WXGroupItem *item = [[WXGroupItem alloc] init];
    item.title = group.groupSubject;
    item.icon = [UIImage imageNamed:@"add_friend_icon_addgroup"];
    
    return item;
}

@end
