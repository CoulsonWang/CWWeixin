//
//  WXChatController.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/26.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXChatController.h"
#import "WXSessionCell.h"
#import "WXChatDetailController.h"

NSString *const WXChatTitleNormal = @"微信";
NSString *const WXChatTitleWillConnect = @"连接中...";
NSString *const WXChatTitleDisconnect = @"微信(未连接)";
NSString *const WXChatTitleWillReceiveMsg = @"收取中...";

static NSString *const cellID = @"WXSessionCellID";

@interface WXChatController () <EMChatManagerDelegate>

@property (strong, nonatomic) NSMutableArray<EMConversation *> *conversations;

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
    
    [self reloadConversations];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateBadgeValue];
}

- (void)dealloc {
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

#pragma mark - 私有方法

- (void)reloadConversations {
    [self.conversations removeAllObjects];
    NSArray *conversations = [[EaseMob sharedInstance].chatManager loadAllConversationsFromDatabaseWithAppend2Chat:YES];
    [self.conversations addObjectsFromArray:conversations];
    
    [self.tableView reloadData];
}

- (void)updateBadgeValue {
    NSInteger unreadMsgCount = [[EaseMob sharedInstance].chatManager loadTotalUnreadMessagesCountFromDatabase];
    NSString *badgeValue = (unreadMsgCount > 0) ? [NSString stringWithFormat:@"%ld",unreadMsgCount] : nil;
    self.navigationController.tabBarItem.badgeValue = badgeValue;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.conversations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WXSessionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.textLabel.text = self.conversations[indexPath.row].chatter;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WXChatDetailController *detailVC = [[WXChatDetailController alloc] init];
    
    EMConversation *conv = self.conversations[indexPath.row];
    detailVC.userName = conv.chatter;
    detailVC.hidesBottomBarWhenPushed = YES;
    
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

- (void)didUpdateConversationList:(NSArray *)conversationList {
    [self reloadConversations];
}

@end
