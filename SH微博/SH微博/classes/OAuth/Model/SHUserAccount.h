//
//  SHUserAccount.h
//  SH微博
//
//  Created by juan on 15/11/6.
//  Copyright © 2015年 juan. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  access_token	string	用于调用access_token，接口获取授权后的access token。
 expires_in	string	access_token的生命周期，单位是秒数。
 remind_in	string	access_token的生命周期（该参数即将废弃，开发者请使用expires_in）。
 uid	string	当前授权用户的UID。
 */
@interface SHUserAccount : NSObject<NSCoding>

/**
 *  获取数据的访问命令牌
 */
@property (nonatomic, copy) NSString *access_token;

/**
 *  账号的有效期
 */
@property (nonatomic, copy) NSString *expires_in;

/**
 *  用户唯一标识符
 */
@property (nonatomic, copy) NSString *uid;

/**
 *   过期时间 = 当前保存时间+有效期
 */
@property (nonatomic, strong) NSDate *expires_date;

/**
 *  账号的有效期
 */
@property (nonatomic, copy) NSString *remind_in;

/**
 *  用户的昵称
 */
@property (nonatomic, copy) NSString *name;


+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
