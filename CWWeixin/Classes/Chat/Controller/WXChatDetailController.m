//
//  WXChatDetailController.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/27.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXChatDetailController.h"
#import "WXInputView.h"
#import "WXChatCell.h"
#import "WXChatItem.h"
#import "WXChatFrame.h"
#import <MWPhotoBrowser.h>
#import <AVFoundation/AVFoundation.h>

#define kInputViewHeight 44.0

static NSString *const cellID = @"cellID";

@interface WXChatDetailController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, EMChatManagerDelegate, WXInputViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, WXChatCellDelegate, MWPhotoBrowserDelegate>

@property (weak, nonatomic) UITableView *chatTableView;

@property (weak, nonatomic) WXInputView *inputView;

@property (strong, nonatomic) NSMutableArray<WXChatFrame *> *chatMsgs;

@property (strong, nonatomic) NSMutableArray *chatImages;
@property (strong, nonatomic) NSMutableArray *chatThumbnailImages;

@property (strong, nonatomic) AVAudioRecorder *recorder;
@property (assign, nonatomic) NSTimeInterval voiceDuration;

@end

@implementation WXChatDetailController

+ (instancetype)chatDetailVCWithChatter:(NSString *)chatter chatType:(EMConversationType)type {
    WXChatDetailController *cdVC = [[WXChatDetailController alloc] init];
    cdVC.chatter = chatter;
    cdVC.chatType = type;
    cdVC.hidesBottomBarWhenPushed = YES;
    return cdVC;
}

#pragma mark - Lazy Load

- (UIView *)inputView {
    if (!_inputView) {
        WXInputView *inputView = [WXInputView inputView];
        inputView.frame = CGRectMake(0, CWScreenH - kInputViewHeight, CWScreenW, kInputViewHeight);
        inputView.textField.delegate = self;
        inputView.delegate = self;
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

- (NSMutableArray *)chatMsgs {
    if (!_chatMsgs) {
        _chatMsgs = [NSMutableArray array];
    }
    return _chatMsgs;
}

- (NSMutableArray *)chatImages {
    if (!_chatImages) {
        _chatImages = [NSMutableArray array];
    }
    return _chatImages;
}

- (NSMutableArray *)chatThumbnailImages {
    if (!_chatThumbnailImages) {
        _chatThumbnailImages = [NSMutableArray array];
    }
    return _chatThumbnailImages;
}

#pragma mark - setter

- (void)setChatter:(NSString *)chatter {
    _chatter = chatter;
    self.title = chatter;
}

- (void)setChatType:(EMConversationType)chatType {
    _chatType = chatType;
    if (chatType == eConversationTypeGroupChat) {
        EMGroup *group = [[EaseMob sharedInstance].chatManager fetchGroupInfo:self.chatter error:nil];
        self.title = [NSString stringWithFormat:@"%@(%ld)",group.groupSubject,group.groupOccupantsCount];
    }
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.chatTableView registerClass:[WXChatCell class] forCellReuseIdentifier:cellID];
    self.chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.chatTableView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    self.chatTableView.allowsSelection = NO;
    self.chatTableView.contentInset = UIEdgeInsetsMake(70, 0, 0, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.inputView.tag = 1;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tabbar_me"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClick)];
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
    [self loadChatMessages];
    
    [self setUpNotification];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadChatMessages];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 私有方法
- (void)rightBarButtonItemClick {
    // do something
}

- (void)setUpNotification {
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillChangeFrameNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        NSTimeInterval duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        CGFloat endY = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
        CGFloat inputY = endY - self.inputView.bounds.size.height;
        [UIView animateWithDuration:duration animations:^{
            self.chatTableView.frame = CGRectMake(0, 0, CWScreenW, inputY);
            self.inputView.frame = CGRectMake(0, inputY, CWScreenW, kInputViewHeight);
        }];
        [self scrollTheTableView];
    }];

}

- (void)loadChatMessages {
    [self.chatMsgs removeAllObjects];
    [self.chatImages removeAllObjects];
    [self.chatThumbnailImages removeAllObjects];
    
    EMConversation *conversation = [[EaseMob sharedInstance].chatManager conversationForChatter:self.chatter conversationType:self.chatType];
    NSArray *msgs = [conversation loadAllMessages];
    for (EMMessage *msg in msgs) {
        WXChatItem *item = [[WXChatItem alloc] init];
        WXChatItem *lastItem = [self.chatMsgs.lastObject item];
        
        item.preTimestamp = lastItem.message.timestamp;
        item.message = msg;
        
        WXChatFrame *chatFrame = [[WXChatFrame alloc] init];
        chatFrame.item = item;
        
        [self.chatMsgs addObject:chatFrame];
        if (item.chatType == WXChatTypeImage) {
            [self.chatImages addObject:(item.contentImage ? item.contentImage : item.contentImageUrl)];
            [self.chatThumbnailImages addObject:(item.contentThumbnailImage ? item.contentThumbnailImage : item.contentThumbnailImageUrl)];
        }
    }
    
    [conversation markAllMessagesAsRead:YES];
    
    [self.chatTableView reloadData];
    [self scrollTheTableView];
}

- (void)scrollTheTableView {
    if (self.chatMsgs.count != 0) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:self.chatMsgs.count - 1  inSection:0];
        [self.chatTableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
    }
}

- (void)setUpRecorder {
    NSInteger nowTime = (NSInteger)[[NSDate date] timeIntervalSince1970];
    NSString *fileName = [NSString stringWithFormat:@"%@%ld.caf",self.chatter,nowTime];
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    AVAudioRecorder *recorder = [[AVAudioRecorder alloc] initWithURL:url settings:@{} error:nil];
    [recorder prepareToRecord];
    
    self.recorder = recorder;
}

- (void)sendVoiceMessage {
    EMChatVoice *chatVoice = [[EMChatVoice alloc] initWithFile:self.recorder.url.path displayName:@"语音消息"];
    chatVoice.duration = self.voiceDuration;
    EMVoiceMessageBody *voiceMsg = [[EMVoiceMessageBody alloc] initWithChatObject:chatVoice];
    EMMessage *msg = [[EMMessage alloc] initWithReceiver:self.chatter bodies:@[voiceMsg]];
    [[EaseMob sharedInstance].chatManager asyncSendMessage:msg progress:nil prepare:nil onQueue:nil completion:^(EMMessage *message, EMError *error) {
        if (!error) {
            [self loadChatMessages];
        }
        
    } onQueue:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chatMsgs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WXChatCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    WXChatFrame *chatFrame = self.chatMsgs[indexPath.row];
    
    cell.chatFrame = chatFrame;
    cell.delegate = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WXChatFrame *chatFrame = self.chatMsgs[indexPath.row];
    return chatFrame.rowHeight;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate 
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    EMChatText *text = [[EMChatText alloc] initWithText:textField.text];
    EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithChatObject:text];
    EMMessage *msg = [[EMMessage alloc] initWithReceiver:self.chatter bodies:@[body]];
    
    [[EaseMob sharedInstance].chatManager asyncSendMessage:msg progress:nil prepare:^(EMMessage *message, EMError *error) {
        
    } onQueue:nil completion:^(EMMessage *message, EMError *error) {
        if (!error) {
            textField.text = nil;
            [textField resignFirstResponder];
            [self loadChatMessages];
        }
        
    } onQueue:nil];
    
    return YES;
}

#pragma mark - WXInputViewDelegate
- (void)inputView:(WXInputView *)inputView moreBtnDidClickWithStyle:(WXInputViewMoreStyle)style {
    switch (style) {
        case WXInputViewMoreStyleImage:
        {
            UIImagePickerController *pickVC = [[UIImagePickerController alloc] init];
            pickVC.delegate = self;
            [self presentViewController:pickVC animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}

- (void)inputView:(WXInputView *)inputView voiceChangeStatus:(WXInputVoiceStatus)status {
    switch (status) {
        case WXInputVoiceStatusSpeaking:
        {
            [self setUpRecorder];
            [self.recorder record];
        }
            break;
        case WXInputVoiceStatusWillCancle:
        {
            
        }
            break;
        case WXInputVoiceStatusSent:
        {
            self.voiceDuration = self.recorder.currentTime;
            [self.recorder stop];
            [self sendVoiceMessage];
        }
            break;
        case WXInputVoiceStatusCancled:
        {
            [self.recorder stop];
            [self.recorder deleteRecording];
        }
            break;
    }
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
        
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        EMChatImage *chatImage = [[EMChatImage alloc] initWithUIImage:image displayName:@"nothing"];
        EMImageMessageBody *body = [[EMImageMessageBody alloc] initWithImage:chatImage thumbnailImage:chatImage];
        EMMessage *msg = [[EMMessage alloc] initWithReceiver:self.chatter bodies:@[body]];
        
        [[EaseMob sharedInstance].chatManager asyncSendMessage:msg progress:nil prepare:^(EMMessage *message, EMError *error) {
            
        } onQueue:nil completion:^(EMMessage *message, EMError *error) {
            if (!error) {
                [self loadChatMessages];
            }
        } onQueue:nil];
        
    }];
}

#pragma mark - WXChatCellDelegate
- (void)chatCell:(WXChatCell *)chatCell contentDidClick:(WXChatType)chatType {
    // 创建浏览界面
    if (chatType == WXChatTypeImage) {
        MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        
        NSUInteger index = (chatCell.chatFrame.item.contentThumbnailImage) ? [self.chatThumbnailImages indexOfObject:chatCell.chatFrame.item.contentThumbnailImage] : [self.chatThumbnailImages indexOfObject:chatCell.chatFrame.item.contentThumbnailImageUrl];
        [browser setCurrentPhotoIndex:index];
        
        // Present
        [self.navigationController showViewController:browser sender:nil];
    }
    
    
}

#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.chatThumbnailImages.count;
}
- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    
    id img = self.chatImages[index];
    
    return [img isKindOfClass:[UIImage class]] ? [MWPhoto photoWithImage:img] : [MWPhoto photoWithURL:img];
}

- (id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    
    id thumbnail = self.chatThumbnailImages[index];
    
    return [thumbnail isKindOfClass:[UIImage class]] ? [MWPhoto photoWithImage:thumbnail] : [MWPhoto photoWithURL:thumbnail];
}


#pragma mark - 收到消息后刷新数据
- (void)didReceiveMessage:(EMMessage *)message {
    [self loadChatMessages];
}

- (void)didReceiveOfflineMessages:(NSArray *)offlineMessages {
    [self loadChatMessages];
}

@end
