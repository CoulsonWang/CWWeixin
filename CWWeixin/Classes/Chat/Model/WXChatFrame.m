//
//  WXChatFrame.m
//  CWWeixin
//
//  Created by Coulson_Wang on 2017/7/27.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "WXChatFrame.h"
#import "WXChatItem.h"

@implementation WXChatFrame

- (void)setItem:(WXChatItem *)item {
    _item = item;
    
    CGFloat margin = 10;
    CGFloat timeEdge = 5;
    CGFloat contentEdge = 30;
    
    CGSize timeStrSize = [item.timeStr boundingRectWithSize:CGSizeMake(CWScreenW, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: kTimeFont} context:nil].size;
    CGFloat timeW = timeStrSize.width + timeEdge;
    CGFloat timeH = (item.isShowTime) ? timeStrSize.height + timeEdge : 0;
    CGFloat timeX = (CWScreenW - timeW) * 0.5;
    CGFloat timeY = 0;
    
    _timeFrame = CGRectMake(timeX, timeY, timeW, timeH);
    
    
    
    CGFloat iconW = 44;
    CGFloat iconH = iconW;
    CGFloat iconX = item.isMe ? CWScreenW - margin - iconW : margin;
    CGFloat iconY = CGRectGetMaxY(self.timeFrame) + margin;
    
    _userIconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    
    CGSize contentSize = [item.contentText boundingRectWithSize:CGSizeMake(CWScreenW - 2 * (margin * 2 + iconW), CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: kContentTextFont} context:nil].size;
    CGFloat contentW = contentSize.width + contentEdge;
    CGFloat contentH = contentSize.height + contentEdge;
    CGFloat contentX = item.isMe ? CWScreenW - margin * 2 - iconW - contentW : margin * 2 + iconW;
    CGFloat contentY = iconY;
    
    _contentFrame = CGRectMake(contentX, contentY, contentW, contentH);
    
    _rowHeight = (contentH > iconH) ? CGRectGetMaxY(self.contentFrame) + margin : CGRectGetMaxY(self.userIconFrame) + margin;
}

@end
