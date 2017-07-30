//
//  WXChatController.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/26.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXChatController.h"
#import "WXSessionCell.h"
#import "WXSessionItem.h"
#import "WXChatDetailController.h"

NSString *const WXChatTitleNormal = @"微信";
NSString *const WXChatTitleWillConnect = @"连接中...";
NSString *const WXChatTitleDisconnect = @"微信(未连接)";
NSString *const WXChatTitleWillReceiveMsg = @"收取中...";

static NSString *const cellID = @"WXSessionCellID";

@interface WXChatController () <EMChatManagerDelegate>

@property (strong, nonatomic) NSMutableArray<EMConversation *> *conversations;

@property (assign, nonatomic) NSUInteger lastUnreadMessagesCount;

@end

@implementation WXChatController

#pragma mark - 懒加载

- (NSMutableArray *)conversations {
    if (!_conversations) {
        _conversations = [[NSMutableArray alloc] init];
        // 获取内存中的列表
        NSArray *allConvs = [[EaseMob sharedInstance].chatManager conversations];
        [_conversations addObjectsFromArray:allConvs];
    }
    return _conversations;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = WXChatTitleNormal;
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WXSessionCell class]) bundle:nil] forCellReuseIdentifier:cellID];
    self.tableView.rowHeight = 80;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadConversations];
    [self updateBadgeValue];
}


- (void)dealloc {
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

#pragma mark - 私有方法

- (void)reloadConversations {
    [self.conversations removeAllObjects];
    __block NSArray *conversations;
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        conversations = [[EaseMob sharedInstance].chatManager loadAllConversationsFromDatabaseWithAppend2Chat:YES];
        dispatch_group_leave(group);
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self.conversations addObjectsFromArray:conversations];
        [self.tableView reloadData];
    });
}

- (void)updateBadgeValue {
    __block NSInteger unreadMsgCount;
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        unreadMsgCount = [[EaseMob sharedInstance].chatManager loadTotalUnreadMessagesCountFromDatabase];
        dispatch_group_leave(group);
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSString *badgeValue = (unreadMsgCount > 0) ? [NSString stringWithFormat:@"%ld",unreadMsgCount] : nil;
        self.navigationController.tabBarItem.badgeValue = badgeValue;
    });
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.conversations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WXSessionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    WXSessionItem *item = [WXSessionItem itemWithConversation:self.conversations[indexPath.row]];
    cell.item = item;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EMConversation *conv = self.conversations[indexPath.row];
    
    WXChatDetailController *detailVC = [WXChatDetailController chatDetailVCWithChatter:conv.chatter chatType:conv.conversationType];
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - EMChatManagerDelegate

- (void)willAutoReconnect {
    self.title = WXChatTitleWillConnect;
}

- (void)didAutoReconnectFinishedWithError:(NSError *)error {
    if (!error) {
        self.title = WXChatTitleNormal;
    }else {
        self.title = WXChatTitleDisconnect;
    }
}

- (void)didConnectionStateChanged:(EMConnectionState)connectionState {
    switch (connectionState) {
        case eEMConnectionConnected:
            self.title = WXChatTitleNormal;
            break;
        case eEMConnectionDisconnected:
            self.title = WXChatTitleDisconnect;
            break;
        default:
            break;
    }
}

- (void)didUnreadMessagesCountChanged {
    [self reloadConversations];
    [self updateBadgeValue];
}


@end
