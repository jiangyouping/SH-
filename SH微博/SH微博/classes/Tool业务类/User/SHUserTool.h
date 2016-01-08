//
//  SHUserTool.h
//  SH微博
//
//  Created by juan on 15/11/9.
//  Copyright © 2015年 juan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SHUserResult,SHUser;

@interface SHUserTool : NSObject

/**
 *  请求用户的未读书
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void) unreadWithSuccess:(void (^)(SHUserResult *result)) success failure:(void (^)(NSError *error)) failure;

/**
 *  请求用户的信息
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void) userInfoWithSuccess:(void (^)(SHUser *result)) success failure:(void (^)(NSError * error)) failure;

@end
