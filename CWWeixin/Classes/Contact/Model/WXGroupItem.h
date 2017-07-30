//
//  WXGroupItem.h
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/30.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXGroupItem : NSObject

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) UIImage *icon;

+ (instancetype)itemWithEMGroup:(EMGroup *)group;

@end
