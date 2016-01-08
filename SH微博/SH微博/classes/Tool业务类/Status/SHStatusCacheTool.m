//
//  SHStatusCacheTool.m
//  SH微博
//
//  Created by juan on 15/11/12.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "SHStatusCacheTool.h"
#import "FMDB.h"

#import "SHAccountTool.h"
#import "SHUserAccount.h"

#import "SHStatusParams.h"
#import "SHStatus.h"
#import "MJExtension.h"

@implementation SHStatusCacheTool
static FMDatabase *_db;
+ (void)initialize
{
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [cachePath stringByAppendingString:@"status.sqlite"];
    
    //创建一个数据库实例
    _db = [FMDatabase databaseWithPath:filePath];
    
    if ([_db open]) {
        SHLog(@"打开成功");
    } else {
        SHLog(@"打开失败");
    }
    
    // 创建表格
    BOOL flag = [_db executeUpdate:@"create table if not exists t_status (id integer primary key autoincrement,idstr text,access_token text,dict blob);"];
    if (flag) {
        SHLog(@"创建成功");
    }else{
        SHLog(@"创建失败");
    }
}

+ (void)saveStatus:(NSArray *)statuses
{
    //遍历模型数组
    for (NSDictionary *statusDic in statuses) {
        NSString *idstr = statusDic[@"idstr"];
        NSString *access_token = [SHAccountTool account].access_token;
        
        //转化为NSData类型
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:statusDic];
        
        BOOL flag = [_db executeUpdate:@"insert into t_status (idstr,access_token,dict) values(?,?,?);",idstr,access_token,data];
        if (flag) {
            SHLog(@"插入成功");
        }else{
            SHLog(@"插入失败");
        }
    }
}

+ (NSArray *)statusesWithParam:(SHStatusParams *)param
{
    NSString *sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' order by idstr desc limit 20;",param.access_token];
    if (param.since_id) {
        sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@ ' and idstr > '%@' order by idstr desc limit 20;",param.access_token,param.since_id];
    } else if(param.max_id){
        sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' and idstr <= '%@' order by idstr desc limit 20;",param.access_token,param.max_id];
    }
    
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *arrM = [NSMutableArray array];
    while ([set next]) {
        NSData *data = [set dataForColumn:@"dict"];
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        SHStatus *s = [SHStatus objectWithKeyValues:dict];
        [arrM addObject:s];
    }
    
    return arrM;
}

@end
