//
//  WXMusicTool.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/29.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXMusicTool.h"
#import <AVFoundation/AVFoundation.h>

static WXMusicTool *_instance;

@interface WXMusicTool ()

@property (strong, nonatomic) AVAudioPlayer *player;

@end

@implementation WXMusicTool

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[WXMusicTool alloc] init];
    });
    return _instance;
}

- (BOOL)isPlaying {
    return self.player.isPlaying;
}

- (void)playVoice:(NSURL *)fileURL {
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    [self.player play];
}

- (void)stopPlaying {
    [self.player stop];
    self.player = nil;
}

@end
