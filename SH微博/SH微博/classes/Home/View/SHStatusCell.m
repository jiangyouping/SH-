//
//  SHStatusCell.m
//  SH微博
//
//  Created by juan on 15/11/9.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "SHStatusCell.h"

#import "SHOriginalView.h"
#import "SHRetweetView.h"
#import "SHStatusToolBar.h"
#import "SHStatusFrame.h"
#import "SHStatus.h"

@interface SHStatusCell()

@property (nonatomic, weak) SHOriginalView *originalView;
@property (nonatomic, weak) SHRetweetView *retweetView ;
@property (nonatomic, weak)  SHStatusToolBar *toolBar;

@end

@implementation SHStatusCell

//SHStatusCell的初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpAllChildView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (void) setUpAllChildView
{
    // 原创微博
    SHOriginalView *originalView = [[SHOriginalView alloc]init];
    [self addSubview:originalView];
    _originalView = originalView;
    
    // 转发微博
    SHRetweetView *retweetView = [[SHRetweetView alloc] init];
    [self addSubview:retweetView];
    _retweetView = retweetView;
    
    // 工具条
    SHStatusToolBar *toolBar = [[SHStatusToolBar alloc] init];
    [self addSubview:toolBar];
    _toolBar = toolBar;
}

- (void)setStatusFrame:(SHStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 设置原创微博frame
    _originalView.frame = statusFrame.originalViewFrame;
    _originalView.statusFrame = statusFrame;
    
    // 设置转发微博frame
    if (statusFrame.status.retweeted_status) {
        _retweetView.frame = statusFrame.retweetViewFrame;
        _retweetView.statusFrame = statusFrame;
        _retweetView.hidden = NO;
    } else{
        _retweetView.hidden = YES;
    }
    
    
    // 设置工具条frame
    _toolBar.frame = statusFrame.toolBarFrame;
    _toolBar.status = statusFrame.status;
}

@end
