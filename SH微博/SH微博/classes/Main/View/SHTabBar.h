//
//  SHTabBar.h
//  SH微博
//
//  Created by juan on 15/11/5.
//  Copyright © 2015年 juan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SHTabBar;
@protocol SHTabBarDelegate <NSObject>

@optional
/**
 *  点击tabBar按钮
 *
 *  @param tabBar <#tabBar description#>
 *  @param index  <#index description#>
 */
- (void)tabBar:(SHTabBar *)tabBar didClickButton:(NSInteger)index;

/**
 *  点击＋号按钮
 *
 *  @param tabBar <#tabBar description#>
 */
- (void)tabBarDidClickPlusButton:(SHTabBar *)tabBar;

@end

@interface SHTabBar : UIView

//保存每一个按钮对应的tabBarItem模型
@property (strong,nonatomic) NSArray *tabBarItems;

@property (nonatomic,weak) id <SHTabBarDelegate> delegate;

@end
