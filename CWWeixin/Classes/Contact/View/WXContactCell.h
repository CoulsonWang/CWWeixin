//
//  WXContactCell.h
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/26.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WXContactHeaderItem;

@interface WXContactCell : UITableViewCell

@property (strong, nonatomic) EMBuddy *buddy;

@property (strong, nonatomic) WXContactHeaderItem *headerItem;

@end
