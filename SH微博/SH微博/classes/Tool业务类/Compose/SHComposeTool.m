//
//  SHComposeTool.m
//  SH微博
//
//  Created by juan on 15/11/10.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "SHComposeTool.h"
#import "SHHttpTool.h"
#import "SHComposeParam.h"
#import "SHUploadParam.h"

#import "SHAccountTool.h"
#import "SHUserAccount.h"

#import "MJExtension.h"

@implementation SHComposeTool

+ (void)composeWithStatus:(NSString *)status success:(void (^)())success failure:(void (^)(NSError *))failure
{
    // 创建参数模型
    SHComposeParam *param = [[SHComposeParam alloc]init];
    param.access_token = [SHAccountTool account].access_token;
    param.status = status;
    
    [SHHttpTool POST:@"https://api.weibo.com/2/statuses/update.json" parameters:param.keyValues success:^(id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)composeWithStatus:(NSString *)status image:(UIImage *)image success:(void (^)())success failure:(void (^)(NSError *error))failure
{
    //创建参数模型
    SHComposeParam *param = [[SHComposeParam alloc]init];
    param.access_token = [SHAccountTool account].access_token;
    param.status = status;
    
    SHUploadParam *uploadParam = [[SHUploadParam alloc]init];
    uploadParam.data = UIImagePNGRepresentation(image);
    uploadParam.name = @"pic";
    uploadParam.fileName = @"image.png";
    uploadParam.mimeType = @"image/png";
    
    [SHHttpTool Upload:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:param.keyValues uploadParam:uploadParam success:^(id responseObject){
        
        if (success) {
            success();
        }
        
    } failure:^(NSError *error){
        
        if (failure) {
            failure(error);
        }
        
     }];
}

@end
