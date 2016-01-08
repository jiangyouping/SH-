//
//  SHStatusCacheTool.h
//  SH微博
//
//  Created by juan on 15/11/12.
//  Copyright © 2015年 juan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SHStatusParams;
@interface SHStatusCacheTool : NSObject

//statues为模型数组
//存
+ (void)saveStatus:(NSArray *)statuses;

//取
+ (NSArray *)statusesWithParam:(SHStatusParams *)param;
@end
