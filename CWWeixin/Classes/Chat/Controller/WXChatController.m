//
//  WXChatController.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/26.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXChatController.h"

NSString *const WXChatTitleNormal = @"微信";
NSString *const WXChatTitleWillConnect = @"连接中...";
NSString *const WXChatTitleDisconnect = @"微信(未连接)";
NSString *const WXChatTitleWillReceiveMsg = @"收取中...";

@interface WXChatController () <EMChatManagerDelegate>

@end

@implementation WXChatController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = WXChatTitleNormal;
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

- (void)dealloc {
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
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

@end
