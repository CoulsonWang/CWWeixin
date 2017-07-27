//
//  WXChatDetailController.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/27.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXChatDetailController.h"
#import "WXInputView.h"

#define kInputViewHeight 43.0

static NSString *const cellID = @"cellID";

@interface WXChatDetailController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) UITableView *chatTableView;

@property (weak, nonatomic) WXInputView *inputView;

@end

@implementation WXChatDetailController

#pragma mark - Lazy Load
- (UIView *)inputView {
    if (!_inputView) {
        WXInputView *inputView = [WXInputView inputView];
        
        inputView.frame = CGRectMake(0, CWScreenH - kInputViewHeight, CWScreenW, kInputViewHeight);
        [self.view addSubview:inputView];
        
        _inputView = inputView;
    }
    
    return _inputView;
}

- (UITableView *)chatTableView {
    if (!_chatTableView) {
        UITableView *chatTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CWScreenW, CWScreenH - kInputViewHeight) style:UITableViewStylePlain];
        chatTableView.dataSource = self;
        chatTableView.delegate = self;
        [self.view addSubview:chatTableView];
        
        _chatTableView = chatTableView;
    }
    return _chatTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.chatTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    self.inputView.tag = 1;
}

#pragma mark - UITableViewDelegate 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    return cell;
}


@end
