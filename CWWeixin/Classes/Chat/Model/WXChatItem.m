//
//  WXChatItem.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/27.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXChatItem.h"
#import "NSString+WXTimestamp.h"

@interface WXChatItem ()

@end

@implementation WXChatItem

- (void)setMessage:(EMMessage *)message {
    _message = message;
    
    NSString *loginUserName = [[EaseMob sharedInstance].chatManager loginInfo][@"username"];
    _me = [loginUserName isEqualToString:message.from];
    _userIcon = self.me ? @"xhr" : @"add_friend_icon_offical";
    _timeStr = [NSString convastionTimeStr:message.timestamp];
    _showTime = (message.timestamp - self.preTimestamp) > 60000;
    _contentTextBackgroundImage = self.me ? [UIImage imageNamed:@"SenderTextNodeBkg"] : [UIImage imageNamed:@"ReceiverTextNodeBkg"];
    _contentTextBackgroundHighlightImage = self.me ? [UIImage imageNamed:@"SenderTextNodeBkgHL"] : [UIImage imageNamed:@"ReceiverTextNodeBkgHL"];
    _voiceImage = self.me ? [UIImage imageNamed:@"SenderVoiceNodePlaying"] : [UIImage imageNamed:@"SenderVoiceNodePlaying"];
    
    id<IEMMessageBody> msgBody = message.messageBodies.firstObject;
    
    _chatType = (WXChatType)msgBody.messageBodyType;
    switch (msgBody.messageBodyType) {
        case eMessageBodyType_Text:
        {
            // 收到的文字消息
            NSString *txt = ((EMTextMessageBody *)msgBody).text;
            _contentText = txt;
        }
            break;
        case eMessageBodyType_Image:
        {
            // 得到一个图片消息body
            EMImageMessageBody *body = ((EMImageMessageBody *)msgBody);
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:body.localPath]) {
                _contentImage = [UIImage imageWithContentsOfFile:body.localPath];
            }
            _contentImageUrl = [NSURL URLWithString:body.remotePath];

            
            if ([[NSFileManager defaultManager] fileExistsAtPath:body.thumbnailLocalPath]) {
                _contentThumbnailImage = [UIImage imageWithContentsOfFile:body.thumbnailLocalPath];
            }
            _contentThumbnailImageUrl = [NSURL URLWithString:body.thumbnailRemotePath];
            _vertical = body.thumbnailSize.width > body.thumbnailSize.height;
        }
            break;
        case eMessageBodyType_Location:
        {
            EMLocationMessageBody *body = (EMLocationMessageBody *)msgBody;
            NSLog(@"纬度-- %f",body.latitude);
            NSLog(@"经度-- %f",body.longitude);
            NSLog(@"地址-- %@",body.address);
        }
            break;
        case eMessageBodyType_Voice:
        {
            // 音频SDK会自动下载
            EMVoiceMessageBody *body = (EMVoiceMessageBody *)msgBody;
            
            _voiceDuration = body.duration;
            NSString *pathStr = ([[NSFileManager defaultManager] fileExistsAtPath:body.localPath]) ? body.localPath : body.remotePath;
            _voicePath = [NSURL URLWithString:pathStr];
            
        }
            break;
        case eMessageBodyType_Video:
        {
            EMVideoMessageBody *body = (EMVideoMessageBody *)msgBody;
            
            NSLog(@"视频remote路径 -- %@"      ,body.remotePath);
            NSLog(@"视频local路径 -- %@"       ,body.localPath); // 需要使用SDK提供的下载方法后才会存在
            NSLog(@"视频的secret -- %@"        ,body.secretKey);
            NSLog(@"视频文件大小 -- %lld"       ,body.fileLength);
            NSLog(@"视频文件的下载状态 -- %lu"   ,body.attachmentDownloadStatus);
            NSLog(@"视频的时间长度 -- %lu"      ,body.duration);
            NSLog(@"视频的W -- %f ,视频的H -- %f", body.size.width, body.size.height);
            
            // 缩略图sdk会自动下载
            NSLog(@"缩略图的remote路径 -- %@"     ,body.thumbnailRemotePath);
            NSLog(@"缩略图的local路径 -- %@"      ,body.thumbnailRemotePath);
            NSLog(@"缩略图的secret -- %@"        ,body.thumbnailSecretKey);
            NSLog(@"缩略图的下载状态 -- %lu"      ,body.thumbnailDownloadStatus);
        }
            break;
        case eMessageBodyType_File:
        {
            EMFileMessageBody *body = (EMFileMessageBody *)msgBody;
            NSLog(@"文件remote路径 -- %@"      ,body.remotePath);
            NSLog(@"文件local路径 -- %@"       ,body.localPath); // 需要使用SDK提供的下载方法后才会存在
            NSLog(@"文件的secret -- %@"        ,body.secretKey);
            NSLog(@"文件文件大小 -- %lld"       ,body.fileLength);
            NSLog(@"文件文件的下载状态 -- %lu"   ,body.attachmentDownloadStatus);
        }
            break;
            
        default:
            break;
    }

}

@end
