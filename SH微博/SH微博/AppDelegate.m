//
//  AppDelegate.m
//  SH微博
//
//  Created by juan on 15/11/4.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "AppDelegate.h"
#import "SHTabBarController.h"
#import "SHNewFeatureViewController.h"
#import "SHOAuthViewController.h"
#import "SHAccountTool.h"
#import "SHChoseRootTool.h"

#import <AVFoundation/AVFoundation.h>
#import "UIImageView+WebCache.h"

@interface AppDelegate ()

@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    // 注册通知
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    
    [application registerUserNotificationSettings:setting];
    
    // 设置音频会话
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    // 后台播放
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    // 单独播放一个后台程序
    [session setCategory:AVAudioSessionCategorySoloAmbient error:nil];
    
    [session setActive:YES error:nil];
    
    //创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //选择窗口的根控制器
//    SHTabBarController *tabBarController = [[SHTabBarController alloc]init];
//    SHNewFeatureViewController *vc = [[SHNewFeatureViewController alloc]init];
    

    
    
    // 选择根控制器
    // 判断下有没有授权
    if ([SHAccountTool account]) {
        //已经授权
        [SHChoseRootTool chooseRootViewController:self.window];
    }else{
        //进行授权
        SHOAuthViewController *vc = [[SHOAuthViewController alloc]init];
        self.window.rootViewController = vc;
    }
    
    //显示窗口
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 停止所有的下载
    [[SDWebImageManager sharedManager] cancelAll];
    // 删除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"silence.mp3" withExtension:nil];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [player prepareToPlay];
    // 无限播放
    player.numberOfLoops = -1;
    
    [player play];
    
    _player = player;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    // 开启一个后台任务,时间不确定，优先级比较低，假如系统要关闭应用，首先就考虑
    UIBackgroundTaskIdentifier ID = [application beginBackgroundTaskWithExpirationHandler:^{
        
        // 当后台任务结束的时候调用
        [application endBackgroundTask:ID];
        
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
