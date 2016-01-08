//
//  SHStatusResults.h
//  SH微博
//
//  Created by juan on 15/11/6.
//  Copyright © 2015年 juan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface SHStatusResults : NSObject<MJKeyValue>

/**
 *  用户的微博数组（CZStatus）,其中每条微博信息是一个字典
 */
@property (nonatomic,strong) NSArray *statuses;

/**
 *  用户最近微博总数
 */
@property (nonatomic,assign) int totalNumber;

@end
