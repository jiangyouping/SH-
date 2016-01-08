//
//  SHUserParam.h
//  SH微博
//
//  Created by juan on 15/11/9.
//  Copyright © 2015年 juan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHUserParam : NSObject

/**
 *  采用OAuth授权方式为必填参数,访问命令牌
 */
@property (nonatomic, copy) NSString *access_token;

/**
 *  要查询用户的Uid
 */
@property (nonatomic, copy) NSString *uid;

@end
