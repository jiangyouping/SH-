//
//  SHTabBar.m
//  SH微博
//
//  Created by juan on 15/11/5.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "SHTabBar.h"
#import "SHTabBarButton.h"


@interface SHTabBar()

@property (nonatomic,strong) NSMutableArray *buttons;

@property (nonatomic,weak) UIButton *pulsButton;

@property (nonatomic,weak) UIButton *selectedButton;

@end

@implementation SHTabBar

- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (void)setTabBarItems:(NSArray *)tabBarItems
{
    _tabBarItems = tabBarItems;
    
    for (UITabBarItem *item in _tabBarItems) {
        SHTabBarButton *btn = [SHTabBarButton buttonWithType:UIButtonTypeCustom];
        
        //给按钮赋值模型
        btn.item = item;
        btn.tag = self.buttons.count;
        
        //添加button的点击事件
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        
        [self addSubview:btn];
        
        [self.buttons addObject:btn];
        
    }
}

//点击button的时候调用
- (void) btnClick:(UIButton *) button
{
    _selectedButton.selected = NO;
    button.selected = YES;
    _selectedButton = button;
    
    if ([_delegate respondsToSelector:@selector(tabBar:didClickButton:)]) {
        [_delegate tabBar:self didClickButton:button.tag];
    }
}

- (UIButton *)pulsButton
{
    if (_pulsButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add"] forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        [btn sizeToFit];
        
        //监听按钮的点击
        [btn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        
        _pulsButton = btn;
        
        [self addSubview:_pulsButton];
        
    }
    return _pulsButton;
}

//点击＋号按钮的时候调用
- (void)plusClick
{
    if ([_delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [_delegate tabBarDidClickPlusButton:self];
    }
}

//调整子控件的位置
- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    CGFloat btnX = 0;
    CGFloat btnY = 0;
    CGFloat btnW = w / (self.tabBarItems.count + 1);
    CGFloat btnH = h;
    
    //设置tabBarButton的frame
    int i = 0;
//    SHLog(@"%@",self.buttons);
    for (UIView *tabBarButton in self.buttons) {
            if (i == 2) {
                i = 3;
            }
            btnX = btnW * i;
            tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
            i++;
//            SHLog(@"%@",NSStringFromCGRect(tabBarButton.frame));
        
    }
    
    //设置添加按钮的位置
    self.pulsButton.center = CGPointMake(w * 0.5, h * 0.5);
}

@end
