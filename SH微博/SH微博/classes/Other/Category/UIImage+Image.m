//
//  UIImage+Image.m
//  SH微博
//
//  Created by juan on 15/11/5.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)

+ (instancetype) imageWithOriginalName:(NSString *)imageName
{
    UIImage * image = [UIImage imageNamed:@"imageName"];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (instancetype)imageWithStretchableName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
