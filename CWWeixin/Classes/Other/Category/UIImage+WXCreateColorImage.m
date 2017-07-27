//
//  UIImage+WXCreateColorImage.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/27.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "UIImage+WXCreateColorImage.h"

@implementation UIImage (WXCreateColorImage)

+ (instancetype)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1.0, 1.0);
    UIGraphicsBeginImageContext(rect.size);
    [color setFill];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
