//
//  SHProfileViewController.m
//  SH微博
//
//  Created by juan on 15/11/4.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "SHProfileViewController.h"
#import "UIImageView+WebCache.h"

@interface SHProfileViewController ()

@end

@implementation SHProfileViewController

static NSString *ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(setting)];
    
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}



- (void) setting
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    cell.textLabel.text = @"清空图片缓存";
    
    // 获取sdwebImage的缓存
    // 50119318 bite
    // b -> 50119318 / 1024.0
    NSString *title = nil;
    NSUInteger size = [SDImageCache sharedImageCache].getSize;
    if (size > 1024 * 1024) {
        CGFloat floatSize = size / 1024.0 / 1024.0;
        title = [NSString stringWithFormat:@"%.fM",floatSize];
    }else if (size > 1024){
        CGFloat floatSize = size / 1024.0;
        title = [NSString stringWithFormat:@"%.fKB",floatSize];
    }else if(size > 0)
    {
        title = [NSString stringWithFormat:@"%ldKB",size];
    }
    cell.detailTextLabel.text = title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[SDImageCache sharedImageCache] clearDisk];
    
    [self.tableView reloadData];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
