//
//  WXMusicTool.h
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/29.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXMusicTool : NSObject

@property (assign, nonatomic, readonly, getter=isPlaying) BOOL playing;

+ (instancetype)sharedInstance;

- (void)playVoice:(NSURL *)fileURL;

- (void)stopPlaying;

@end
