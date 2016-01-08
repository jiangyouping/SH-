//
//  SHTabBarController.m
//  SH微博
//
//  Created by juan on 15/11/4.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "SHTabBarController.h"


#import "SHHomeViewController.h"
#import "SHMessageViewController.h"
#import "SHDiscoverViewController.h"
#import "SHProfileViewController.h"

#import "SHTabBar.h"
#import "SHNavigationController.h"

#import "SHUserTool.h"
#import "SHUserResult.h"

#import "SHComposeViewController.h"


@interface SHTabBarController ()<SHTabBarDelegate>

@property (nonatomic,strong) NSMutableArray *items;

@property (nonatomic,weak) SHHomeViewController *home;

@property (nonatomic,weak) SHMessageViewController *message;

@property (nonatomic,weak) SHProfileViewController *profile;

@end

@implementation SHTabBarController

- (NSMutableArray *)items
{
    if (_items == nil) {
        _items = [NSMutableArray array];
    }
    return _items;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //添加所有子控制器
    [self setUpAllChildViewController];
    
    
    //添加tabBar
    [self setUpTabBar];
    
    // 定时器每隔一段时间请求未读数
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(unreadMessage) userInfo:nil repeats:YES];

    
}

#pragma mark - 请求未读信息数
- (void) unreadMessage
{
    [SHUserTool unreadWithSuccess:^(SHUserResult *result) {
        
        // 设置首页未读数
        _home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.status];
        
        // 设置消息未读数
        _message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.messageCount];
        
        // 设置我的未读数
        _profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.follower];
        
        // 设置应用程序所有的未读数
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totoalCount;
        
    } failure:^(NSError *error) {
        
    }];
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
//    SHLog(@"%@",self.tabBar.subviews);
}

#pragma mark - 点击tabBar上的按钮调用
- (void)tabBar:(SHTabBar *)tabBar didClickButton:(NSInteger)index
{
    if (index == 0 && self.selectedIndex == index) {
        [_home refresh];
    }
    self.selectedIndex = index;
}

#pragma mark - 点击＋号按钮的时候调用
- (void)tabBarDidClickPlusButton:(SHTabBar *)tabBar
{
    SHComposeViewController *composeViewController = [[SHComposeViewController alloc]init];
    SHNavigationController *vc = [[SHNavigationController alloc]initWithRootViewController:composeViewController];
    
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - 添加tabBar
- (void) setUpTabBar
{
    SHTabBar *tabBar = [[SHTabBar alloc] initWithFrame:self.tabBar.frame];
//    UITabBar *tabBar = [[UITabBar alloc]init];
    tabBar.backgroundColor = [UIColor whiteColor];
    
    //设置tabBar的代理
    tabBar.delegate = self;
    
    //给tabBar传递tabBarItem模型
    tabBar.tabBarItems = self.items;
    
    //移除系统的tabBar
    [self.tabBar removeFromSuperview];
    
    //添加自定义tabBar
    [self.view addSubview:tabBar];

}

#pragma mark - 添加所有子控制器
- (void) setUpAllChildViewController
{
    //首页
    SHHomeViewController *homeViewController = [[SHHomeViewController alloc] init];
    [self setUpOneViewController:homeViewController image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageNamed:@"tabbar_home_selected"] tittle:@"首页"];
    _home = homeViewController;
    
    //消息
    SHMessageViewController *messageViewController = [[SHMessageViewController alloc]init];
    [self setUpOneViewController:messageViewController image:[UIImage imageNamed:@"tabbar_message_center" ] selectedImage:[UIImage imageNamed:@"tabbar_message_center_selected"] tittle:@"消息"];
    _message = messageViewController;
    
    //发现
    SHDiscoverViewController *discoverViewController = [[SHDiscoverViewController alloc]init];
    [self setUpOneViewController:discoverViewController image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageNamed:@"tabbar_discover_selected"] tittle:@"发现"];
    
    //我
    SHProfileViewController *profileViewController = [[SHProfileViewController alloc]init];
    [self setUpOneViewController:profileViewController image:[UIImage imageNamed:@"tabbar_profile"] selectedImage:[UIImage imageNamed:@"tabbar_profile_selected"] tittle:@"我"];
    _profile = profileViewController;
}

#pragma mark - 添加一个子控制器
- (void) setUpOneViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage tittle:(NSString *)tittle
{
    vc.tabBarItem.title = tittle;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    
    
    //保存tabBarItem模型到items 数组中
    [self.items addObject:vc.tabBarItem];
    
    //添加子控制器的同时添加导航条
    SHNavigationController *nav = [[SHNavigationController alloc]initWithRootViewController:vc];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    
    
    [self addChildViewController:nav];
    
}

@end
