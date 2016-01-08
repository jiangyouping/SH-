//
//  SHNewFeatureCell.h
//  SH微博
//
//  Created by juan on 15/11/5.
//  Copyright © 2015年 juan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHNewFeatureCell : UICollectionViewCell

@property (nonatomic,strong) UIImage *image;

// 判断是否是最后一页
- (void)setIndexPath:(NSIndexPath *)indexPath count:(int)count;

@end
