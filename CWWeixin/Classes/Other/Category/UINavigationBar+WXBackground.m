//
//  UINavigationBar+WXBackground.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/26.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "UINavigationBar+WXBackground.h"
#import <objc/message.h>

@implementation UINavigationBar (WXBackground)

- (void)cw_setBackgroundColor:(UIColor *)backgroundColor {
    
    CGRect rect = CGRectMake(0, 0, CWScreenW, 64);
    UIGraphicsBeginImageContext(rect.size);
    [backgroundColor setFill];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

@end
