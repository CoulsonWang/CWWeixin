//
//  WXContactDetailController.h
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/27.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXContactDetailController : UITableViewController

@property (strong, nonatomic) EMBuddy *buddy;

+ (instancetype)contactDetailVC;

@end
