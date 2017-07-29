//
//  WXContactController.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/26.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXContactController.h"
#import "WXContactCell.h"
#import "WXContactDetailController.h"

static NSString *const cellID = @"ContactCellID";

@interface WXContactController () <EMChatManagerDelegate>

@property (strong,nonatomic) NSMutableArray *friendsList;

@end

@implementation WXContactController

- (NSMutableArray *)friendsList {
    if (!_friendsList) {
        _friendsList = [NSMutableArray array];
        NSArray *buddies = [[EaseMob sharedInstance].chatManager buddyList];
        if (buddies.count != 0) {
            [_friendsList addObjectsFromArray:buddies];
        }
    }
    return _friendsList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"通讯录";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"contacts_add_friend"] style:UIBarButtonItemStylePlain target:self action:@selector(addFriendButtonClick)];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WXContactCell class]) bundle:nil] forCellReuseIdentifier:cellID];
    self.tableView.rowHeight = 50;
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
    [self reloadFriendList];
}


- (void)addFriendButtonClick {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"好友申请" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请填写用户username";
        
    }];
    [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请填写验证信息";
    }];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"发送" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        EMError *error = nil;
        [[EaseMob sharedInstance].chatManager addBuddy:alertVC.textFields.firstObject.text message:alertVC.textFields.lastObject.text error:&error];
        if (!error) {
            NSLog(@"发送请求成功");
        }
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertVC addAction:action1];
    [alertVC addAction:action2];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)reloadFriendList {
    [[EaseMob sharedInstance].chatManager asyncFetchBuddyListWithCompletion:^(NSArray *buddyList, EMError *error) {
        if (!error) {
            [self.friendsList removeAllObjects];
            [self.friendsList addObjectsFromArray:buddyList];
            [self.tableView reloadData];
        }
    } onQueue:nil];
    
}

#pragma mark - 监听好友列表改变

- (void)didUpdateBuddyList:(NSArray *)buddyList changedBuddies:(NSArray *)changedBuddies isAdd:(BOOL)isAdd {
    [self.friendsList removeAllObjects];
    [self.friendsList addObjectsFromArray:buddyList];
    [self.tableView reloadData];
}

- (void)didAcceptBuddySucceed:(NSString *)username {
    [self reloadFriendList];
}

- (void)didAcceptedByBuddy:(NSString *)username {
    [self reloadFriendList];
}

- (void)didRemovedByBuddy:(NSString *)username {
    [self reloadFriendList];
}


#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friendsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WXContactCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    EMBuddy *buddy = self.friendsList[indexPath.row];
    cell.buddy = buddy;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        EMBuddy *buddy = self.friendsList[indexPath.row];
        EMError *error = nil;
        [[EaseMob sharedInstance].chatManager removeBuddy:buddy.username removeFromRemote:YES error:&error];
        if (!error) {
            NSLog(@"删除成功");
        }
    }
}

#pragma mark - UITableViewDelegate 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EMBuddy *buddy = self.friendsList[indexPath.row];
    WXContactDetailController *contactDetailVC = [WXContactDetailController contactDetailVC];
    contactDetailVC.buddy = buddy;
    contactDetailVC.title = @"详细资料";
    
    [self.navigationController pushViewController:contactDetailVC animated:YES];
    
}

@end
