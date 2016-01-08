//
//  SHBadgeView.m
//  SH微博
//
//  Created by juan on 15/11/5.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "SHBadgeView.h"
#define SHBadgeViewFont [UIFont systemFontOfSize:10]


@interface SHBadgeView()



@end

@implementation SHBadgeView

- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = NO;
        
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        
        self.titleLabel.font = SHBadgeViewFont;
        [self sizeToFit];
    }

    return  self;
}


- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue;
    
    //判断badgeValue是否有内容
    if (badgeValue.length == 0 || [badgeValue isEqualToString:@"0"]) {
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
    
    [self setTitle:badgeValue forState:UIControlStateNormal];
}

@end
