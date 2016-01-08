//
//  SHHomeViewController.m
//  SH微博
//
//  Created by juan on 15/11/4.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "SHHomeViewController.h"
#import "UIBarButtonItem+barButtonItem.h"

#import "SHStatusParams.h"
#import "SHAccountTool.h"
#import "SHUserAccount.h"
#import "SHStatusResults.h"

#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"

#import "SHStatus.h"
#import "SHStatusFrame.h"
#import "SHStatusCell.h"

#import "SHStatusTool.h"
#import "SHUserTool.h"

@interface SHHomeViewController ()

@property (nonatomic,strong) NSMutableArray *statusesFrame;

@end

@implementation SHHomeViewController

- (NSMutableArray *) statusesFrame
{
    if (_statusesFrame == nil) {
        _statusesFrame = [NSMutableArray array];
    }
    
    return _statusesFrame;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    // 取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //设置导航条的内容
    [self setUpNavigatinBar];
    
    //添加下拉刷新控件
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatus)];
    
    //自动下拉刷新
    [self.tableView headerBeginRefreshing];
    
    //添加上拉刷新控件
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
    
    //获取最新的微博信息
    // [self loadNewStatus];
    
    //请求当前的用户信息
    [SHUserTool userInfoWithSuccess:^(SHUser *result) {
        
        // 请求当前账号的用户信息
        // 设置导航条的标题

        self.navigationItem.title = result.name;
        
        
        //获取当前的账号
        SHUserAccount *account = [SHAccountTool account];
        account.name = result.name;
        
        // 保存用户的名称
        [SHAccountTool saveUserAccount:account];
        
    } failure:^(NSError *error) {
    
    }];
    
    
}


#pragma mark - 获取最新的微博信息
- (void) loadNewStatus
{
    NSString *sinceID = nil;
    if (self.statusesFrame.count) {
        // 有微博数据，才需要下拉刷新
        sinceID = [self.statusesFrame[0] status].idstr;
    }
    
    [SHStatusTool newStatusWithSinceID:sinceID success:^(NSArray *statuses) {
        
        //展示最新的微博数
        [self showNewStatusCount:statuses.count];
        
        //结束下拉刷新
        [self.tableView headerEndRefreshing];
        
        // 模型转换视图模型 CZStatus -> CZStatusFrame
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (SHStatus *status in statuses) {
            SHStatusFrame *statusF = [[SHStatusFrame alloc]init];
            statusF.status = status;
            [statusFrames addObject:statusF];
        }
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        
        // 把最新的微博数插入到最前面
        [self.statusesFrame insertObjects:statusFrames atIndexes:indexSet];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
  
        
    }];
}

#pragma mark - 获取更多的微博信息
- (void) loadMoreStatus
{
    NSString *maxIDStr = nil;
    if (self.statusesFrame.count) {
       long long maxID = [[[self.statusesFrame lastObject] status].idstr longLongValue]- 1;
        maxIDStr = [NSString stringWithFormat:@"%lld",maxID];
    }

    [SHStatusTool moreStatusWithMaxID:maxIDStr success:^(NSArray *statuses) {
        
        //结束上拉刷新
        [self.tableView footerEndRefreshing];
        
        // 模型转换视图模型 CZStatus -> CZStatusFrame
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (SHStatus *status in statuses) {
            SHStatusFrame *statusF = [[SHStatusFrame alloc]init];
            statusF.status = status;
            [statusFrames addObject:statusF];
        }
        
        
        [self.statusesFrame addObjectsFromArray:statusFrames];
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - 展示最新的微博数目
- (void) showNewStatusCount:(int)count
{
    if (count == 0) return;
    
    // 展示最新的微博数
    CGFloat h = 35;
    CGFloat w = self.view.width;
    CGFloat x = 0;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - h;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(x, y, w, h)];
    
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.text = [NSString stringWithFormat:@"最新的微博数%d",count];
    label.textAlignment = NSTextAlignmentCenter;
    
    // 插入导航控制器下导航条下面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    //动画往下面平移
    [UIView animateWithDuration:0.3 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, h);
    } completion:^(BOOL finished) {
        
        // 往上面平移
        [UIView animateWithDuration:0.3 delay:2 options:UIViewAnimationCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
        
    }];
    
    

}

- (void) refresh
{
    [self.tableView headerBeginRefreshing];
}

#pragma mark - 设置导航条的内容
- (void)setUpNavigatinBar
{
    //左边
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"] target:self action:@selector(friendSearch) forControlEvents:UIControlEventTouchUpInside];
    
    //右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] target:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - friendSearch方法
- (void)friendSearch
{
    
}

- (void)pop
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.statusesFrame.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //创建cell
    SHStatusCell *cell = [SHStatusCell cellWithTableView:tableView];
    
    // 获取status模型
    SHStatusFrame *statusframe = self.statusesFrame[indexPath.row];
    
    // 给cell传递模型
    cell.statusFrame = statusframe;
//    cell.textLabel.text = status.user.name;
//    [cell.imageView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
//    cell.detailTextLabel.text = status.text;
    
    return  cell;
}

// 返回cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取status模型
    SHStatusFrame *statusF = self.statusesFrame[indexPath.row];
    
    return statusF.cellHeight;
}

@end
