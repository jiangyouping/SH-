//
//  SHUserTool.m
//  SH微博
//
//  Created by juan on 15/11/9.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "SHUserTool.h"
#import "SHUserParam.h"
#import "SHUserResult.h"
#import "SHAccountTool.h"
#import "SHUserAccount.h"
#import "SHUser.h"
#import "SHHttpTool.h"

#import "MJExtension.h"

@implementation SHUserTool : NSObject 

+ (void) unreadWithSuccess:(void (^)(SHUserResult *)) success failure:(void (^)(NSError *)) failure
{
    // 创建参数模型
    SHUserParam *param = [[SHUserParam alloc]init];
    param.uid = [SHAccountTool account].uid;
    param.access_token = [SHAccountTool account].access_token;
    
    [SHHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.keyValues success:^(id responseObject) {
        
        // 字典转换模型
        SHUserResult *result = [SHUserResult objectWithKeyValues:responseObject];
        if(success){
            success(result);
        }
        
    } failure:^(NSError *error) {
        
        if(failure){
            failure(error);
        }
        
    }];
}

+ (void) userInfoWithSuccess:(void (^)(SHUser *)) success failure:(void (^)(NSError * )) failure
{
    // 创建参数模型
    SHUserParam *param = [[SHUserParam alloc]init];
    param.uid = [SHAccountTool account].uid;
    param.access_token = [SHAccountTool account].access_token;
    
    [SHHttpTool GET:@"https://api.weibo.com/2/users/show.json" parameters:param.keyValues success:^(id responseObject) {
        
        // 字典转换模型
        SHUser *result = [SHUser objectWithKeyValues:responseObject];
        if(success){
            success(result);
        }
        
    } failure:^(NSError *error) {
        if(failure){
            failure(error);
        }
    }];
}

@end
