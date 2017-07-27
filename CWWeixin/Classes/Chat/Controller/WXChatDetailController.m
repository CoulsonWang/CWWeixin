//
//  WXChatDetailController.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/27.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXChatDetailController.h"
#import "WXInputView.h"

#define kInputViewHeight 44.0

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
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabbar_me"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItem)];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillChangeFrameNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        NSTimeInterval duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        CGFloat endY = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
        CGFloat inputY = endY - self.inputView.bounds.size.height;
        [UIView animateWithDuration:duration animations:^{
            self.chatTableView.frame = CGRectMake(0, 0, CWScreenW, inputY);
            self.inputView.frame = CGRectMake(0, inputY, CWScreenW, kInputViewHeight);
        }];
        [self.chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:14 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }];
}

- (void)rightBarButtonItemClick {
    // do something
}

#pragma mark - UITableViewDelegate 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld行",indexPath.row];
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}


@end
