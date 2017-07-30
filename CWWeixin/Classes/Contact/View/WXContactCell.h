//
//  WXContactCell.h
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/26.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WXContactHeaderItem;
@class WXGroupItem;

@interface WXContactCell : UITableViewCell

@property (strong, nonatomic) EMBuddy *buddy;

@property (strong, nonatomic) WXContactHeaderItem *headerItem;

@property (strong, nonatomic) WXGroupItem *groupItem;

@end
