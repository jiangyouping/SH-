//
//  SHStatus.m
//  SH微博
//
//  Created by juan on 15/11/6.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "SHStatus.h"
#import "SHPhoto.h"
#import "MJExtension.h"
#import "NSDate+MJ.h"

@implementation SHStatus

// 实现这个方法，就会自动把数组中的字典转换成对应的模型
+ (NSDictionary *) objectClassInArray
{
    return @{@"pic_urls":[SHPhoto class]};
}

- (void)setRetweeted_status:(SHStatus *)retweeted_status
{
    _retweeted_status = retweeted_status;
    _retweeted_status.user.name = [NSString stringWithFormat:@"@%@",retweeted_status.user.name];
}

- (NSString *) created_at
{
    //Tue Nov 10 13:20:16 +0800 2015
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    NSDate *created_at = [fmt dateFromString:_created_at];
    
    if ([created_at isThisYear]) {
        //今年
        if ([created_at isToday]) {
            //今天
            //计算跟当前的时间差
            NSDateComponents *cmp = [created_at deltaWithNow];
            
            if (cmp.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时之前",cmp.hour];
            } else if(cmp.minute >= 1){
                return [NSString stringWithFormat:@"%ld分钟之前",cmp.minute];
            }else {
                return @"刚刚";
            }
        } else if([created_at isYesterday]){
            //昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:created_at];
        }else{
            //昨天之前
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:created_at];
        }
    }else{
        //去年及之前
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:created_at];
    }
    
    return created_at;
}

//<a href="http://app.weibo.com/t/feed/2O2xZO" rel="nofollow">人民网微博</a>

- (void)setSource:(NSString *)source
{

    NSRange range = [source rangeOfString:@">"];
    source = [source substringFromIndex:range.location + range.length];
    range = [source rangeOfString:@"<"];
    source = [source substringToIndex:range.location];
    source = [NSString stringWithFormat:@"来自%@",source];
    _source = source;
}




@end
