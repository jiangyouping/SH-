//
//  SHUser.m
//  SH微博
//
//  Created by juan on 15/11/7.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "SHUser.h"

@implementation SHUser

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    _vip = mbtype > 2;
}

@end
