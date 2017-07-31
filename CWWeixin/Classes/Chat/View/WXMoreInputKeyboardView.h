//
//  WXMoreInputKeyboardView.h
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/31.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    WXMoreInputTypeImage,
    WXMoreInputTypeVoiceTalk,
} WXMoreInputType;

@class WXMoreInputKeyboardView;

@protocol WXMoreInputKeyboardViewDelegate <NSObject>


- (void)moreInputKeyboardView:(WXMoreInputKeyboardView *)moreInputKeyboardView didClickButtonOfType:(WXMoreInputType)type;

@end

#define kWXMoreInputKeyboardViewHeight 200.0

@interface WXMoreInputKeyboardView : UIView

@property (weak, nonatomic) id<WXMoreInputKeyboardViewDelegate> delegate;

@end
