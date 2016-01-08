//
//  SHHttpTool.m
//  SH微博
//
//  Created by juan on 15/11/6.
//  Copyright © 2015年 juan. All rights reserved.
//
//

#import "SHHttpTool.h"
#import "AFNetworking.h"
#import "SHUploadParam.h"

@implementation SHHttpTool

+ (void)GET:(NSString *)URLWithString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *error)) failure
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr GET:URLWithString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (success) {
            success(responseObject);
            //SHLog(@"%@",responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)POST:(NSString *)URLWithString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *error)) failure
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr POST:URLWithString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)Upload:(NSString *)URLWithString parameters:(id)parameters uploadParam:(SHUploadParam *)uploadParam success:(void (^)(id))success failure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr POST:URLWithString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        // 上传的文件全部拼接到formData
        /**
         *  FileData:要上传的文件的二进制数据
         *  name:上传参数名称
         *  fileName：上传到服务器的文件名称
         *  mimeType：文件类型
         */
        [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.fileName mimeType:uploadParam.mimeType];
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
