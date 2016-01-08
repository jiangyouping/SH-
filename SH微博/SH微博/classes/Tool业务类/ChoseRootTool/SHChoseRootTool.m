//
//  SHChoseRootTool.m
//  SH微博
//
//  Created by juan on 15/11/6.
//  Copyright © 2015年 juan. All rights reserved.
//


#define SHVersionKey @"version"
#import "SHChoseRootTool.h"

#import "SHTabBarController.h"
#import "SHNewFeatureViewController.h"

@implementation SHChoseRootTool

+(void)chooseRootViewController:(UIWindow *)window
{
    // 1.获取当前的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    // 2.获取上一次的版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:SHVersionKey];
    
    if ([currentVersion isEqualToString:lastVersion]) {
        // 没有最新的版本号
        SHTabBarController *tabVc = [[SHTabBarController alloc]init];
        window.rootViewController = tabVc;
    }else{
        // 有最新的版本号
        SHNewFeatureViewController *vc = [[SHNewFeatureViewController alloc]init];
        window.rootViewController = vc;
        
        // 保持当前的版本，用偏好设置
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:SHVersionKey];
        
    }
}

@end
