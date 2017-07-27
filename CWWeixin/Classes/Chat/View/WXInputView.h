//
//  WXInputView.h
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/27.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXInputView : UIView

@property (weak, nonatomic) IBOutlet UITextField *textField;

+ (instancetype)inputView;

@end
