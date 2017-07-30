//
//  WXSessionBadgeView.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/30.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXSessionBadgeView.h"

@interface WXSessionBadgeView ()

@property (weak, nonatomic) UILabel *badgeValueLabel;

@end

@implementation WXSessionBadgeView

- (UILabel *)badgeValueLabel {
    if (!_badgeValueLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
        _badgeValueLabel = label;
    }
    return _badgeValueLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor redColor];
    self.layer.cornerRadius = self.frame.size.width * 0.5;
    self.layer.masksToBounds = YES;
    self.hidden = YES;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setBadgeValue:(NSUInteger)badgeValue {
    _badgeValue = badgeValue;
    
    self.hidden = (badgeValue == 0);
    
    self.badgeValueLabel.text = (badgeValue > 0) ?[NSString stringWithFormat:@"%ld",badgeValue] : nil;
}

@end
