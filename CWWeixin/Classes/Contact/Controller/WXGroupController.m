//
//  WXGroupController.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/30.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXGroupController.h"
#import "WXContactCell.h"
#import "WXGroupItem.h"
#import <SVProgressHUD.h>
#import "WXChatDetailController.h"

static NSString *const cellID = @"WXGroupCellID";

@interface WXGroupController ()

@property (strong, nonatomic) NSMutableArray<EMGroup *> *groups;

@end

@implementation WXGroupController

- (NSMutableArray *)groups {
    if (!_groups) {
        _groups = [NSMutableArray array];
        
        NSArray *groupList = [[EaseMob sharedInstance].chatManager groupList];
        if (!groupList.count) {
            groupList = [[EaseMob sharedInstance].chatManager loadAllMyGroupsFromDatabaseWithAppend2Chat:YES];
        }
        [_groups addObjectsFromArray:groupList];
    }
    return _groups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.groups.count) {
        [self reloadGroupList];
    }
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WXContactCell class]) bundle:nil] forCellReuseIdentifier:cellID];
    
    self.tableView.rowHeight = 50;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"建群" style:UIBarButtonItemStylePlain target:self action:@selector(createOneGroup)];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WXContactCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.groupItem = [WXGroupItem itemWithEMGroup:self.groups[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WXChatDetailController *groupChatVC = [WXChatDetailController chatDetailVCWithChatter:[self.groups[indexPath.row] groupId] chatType:eConversationTypeGroupChat];
    
    UITabBarController *tabVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    tabVC.selectedIndex = 0;
    
    UINavigationController *weChatNavVC = tabVC.viewControllers[0];
    [weChatNavVC showViewController:groupChatVC sender:nil];
    
}

- (void)reloadGroupList {
    
    [[EaseMob sharedInstance].chatManager asyncFetchMyGroupsListWithCompletion:^(NSArray *groups, EMError *error) {
        if (!error) {
            [self.groups removeAllObjects];
            [self.groups addObjectsFromArray:groups];
            [self.tableView reloadData];
        }
        
    } onQueue:nil];
}

- (void)createOneGroup {
    
    NSString *username = [[EaseMob sharedInstance].chatManager loginInfo][@"username"];
    
    EMGroupStyleSetting *groupStyleSetting = [[EMGroupStyleSetting alloc] init];
    groupStyleSetting.groupMaxUsersCount = 500;
    groupStyleSetting.groupStyle = eGroupStyle_PublicOpenJoin;
    
    [SVProgressHUD showWithStatus:@"创建中..."];
    [[EaseMob sharedInstance].chatManager asyncCreateGroupWithSubject:[NSString stringWithFormat:@"%@的群组",username]
                                                          description:@"群组描述"
                                                             invitees:nil
                                                initialWelcomeMessage:@"邀请您加入群组"
                                                         styleSetting:groupStyleSetting
                                                           completion:^(EMGroup *group, EMError *error) {
                                                               
                                                               if(!error){
                                                                   [self reloadGroupList];
                                                                   [SVProgressHUD showSuccessWithStatus:@"创建成功"];
                                                                   [SVProgressHUD dismissWithDelay:2.0];
                                                               } else {
                                                                   [SVProgressHUD showErrorWithStatus:@"创建失败"];
                                                                   [SVProgressHUD dismissWithDelay:2.0];
                                                               }
                                                           } onQueue:nil];
}

@end
