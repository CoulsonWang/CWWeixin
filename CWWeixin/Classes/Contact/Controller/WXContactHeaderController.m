//
//  WXContactHeaderController.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/30.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXContactHeaderController.h"
#import "WXContactHeaderItem.h"
#import "WXContactCell.h"

#define kMarginTop 0
#define kMarginBottom 10.0

static NSString *const cellID = @"WXContactHeaderCellID";

@interface WXContactHeaderController ()

@property (strong, nonatomic) NSArray<WXContactHeaderItem *> *headerItems;

@end

@implementation WXContactHeaderController

- (CGFloat)viewHeight {
    CGFloat cellHeight = self.headerItems.count * self.tableView.rowHeight;
    return cellHeight + kMarginTop + kMarginBottom;
}

- (NSArray *)headerItems {
    if (!_headerItems) {
        WXContactHeaderItem *item1 = [WXContactHeaderItem itemWithtitle:@"新的朋友" iconName:@"plugins_FriendNotify" controllerClassName:@"UIViewController"];
        WXContactHeaderItem *item2 = [WXContactHeaderItem itemWithtitle:@"群聊" iconName:@"add_friend_icon_addgroup" controllerClassName:@"WXGroupController"];
        WXContactHeaderItem *item3 = [WXContactHeaderItem itemWithtitle:@"标签" iconName:@"Contact_icon_ContactTag" controllerClassName:@"UIViewController"];
        WXContactHeaderItem *item4 = [WXContactHeaderItem itemWithtitle:@"公众号" iconName:@"add_friend_icon_offical" controllerClassName:@"UIViewController"];
        _headerItems = @[item1,item2,item3,item4];
    }
    return _headerItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WXContactCell class]) bundle:nil] forCellReuseIdentifier:cellID];
    self.tableView.rowHeight = 50;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.headerItems.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WXContactCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.headerItem = self.headerItems[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class contorllerClass = NSClassFromString(self.headerItems[indexPath.row].controllerClassName);
    UIViewController *vc = [[contorllerClass alloc] init];
    
    [self.parentViewController.navigationController showViewController:vc sender:nil];
}

@end
