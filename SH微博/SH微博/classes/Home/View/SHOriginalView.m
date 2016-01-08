//
//  SHOriginalView.m
//  SH微博
//
//  Created by juan on 15/11/9.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "SHOriginalView.h"
#import "SHStatusFrame.h"
#import "SHStatus.h"
#import "SHPhotosView.h"

#import "UIImageView+WebCache.h"

@interface SHOriginalView()

// 头像
@property (nonatomic, weak) UIImageView *iconView;


// 昵称
@property (nonatomic, weak) UILabel *nameView;


// vip
@property (nonatomic, weak) UIImageView *vipView;


// 时间
@property (nonatomic, weak) UILabel *timeView;

// 来源
@property (nonatomic, weak) UILabel *sourceView;


// 正文
@property (nonatomic, weak) UILabel *textView;

// 配图
@property (nonatomic, weak) SHPhotosView *photosView;

@end

@implementation SHOriginalView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_card_top_background"];
    }
    return self;
}


// 添加所有子控件
- (void)setUpAllChildView
{
    // 头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    _iconView = iconView;
    
    // 昵称
    UILabel *nameView = [[UILabel alloc] init];
    nameView.font = SHNameFont;
    [self addSubview:nameView];
    _nameView = nameView;
    
    // vip
    UIImageView *vipView = [[UIImageView alloc] init];
    [self addSubview:vipView];
    _vipView = vipView;
    
    // 时间
    UILabel *timeView = [[UILabel alloc] init];
    timeView.font = SHTimeFont;
    timeView.textColor = [UIColor orangeColor];
    [self addSubview:timeView];
    _timeView = timeView;
    
    // 来源
    UILabel *sourceView = [[UILabel alloc] init];
    sourceView.font = SHSourceFont;
    sourceView.textColor = [UIColor lightGrayColor];
    [self addSubview:sourceView];
    _sourceView = sourceView;
    
    // 正文
    UILabel *textView = [[UILabel alloc] init];
    textView.font = SHTextFont;
    //行数设置，非一行
    textView.numberOfLines = 0;
    [self addSubview:textView];
    _textView = textView;
    
    // 配图
    SHPhotosView *photosView = [[SHPhotosView alloc] init];
    [self addSubview:photosView];
    _photosView = photosView;
}

- (void)setStatusFrame:(SHStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 设置frame
    [self setUpFrame];
    // 设置data
    [self setUpData];
}

- (void)setUpData
{
    SHStatus *status = self.statusFrame.status;
    
    //头像
    [_iconView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    
    //昵称
    if (status.user.vip) {
        _nameView.textColor = [UIColor redColor];
    }else{
        _nameView.textColor = [UIColor blackColor];
    }
    _nameView.text = status.user.name;
    
    //vip
    NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",status.user.mbrank];
    _vipView.image = [UIImage imageNamed:imageName];
    
    //时间
    _timeView.text = status.created_at;
    
    //来源
    _sourceView.text = status.source;
    
    //正文
    _textView.text = status.text;
    
    // 配图
    _photosView.pic_urls = status.pic_urls;
    
     
}

- (void)setUpFrame
{
    //头像
    _iconView.frame = _statusFrame.originalIconFrame;
    
    // 昵称
    _nameView.frame = _statusFrame.originalNameFrame;
    
    //vip
    if (_statusFrame.status.user.vip) {
        _vipView.hidden = NO;
        _vipView.frame = _statusFrame.originalVipFrame;
    } else{
        _vipView.hidden = YES;
    }
    
    //时间    每次有新的时间都需要计算时间frame
    SHStatus *status = _statusFrame.status;
    CGFloat timeX = _nameView.frame.origin.x;
    CGFloat timeY = CGRectGetMaxY(_nameView.frame) + SHStatusCellMargin * 0.5;
    CGSize timeSize = [status.created_at sizeWithFont:SHTimeFont];
    _timeView.frame = (CGRect){timeX,timeY,timeSize};
    
    
    //来源
    CGFloat sourceX = CGRectGetMaxX(_timeView.frame) + SHStatusCellMargin;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:SHSourceFont];
    _sourceView.frame = (CGRect){{sourceX,sourceY},sourceSize};
    
    //正文
    _textView.frame = _statusFrame.originalTextFrame;
    
    // 配图
    _photosView.frame = _statusFrame.originalPhotosFrame;
    
}

@end
