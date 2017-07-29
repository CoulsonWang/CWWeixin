//
//  WXInputView.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/27.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXInputView.h"
#import "UIImage+WXCreateColorImage.h"

typedef enum : NSUInteger {
    WXInputStyleText,
    WXInputStyleVoice,
} WXInputStyle;



@interface WXInputView ()

@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end

@implementation WXInputView

+ (instancetype)inputView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.voiceButton.hidden = YES;
    [self.voiceButton setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateHighlighted];
    self.voiceButton.layer.borderWidth = 0.5;
    self.voiceButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.voiceButton.layer.cornerRadius = 5;
    self.voiceButton.layer.masksToBounds = YES;
}
- (IBAction)emoticonButtonClick:(UIButton *)sender {
    
}

- (IBAction)moreButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(inputView:moreBtnDidClickWithStyle:)]) {
        [self.delegate inputView:self moreBtnDidClickWithStyle:WXInputViewMoreStyleImage];
    }
}
- (IBAction)changeInputTypeButtonClick:(UIButton *)sender {
    
    sender.selected = !sender.isSelected;
    
    self.textField.hidden = sender.isSelected;
    if (sender.selected) {
        [self.textField resignFirstResponder];
    } else {
        [self.textField becomeFirstResponder];
    }
    
    self.voiceButton.hidden = !sender.isSelected;
}

#pragma mark - 语音按钮事件
- (IBAction)voiceTouchDown:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(inputView:voiceChangeStatus:)]) {
        [self.delegate inputView:self voiceChangeStatus:WXInputVoiceStatusSpeaking];
    }
}
- (IBAction)voiceTouchUpInside:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(inputView:voiceChangeStatus:)]) {
        [self.delegate inputView:self voiceChangeStatus:WXInputVoiceStatusSent];
    }
}
- (IBAction)voiceTouchUpOutside:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(inputView:voiceChangeStatus:)]) {
        [self.delegate inputView:self voiceChangeStatus:WXInputVoiceStatusCancled];
    }
}
- (IBAction)voiceTouchDragOutside:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(inputView:voiceChangeStatus:)]) {
        [self.delegate inputView:self voiceChangeStatus:WXInputVoiceStatusWillCancle];
    }
}
- (IBAction)voiceTouchDragInside:(UIButton *)sender {
    
}


@end
