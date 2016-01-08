//
//  SHNavigationController.m
//  SH微博
//
//  Created by juan on 15/11/5.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "SHNavigationController.h"

@interface SHNavigationController ()

@end

@implementation SHNavigationController

+(void) initialize
{
    //获取当前类下面的UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self,nil];
    
    //通过富文本设置导航条按钮的文字颜色
    //通过模型设置控件的文本颜色只能通过富文本
    NSMutableDictionary *attDic = [NSMutableDictionary dictionary];
    [attDic setObject:[UIColor orangeColor] forKey:NSForegroundColorAttributeName];
    [item setTitleTextAttributes:attDic forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
