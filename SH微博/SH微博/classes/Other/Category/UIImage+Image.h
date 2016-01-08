//
//  UIImage+Image.h
//  SH微博
//
//  Created by juan on 15/11/5.
//  Copyright © 2015年 juan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)

+ (instancetype) imageWithOriginalName:(NSString *)imageName;

+ (instancetype)imageWithStretchableName:(NSString *)imageName;

@end
