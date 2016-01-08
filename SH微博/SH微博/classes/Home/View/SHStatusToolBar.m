//
//  SHStatusToolBar.m
//  SH微博
//
//  Created by juan on 15/11/9.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "SHStatusToolBar.h"
#import "SHStatus.h"

@interface SHStatusToolBar()

@property (nonatomic,strong) NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *divideVs;

@property (nonatomic,weak) UIButton *retweet;
@property (nonatomic,weak) UIButton *comment;
@property (nonatomic,weak) UIButton *unlike;

@end

@implementation SHStatusToolBar

- (NSMutableArray *) btns
{
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)divideVs
{
    if (_divideVs == nil) {
        
        _divideVs = [NSMutableArray array];
    }
    
    return _divideVs;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 添加所有子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_card_bottom_background"];
    }
    return self;
}

// 添加所有子控件
- (void)setUpAllChildView
{
    //转发
    UIButton *retweet = [self setUpOneButttonWithTittle:@"转发" image:[UIImage imageNamed:@"timeline_icon_retweet"]];
    _retweet = retweet;
    
    //评论
    UIButton *comment = [self setUpOneButttonWithTittle:@"评论" image:[UIImage imageNamed:@"timeline_icon_comment"]];
    _comment = comment;
    
    //赞
    UIButton *unlike = [self setUpOneButttonWithTittle:@"赞" image:[UIImage imageNamed:@"timeline_icon_unlike"]];
    _unlike = unlike;
    
    for (int i = 0; i<2; i++) {
        UIImageView *divImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        
        [self addSubview:divImageView];
        [_divideVs addObject:divImageView];
    }
}

//添加一个按钮
- (UIButton *)setUpOneButttonWithTittle:(NSString *)tittle image:(UIImage *)image
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:tittle forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    [self addSubview:btn];
    [self.btns addObject:btn];
    
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.btns.count;
    CGFloat w = SHScreenW / count;
    CGFloat h = self.height;
    CGFloat x = 0;
    CGFloat y = 0;
    
    for (int i = 0; i < count ; i++) {
        UIButton *btn = self.btns[i];
        x = i * w;
        btn.frame = CGRectMake(x, y, w, h);
    }
    
    int i = 1;
    for (UIImageView *divide in self.divideVs) {
        UIButton *btn = self.btns[i];
        divide.x = btn.x;
        i++;
    }
}

- (void)setStatus:(SHStatus *)status
{
    _status = status;
    
    // 设置转发的标题
    [self setBtn:_retweet tittle:status.reposts_count];
    
    // 设置评论的标题
    [self setBtn:_comment tittle:status.comments_count];
    
    // 设置赞
    [self setBtn:_unlike tittle:status.attitudes_count];
}

// 设置按钮的标题
- (void)setBtn:(UIButton *)btn tittle:(int)count
{
    NSString *tittle = nil;
    if (count > 10000) {
        CGFloat floatCount = count / 10000.0;
        tittle = [NSString stringWithFormat:@"%.1W",floatCount];
        tittle = [tittle stringByReplacingOccurrencesOfString:@".0" withString:@""];
        
    } else if (count > 0) {
        tittle = [NSString stringWithFormat:@"%d",count];
       
    } else {
        return;
    }
    [btn setTitle:tittle forState:UIControlStateNormal];
}

@end
