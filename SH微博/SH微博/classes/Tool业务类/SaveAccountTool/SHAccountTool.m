//
//  SHAccountTool.m
//  SH微博
//
//  Created by juan on 15/11/6.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "SHAccountTool.h"
#import "SHUserAccount.h"

@implementation SHAccountTool

//类方法一般用静态变量，不用成员属性
static SHUserAccount *_account;

+ (void) saveUserAccount:(SHUserAccount *) account
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *fileName = [path stringByAppendingPathComponent:@"account.data"];
    [NSKeyedArchiver archiveRootObject:account toFile:fileName];
}

+ (SHUserAccount *)account
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *fileName = [path stringByAppendingPathComponent:@"account.data"];
    if (_account == nil) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
    
    //判断账号是否过期
        if ([[NSDate date] compare:_account.expires_date]!= NSOrderedAscending) {
        // 过期
            return nil;
        }
    }
    return _account;
}


+ (void)accountWithCode:(NSString *)code success:(void(^)())success failure:(void(^)(NSError *error))failure
{
    
}

@end
