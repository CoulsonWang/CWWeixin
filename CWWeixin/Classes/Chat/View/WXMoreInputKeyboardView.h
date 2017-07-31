//
//  WXMoreInputKeyboardView.h
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/31.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WXMoreInputKeyboardView;

@protocol WXMoreInputKeyboardViewDelegate <NSObject>

- (void)moreInputKeyboardView:(WXMoreInputKeyboardView *)moreInputKeyboardView didClickButtonAtIndex:(NSInteger)index;

@end

#define kWXMoreInputKeyboardViewHeight 200.0

@interface WXMoreInputKeyboardView : UIView

@property (weak, nonatomic) id<WXMoreInputKeyboardViewDelegate> delegate;

@end
