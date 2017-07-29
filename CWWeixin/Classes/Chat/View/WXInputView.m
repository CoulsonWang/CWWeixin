//
//  WXInputView.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/27.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXInputView.h"

@implementation WXInputView

+ (instancetype)inputView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}
- (IBAction)emoticonButtonClick:(UIButton *)sender {
}

- (IBAction)moreButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(inputView:moreBtnDidClickWithStyle:)]) {
        [self.delegate inputView:self moreBtnDidClickWithStyle:WXInputViewMoreStyleImage];
    }
}
- (IBAction)changeInputTypeButtonClick:(UIButton *)sender {
}

@end
