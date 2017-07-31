//
//  WXInputView.h
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/27.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    WXInputViewMoreStyleImage,
    WXInputViewMoreStyleLocation,
    WXInputViewMoreStyleVideo,
} WXInputViewMoreStyle;
typedef enum : NSUInteger {
    WXInputVoiceStatusSpeaking,
    WXInputVoiceStatusWillCancle,
    WXInputVoiceStatusSent,
    WXInputVoiceStatusCancled,
} WXInputVoiceStatus;
typedef enum : NSUInteger {
    WXInputTypeText,
    WXInputTypeVoice,
} WXInputType;

@class WXInputView;

@protocol WXInputViewDelegate <NSObject>

@optional
- (void)inputViewMoreBtnDidClick:(WXInputView *)inputView;
- (void)inputView:(WXInputView *)inputView voiceChangeStatus:(WXInputVoiceStatus)status;

@end

@interface WXInputView : UIView

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) id<WXInputViewDelegate> delegate;

@property (assign, nonatomic) WXInputType currentInputType;

+ (instancetype)inputView;

@end
