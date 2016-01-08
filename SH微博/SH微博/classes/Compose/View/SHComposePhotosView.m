//
//  SHComposePhotosView.m
//  SH微博
//
//  Created by juan on 15/11/11.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "SHComposePhotosView.h"

@implementation SHComposePhotosView

- (void)setImage:(UIImage *)image
{
    _image = image;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    
    [self addSubview:imageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger cols = 3;
    CGFloat marign = 10;
    CGFloat wh = (self.width - (cols - 1) * marign) / cols;
    
    CGFloat x = 0;
    CGFloat y = 0;
    NSInteger col = 0;
    NSInteger row = 0;
    
    for (int i = 0; i < self.subviews.count; i++) {
        UIImageView *imageV = self.subviews[i];
        col = i % cols;
        row = i / cols;
        x = col * (marign + wh);
        y = row * (marign + wh);
        imageV.frame = CGRectMake(x, y, wh, wh);
    }
    
}

@end
