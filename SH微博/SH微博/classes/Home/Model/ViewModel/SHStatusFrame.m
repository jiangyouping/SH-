//
//  SHStatusFrame.m
//  SH微博
//
//  Created by juan on 15/11/9.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "SHStatusFrame.h"
#import "SHStatus.h"


@implementation SHStatusFrame

- (void)setStatus:(SHStatus *)status
{
    _status = status;
        
    //计算原创微博
    [self setUpOriginalViewFrame];
    CGFloat toolBarY = CGRectGetMaxY(_originalViewFrame);
    
    if (_status.retweeted_status) {
        
        // 计算转发微博
        [self setUpRetweetViewFrame];
        toolBarY = CGRectGetMaxY(_retweetViewFrame);
        
    }
    
    //计算微博工具条
    CGFloat toolBarX = 0;
    CGFloat toolBarW = SHScreenW;
    CGFloat toolBarH = 35;
    _toolBarFrame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    //计算cell高度
    _cellHeight = CGRectGetMaxY(_toolBarFrame);
    
}

#pragma mark - 计算原创微博
- (void)setUpOriginalViewFrame
{
    //头像
    CGFloat imageX = SHStatusCellMargin;
    CGFloat imageY = imageX;
    CGFloat imageWH = 35;
    _originalIconFrame = CGRectMake(imageX, imageY, imageWH, imageWH);
    
    //昵称
    CGFloat nameX = CGRectGetMaxX(_originalIconFrame) + SHStatusCellMargin;
    CGFloat nameY = imageY;
    CGSize nameSize = [_status.user.name sizeWithFont:SHNameFont];
    _originalNameFrame = (CGRect){nameX, nameY, nameSize};
    
    //Vip
    if (_status.user.vip) {
        CGFloat vipX = CGRectGetMaxX(_originalNameFrame) + SHStatusCellMargin;
        CGFloat vipY = nameY;
        CGFloat vipWH = 14;
        _originalVipFrame = CGRectMake(vipX, vipY, vipWH, vipWH);
        
    }
    
//    // 时间
//    CGFloat timeX = nameX;
//    CGFloat timeY = CGRectGetMaxY(_originalNameFrame) + SHStatusCellMargin * 0.5;
//    CGSize timeSize = [_status.created_at sizeWithFont:SHTimeFont];
//    _originalTimeFrame = (CGRect){{timeX,timeY},timeSize};
//    
//    // 来源
//    CGFloat sourceX = CGRectGetMaxX(_originalTimeFrame) + SHStatusCellMargin;
//    CGFloat sourceY = timeY;
//    CGSize sourceSize = [_status.source sizeWithFont:SHSourceFont];
//    _originalSourceFrame = (CGRect){{sourceX,sourceY},sourceSize};
    
    // 正文
    CGFloat textX = imageX;
    CGFloat textY = CGRectGetMaxY(_originalIconFrame) + SHStatusCellMargin;
    
    CGFloat textW = SHScreenW - 2 * SHStatusCellMargin;
    CGSize textSize = [_status.text sizeWithFont:SHTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _originalTextFrame = (CGRect){{textX,textY},textSize};
    
    CGFloat originH = CGRectGetMaxY(_originalTextFrame) + SHStatusCellMargin;
    
    //配图
    if (_status.pic_urls.count) {
        CGFloat photoX = SHStatusCellMargin;
        CGFloat photoY = CGRectGetMaxY(_originalTextFrame) + SHStatusCellMargin;
        CGSize photoSize = [self photosSizeWithCount:_status.pic_urls.count];
        
        _originalPhotosFrame = (CGRect){photoX,photoY,photoSize};
        
        originH = CGRectGetMaxY(_originalPhotosFrame) + SHStatusCellMargin;
    }
    
    // 原创微博的frame
    CGFloat originX = 0;
    CGFloat originY = 10;
    CGFloat originW = SHScreenW;
    
    _originalViewFrame = CGRectMake(originX, originY, originW, originH);
    
}

- (CGSize)photosSizeWithCount:(int)count
{
    // 获取总列数
    int cols = count == 4? 2 : 3;
    // 获取总行数 = (总个数 - 1) / 总列数 + 1
    int rols = (count -1) / cols + 1;
    CGFloat photoWH = 70;
    CGFloat w = cols * photoWH + (cols - 1) * SHStatusCellMargin;
    CGFloat h = rols * photoWH + (rols - 1) * SHStatusCellMargin;
    
    return CGSizeMake(w, h);
    
}

#pragma mark - 计算转发微博
- (void)setUpRetweetViewFrame
{
    // 昵称frame
    CGFloat nameX = SHStatusCellMargin;
    CGFloat nameY = nameX;
    CGSize nameSize = [_status.retweeted_status.user.name sizeWithFont:SHNameFont];
    _retweetNameFrame = (CGRect){nameX,nameY,nameSize};
    
    
    // 正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(_retweetNameFrame) + SHStatusCellMargin;
    
    CGFloat textW = SHScreenW - 2 * SHStatusCellMargin;
    CGSize textSize = [_status.retweeted_status.text sizeWithFont:SHTextFont constrainedToSize:CGSizeMake(textW, MAXFLOAT)];
    _retweetTextFrame = (CGRect){{textX,textY},textSize};
    
    CGFloat retweetH = CGRectGetMaxY(_retweetTextFrame) + SHStatusCellMargin;
    
    //配图
    if (_status.retweeted_status.pic_urls.count) {
        CGFloat photoX = SHStatusCellMargin;
        CGFloat photoY = CGRectGetMaxY(_retweetTextFrame) + SHStatusCellMargin;
        CGSize photoSize = [self photosSizeWithCount:_status.retweeted_status.pic_urls.count];
        _retweetPhotosFrame = (CGRect){photoX,photoY,photoSize};
        
        retweetH = CGRectGetMaxY(_retweetPhotosFrame) + SHStatusCellMargin;
    }
    
    // 转发微博的frame
    CGFloat retweetX = 0;
    CGFloat retweetY = CGRectGetMaxY(_originalViewFrame);
    CGFloat retweetW = SHScreenW;

    _retweetViewFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);
    
}

@end
