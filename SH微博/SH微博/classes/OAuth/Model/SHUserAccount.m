//
//  SHUserAccount.m
//  SH微博
//
//  Created by juan on 15/11/6.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "SHUserAccount.h"

#define CZAccountTokenKey @"token"
#define CZUidKey @"uid"
#define CZExpires_inKey @"exoires"
#define CZExpires_dateKey @"date"

@implementation SHUserAccount

//字典转模型
+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    SHUserAccount *account = [[SHUserAccount alloc]init];
    [account setValuesForKeysWithDictionary:dict];
    return account;
}

- (void)setExpires_in:(NSString *)expires_in
{
    _expires_in = expires_in;
    
    // 计算过期的时间 = 当前时间 + 有效期
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
}

// 归档的时候调用：告诉系统哪个属性需要归档，如何归档
- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_access_token forKey:CZAccountTokenKey];
    [aCoder encodeObject:_expires_in forKey:CZExpires_inKey];
    [aCoder encodeObject:_uid forKey:CZUidKey];
    [aCoder encodeObject:_expires_date forKey:CZExpires_dateKey];
}

// 解档的时候调用：告诉系统哪个属性需要解档，如何解档
- (id) initWithCoder:(NSCoder *)aDecoder
{
    _access_token =  [aDecoder decodeObjectForKey:CZAccountTokenKey];
    _expires_in = [aDecoder decodeObjectForKey:CZExpires_inKey];
    _uid = [aDecoder decodeObjectForKey:CZUidKey];
    _expires_date = [aDecoder decodeObjectForKey:CZExpires_dateKey];
    
    return self;
}

@end
