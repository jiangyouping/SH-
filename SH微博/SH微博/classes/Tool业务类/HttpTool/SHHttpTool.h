//
//  SHHttpTool.h
//  SH微博
//
//  Created by juan on 15/11/6.
//  Copyright © 2015年 juan. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SHUploadParam;
@interface SHHttpTool : NSObject

/*[mgr GET:(NSString *) parameters:(id) success:^(AFHTTPRequestOperation *operation, id responseObject) {

} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
}]
*/


+ (void)GET:(NSString *) URLWithString parameters:(id) parameters success:(void (^)(id responseObject)) success failure:(void (^)(NSError *error)) failure;

+ (void)POST:(NSString *)URLWithString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *error)) failure;

+ (void)Upload:(NSString *)URLWithString parameters:(id)parameters uploadParam:(SHUploadParam *)uploadParam success:(void (^)(id))success failure:(void (^)(NSError *error))failure;
@end
