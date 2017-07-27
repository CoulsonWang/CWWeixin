//
//  WXLongPressButton.h
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/27.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WXLongPressButton;
typedef void(^WXLongPressBlock)(WXLongPressButton *);

@interface WXLongPressButton : UIButton

@property (copy, nonatomic) WXLongPressBlock operation;

@end
