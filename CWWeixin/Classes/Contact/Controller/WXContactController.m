//
//  WXContactController.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/26.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXContactController.h"

static NSString *const cellID = @"ContactCellID";

@interface WXContactController ()

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
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
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

#pragma mark - TableViewDelegate 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friendsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    EMBuddy *buddy = self.friendsList[indexPath.row];
    cell.textLabel.text = buddy.username;
    
    return cell;
}

@end
