//
//  SHTabBarButton.m
//  SH微博
//
//  Created by juan on 15/11/5.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "SHTabBarButton.h"
#import "SHBadgeView.h"

#define SHImageRadio 0.7

@interface SHTabBarButton()

@property (nonatomic,weak) SHBadgeView *badgeView;

@end

@implementation SHTabBarButton

//懒加载badgeView
- (SHBadgeView *) badgeView
{
    if (_badgeView == nil) {
        SHBadgeView *badgeView = [SHBadgeView buttonWithType:UIButtonTypeCustom];
        
        [self addSubview:badgeView];
        
        _badgeView = badgeView;
    }
    
    return _badgeView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //设置字体颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
        //图片和文字居中
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        //设置文字字体
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    
    return self;
}

//传递模型值给tabBarButton，给tabBarButton内容赋值
- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
    [_item addObserver:self forKeyPath:@"tittle" options:NSKeyValueObservingOptionNew context:nil];
    [_item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [_item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    
    
    [_item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
    
}

//监听的属性一有新值，就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setTitle:_item.title forState:UIControlStateNormal];
    [self setImage:_item.image forState:UIControlStateNormal];
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
    
    //设置badgeValue值
    self.badgeView.badgeValue = _item.badgeValue;
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //imageView
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height * SHImageRadio;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    //tittle
    CGFloat titleX = 0;
    CGFloat titleY = imageH - 3;
    CGFloat titleW = self.bounds.size.width;
    CGFloat titleH = self.bounds.size.height - titleY;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    //badgeValue
    self.badgeView.x = self.width - self.badgeView.width - 10;
    self.badgeView.y = 0;
    
}

@end
