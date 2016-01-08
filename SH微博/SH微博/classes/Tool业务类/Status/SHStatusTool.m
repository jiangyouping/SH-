//
//  SHStatusTool.m
//  SH微博
//
//  Created by juan on 15/11/6.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "SHStatusTool.h"
#import "SHStatusParams.h"
#import "SHStatusResults.h"
#import "SHAccountTool.h"
#import "SHUserAccount.h"

#import "SHHttpTool.h"
#import "SHStatusCacheTool.h"

#define StringWithURL @"https://api.weibo.com/2/statuses/home_timeline.json"



@implementation SHStatusTool

+(void)newStatusWithSinceID:(NSString *)sinceID success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    SHStatusParams *params = [[SHStatusParams alloc] init];
    params.access_token = [SHAccountTool account].access_token;
    if (sinceID) {
        // 有微博数据，才需要下拉刷新
        params.since_id = sinceID;
    }
    
    // 先从数据库里面取数据
    NSArray *statuses = [SHStatusCacheTool statusesWithParam:params];
    if (statuses.count) {
        if (success) {
            success(statuses);
        }
        return;
    }
    
    [SHHttpTool GET:StringWithURL parameters:params.keyValues success:^(id responseObject) {

        //字典转模型
        SHStatusResults *results = [SHStatusResults objectWithKeyValues:responseObject];
        //        // 获取微博字典数组
        //        NSArray *dictArr = responseObject[@"statuses"];
        //        // 把字典数组转换成模型数组
        //        NSArray *statuses = (NSMutableArray *)[SHStatus objectArrayWithKeyValuesArray:dictArr];
        //        SHLog(@"%@",results);
        if (success) {
            success(results.statuses);
        }
        
        // 一定要保存服务器最原始的数据
        // 有新的数据，保存到数据库
        [SHStatusCacheTool saveStatus:responseObject[@"statuses"]];
        
    } failure:^(NSError *error) {
        if (error) {
            failure(error);
        }
    }];

}

+ (void)moreStatusWithMaxID:(NSString *)maxID success:(void (^)(NSArray *)) success failure :(void (^)(NSError *))failure
{
    SHStatusParams *params = [[SHStatusParams alloc] init];
    params.access_token = [SHAccountTool account].access_token;
    if (maxID) {
        params.max_id = maxID;
    }
    
    // 先从数据库里面取数据
    NSArray *statuses = [SHStatusCacheTool statusesWithParam:params];
    if (statuses.count) {
        if (success) {
            success(statuses);
        }
        return;
    }
    
    [SHHttpTool GET:StringWithURL parameters:params.keyValues success:^(id responseObject) {
        //字典转模型
        SHStatusResults *results = [SHStatusResults objectWithKeyValues:responseObject];
        if (success) {
            success(results.statuses);
        }
        
        // 有新的数据，保存到数据库
        [SHStatusCacheTool saveStatus:responseObject[@"statuses"]];
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
     
}

@end

