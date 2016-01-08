//
//  SHSearchBar.m
//  SH微博
//
//  Created by juan on 15/11/5.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "SHSearchBar.h"

@implementation SHSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:12];
        
        [self setBackground:[UIImage imageWithStretchableName:@"searchbar_textfield_background"]];
        
        UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        
        imageV.width += 10;
        imageV.contentMode = UIViewContentModeCenter;
        self.leftView = imageV;
        self.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return self;
}

@end
