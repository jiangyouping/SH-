//
//  SHAccountTool.h
//  SH微博
//
//  Created by juan on 15/11/6.
//  Copyright © 2015年 juan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SHUserAccount;
@interface SHAccountTool : NSObject


//存
+ (void) saveUserAccount:(SHUserAccount *) account;

//取
+ (SHUserAccount *)account;

+ (void)accountWithCode:(NSString *)code success:(void(^)())success failure:(void(^)(NSError *error))failure;

@end