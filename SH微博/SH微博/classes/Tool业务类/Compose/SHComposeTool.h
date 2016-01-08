//
//  SHComposeTool.h
//  SH微博
//
//  Created by juan on 15/11/10.
//  Copyright © 2015年 juan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHComposeTool : NSObject

/**
 *  发送文字微博
 *
 *  @param status  发送微博内容
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */
+ (void)composeWithStatus:(NSString *)status success:(void (^)())success failure:(void (^)(NSError *error))failure;

/**
 *  发送图片微博
 *
 *  @param status  发送微博内容
 *  @param image   发送微博图片
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */
+ (void)composeWithStatus:(NSString *)status image:(UIImage *)image success:(void (^)())success failure:(void (^)(NSError *error))failure;

@end
