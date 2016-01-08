//
//  SHStatusResults.m
//  SH微博
//
//  Created by juan on 15/11/6.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "SHStatusResults.h"

#import "SHStatus.h"

@implementation SHStatusResults

+ (NSDictionary *)objectClassInArray
{
    return @{@"statuses":[SHStatus class]};
}


@end
