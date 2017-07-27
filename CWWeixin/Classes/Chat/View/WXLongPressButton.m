//
//  WXLongPressButton.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/27.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXLongPressButton.h"

@implementation WXLongPressButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonDidLongPress:)];
        longPress.minimumPressDuration = 0.5;
        [self addGestureRecognizer:longPress];
        
        
    }
    
    return self;
}

- (void)buttonDidLongPress:(UILongPressGestureRecognizer *)longPress {
    if (self.operation) {
        self.operation(self);
    }
}

@end
