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
static char backgroundViewKey;

- (UIView *)backgroundView {
    return objc_getAssociatedObject(self, &backgroundViewKey);
}

- (void)setBackgroundView:(UIView *)backgroundView {
    objc_setAssociatedObject(self, &backgroundViewKey, backgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)cw_setBackgroundColor:(UIColor *)backgroundColor {
    if (!self.backgroundView) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 64)];
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundView.userInteractionEnabled = NO;
        [self insertSubview:self.backgroundView atIndex:0];
    }
    self.backgroundView.backgroundColor = backgroundColor;
}

@end
