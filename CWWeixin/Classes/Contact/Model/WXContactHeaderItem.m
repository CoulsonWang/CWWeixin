//
//  WXContactHeaderItem.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/30.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXContactHeaderItem.h"

@implementation WXContactHeaderItem


+ (instancetype)itemWithtitle:(NSString *)title iconName:(NSString *)iconName controllerClassName:(NSString *)className {
    WXContactHeaderItem *item = [[WXContactHeaderItem alloc] init];
    item.title = title;
    item.icon = [UIImage imageNamed:iconName];
    item.controllerClassName = className;
    
    return item;
}

@end
