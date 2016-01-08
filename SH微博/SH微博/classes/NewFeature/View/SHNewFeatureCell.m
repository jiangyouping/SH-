//
//  SHNewFeatureCell.m
//  SH微博
//
//  Created by juan on 15/11/5.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "SHNewFeatureCell.h"
#import "SHTabBarController.h"

@interface SHNewFeatureCell()

@property (nonatomic,weak) UIImageView *imageV;

@property (nonatomic,weak) UIButton *shareButton;

@property (nonatomic,weak) UIButton *startButton;

@end

@implementation SHNewFeatureCell

- (UIButton *)shareButton
{
    if (_shareButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"分享一下哈" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [btn  sizeToFit];
        
        [self addSubview:btn];
        
        _shareButton = btn;
    }
    return _shareButton;
}

- (UIButton *)startButton
{
    if (_startButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"开始微博" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateSelected];
        
        [btn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
        
        [btn  sizeToFit];
        
        [self addSubview:btn];
        
        _startButton = btn;
    }
    return _startButton;
}

//点击开始微博的时候调用
- (void)start
{
    SHTabBarController * tabBarController = [[SHTabBarController alloc]init];
//    self.window.rootViewController = tabBarController;
    SHKeyWindow.rootViewController = tabBarController;
    
}

//判断当前页是否是最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count
{
    if (indexPath.row == count - 1)
    {
        //最后一页，显示分享和开始
        self.shareButton.hidden = NO;
        self.startButton.hidden = NO;
    }else
    {
        //非最后一页，隐藏分享和开始按钮
        self.shareButton.hidden = YES;
        self.startButton.hidden = YES;
    }
}

- (UIImageView *) imageV
{
    if (_imageV == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        _imageV = imageView;
        
        [self.contentView addSubview:imageView];
    }
    
    return _imageV;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageV.image = image;
}

//布局子控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageV.frame = self.bounds;
    
    // 分享按钮
    self.shareButton.center = CGPointMake(self.width * 0.5, self.height * 0.8);
    
    
    // 开始按钮
    self.startButton.center = CGPointMake(self.width * 0.5, self.height * 0.9);
}

@end
