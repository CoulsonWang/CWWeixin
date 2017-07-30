//
//  WXContactHeaderItem.h
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/30.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXContactHeaderItem : NSObject

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) UIImage *icon;

@property (strong, nonatomic) NSString *controllerClassName;



+ (instancetype)itemWithtitle:(NSString *)title iconName:(NSString *)iconName controllerClassName:(NSString *)className;

@end
