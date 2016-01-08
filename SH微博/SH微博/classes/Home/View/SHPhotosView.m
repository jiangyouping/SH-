//
//  SHPhotosView.m
//  SH微博
//
//  Created by juan on 15/11/10.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "SHPhotosView.h"
#import "SHPhoto.h"
#import "SHPhotoView.h"

#import "SHPhotoView.h"
#import "UIImageView+WebCache.h"

#import "MJPhoto.h"
#import "MJPhotoBrowser.h"


@implementation SHPhotosView

- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //self.backgroundColor = [UIColor redColor];
        [self setUpAllChildViews];
    }
    return self;
}

// 添加9个子控件
- (void) setUpAllChildViews
{
    for (int i = 0; i<9; i++) {
        SHPhotoView *photoView = [[SHPhotoView alloc]init];
        photoView.tag = i;
        
        // 添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [photoView addGestureRecognizer:tap];
        
        [self addSubview:photoView];
    }
}

#pragma mark - 点击图片的时候调用
- (void) tap:(UIGestureRecognizer *)tap
{
    UIImageView *tapView = tap.view;
    
    int i = 0;
    NSMutableArray *arrM = [[NSMutableArray alloc]init];
    //SHPhoto -> MJPhoto
    for (SHPhoto *photo in _pic_urls) {
        
        NSString *urlStr = photo.thumbnail_pic.absoluteString;
        urlStr = [urlStr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        
        MJPhoto *p = [[MJPhoto alloc]init];
        p.url = [NSURL URLWithString:urlStr];
        p.index = i;
        p.srcImageView = tapView;
        [arrM addObject:p];
        i++;
        
    }
    
    
    // 弹出图片浏览器
    // 创建浏览器对象
    MJPhotoBrowser *brower = [[MJPhotoBrowser alloc] init];
    // MJPhoto
    brower.photos = arrM;
    brower.currentPhotoIndex = tapView.tag;
    [brower show];
}

- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    
    int count = self.subviews.count;
    for (int i = 0; i<count; i++) {
        SHPhotoView *imageView = self.subviews[i];
        
        if (i < _pic_urls.count) {
            imageView.hidden = NO;
            
            SHPhoto *photo = _pic_urls[i];
            
            imageView.photo = photo;
        }else{
            imageView.hidden = YES;
        }
    }
    
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 70;
    CGFloat h = 70;
    CGFloat margin = 10;
    int col = 0;
    int rol = 0;
    int cols = _pic_urls.count==4?2:3;
    
    for (int i = 0; i < _pic_urls.count; i++) {
        col = i % cols;
        rol = i / cols;
        UIImageView *imageV = self.subviews[i];
        x = col * (w + margin);
        y = rol * (h + margin);
        imageV.frame = CGRectMake(x, y, w, h);
    }
}

@end
