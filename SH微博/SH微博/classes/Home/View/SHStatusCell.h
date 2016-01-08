//
//  SHStatusCell.h
//  SH微博
//
//  Created by juan on 15/11/9.
//  Copyright © 2015年 juan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SHStatusFrame;

@interface SHStatusCell : UITableViewCell

@property (nonatomic,strong) SHStatusFrame *statusFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
