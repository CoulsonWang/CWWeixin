//
//  WXMoreInputKeyboardView.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/31.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXMoreInputKeyboardView.h"

@interface WXMoreInputKeyboardView ()

@property (weak, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *buttons;

@property (strong, nonatomic) NSArray *btnTitles;

@end

@implementation WXMoreInputKeyboardView

- (NSArray *)btnTitles {
    if (!_btnTitles) {
        _btnTitles = @[@"图片",@"语音聊天"];
    }
    return _btnTitles;
}

- (NSMutableArray *)buttons {
    if (!_buttons) {
        NSMutableArray *buttons = [NSMutableArray array];
        _buttons = buttons;
    }
    return _buttons;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        for (NSString *title in self.btnTitles) {
            [self setUpOneButtonWithTitle:title];
        }
        self.backgroundColor = [UIColor grayColor];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat btnW = 60;
    CGFloat btnH = btnW;
    CGFloat edgeX = 10;
    CGFloat edgeY = 10;
    
    NSInteger maxRow = 2;
    NSInteger maxColum = 4;
    
    CGFloat colMargin = (CWScreenW - 2 * edgeX - maxColum * btnW) / (maxColum - 1);
    CGFloat rowMargin = (self.bounds.size.height - 2 * edgeY - maxRow * btnH) / (maxRow - 1);
    
    NSInteger index = 0;
    for (UIButton *btn in self.buttons) {
        NSInteger colum = index % maxColum;
        NSInteger row = index / maxRow;
        
        btn.frame = CGRectMake(edgeX + colum * (btnW + colMargin), edgeY + row * (btnH + rowMargin), btnW, btnH);
        
        index += 1;
    }
    
}

- (void)setUpOneButtonWithTitle:(NSString *)title {
    
    static int i = 0;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.tag = ++i;
    [btn addTarget:self action:@selector(moreInputButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.buttons addObject:btn];
    [self addSubview:btn];
}

- (void)moreInputButtonClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(moreInputKeyboardView:didClickButtonAtIndex:)]) {
        [self.delegate moreInputKeyboardView:self didClickButtonAtIndex:btn.tag];
    }
}

@end
