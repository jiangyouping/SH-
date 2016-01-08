//
//  SHRetweetView.m
//  SH微博
//
//  Created by juan on 15/11/9.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "SHRetweetView.h"
#import "SHStatusFrame.h"
#import "SHStatus.h"
#import "SHPhotosView.h"

@interface SHRetweetView()

// 昵称
@property (nonatomic, weak) UILabel *nameView;


// 正文
@property (nonatomic, weak) UILabel *textView;

//配图
@property (nonatomic,weak) SHPhotosView *photosView;

@end

@implementation SHRetweetView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 添加所有子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_retweet_background"];
        
    }
    return self;
}

// 添加所有子控件
- (void)setUpAllChildView
{
    
    // 昵称
    UILabel *nameView = [[UILabel alloc] init];
    [self addSubview:nameView];
    nameView.font = SHNameFont;
    _nameView = nameView;
    
    
    // 正文
    UILabel *textView = [[UILabel alloc] init];
    [self addSubview:textView];
    textView.numberOfLines = 0;
    textView.font = SHTextFont;
    _textView = textView;
    
    // 配图
    SHPhotosView *photosView = [[SHPhotosView alloc] init];
    [self addSubview:photosView];
    _photosView = photosView;
}

- (void)setStatusFrame:(SHStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    SHStatus * status = statusFrame.status;
    
    _nameView.text = status.retweeted_status.user.name;
    _nameView.frame = statusFrame.retweetNameFrame;
    
    _textView.text = status.retweeted_status.text;
    _textView.frame = statusFrame.retweetTextFrame;
    
    _photosView.frame = statusFrame.retweetPhotosFrame;
    _photosView.pic_urls = status.retweeted_status.pic_urls;
    
}

@end
