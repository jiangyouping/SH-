//
//  SHNewFeatureViewController.m
//  SH微博
//
//  Created by juan on 15/11/5.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "SHNewFeatureViewController.h"
#import "SHNewFeatureCell.h"

@interface SHNewFeatureViewController ()

@property (nonatomic,weak) UIPageControl *contrl;

@end

@implementation SHNewFeatureViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype) init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    //设置cell的尺寸
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    
    // 清空行距
    layout.minimumLineSpacing = 0;
    
    //设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [super initWithCollectionViewLayout:layout];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[SHNewFeatureCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    //分页
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    [self setUpPageController];
    
    // Do any additional setup after loading the view.
}

//添加pageController
- (void)setUpPageController
{
    UIPageControl *controller = [[UIPageControl alloc]init];
    
    controller.numberOfPages = 4;
    controller.pageIndicatorTintColor = [UIColor blackColor];
    controller.currentPageIndicatorTintColor = [UIColor redColor];
    
    //设置pageController
    controller.center = CGPointMake(self.view.width * 0.5, self.view.height);
    _contrl = controller;
    [self.view addSubview:controller];
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

#pragma mark - UIScrollView代理
- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    //设置当前的偏移量，计算但前是第几页
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5;
    
    _contrl.currentPage = page;
}

#pragma mark <UICollectionViewDataSource>
//返回有多少个组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//返回每组有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SHNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld",indexPath.row + 1];
    if (screenH > 480) { // 5 , 6 , 6 plus
        imageName = [NSString stringWithFormat:@"new_feature_%ld-568h",indexPath.row + 1];
    }
//    SHLog(@"%@",imageName);
    cell.image = [UIImage imageNamed:imageName];
    
    [cell setIndexPath:indexPath count:4];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>



@end
