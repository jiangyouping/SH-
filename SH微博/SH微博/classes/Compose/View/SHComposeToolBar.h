//
//  SHComposeToolBar.h
//  SH微博
//
//  Created by juan on 15/11/11.
//  Copyright © 2015年 juan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHComposeToolBar;
@protocol SHComposeToolBarDelegate <NSObject>

@optional
- (void)composeToolBar:(SHComposeToolBar *)toolBar didClickBtn:(NSInteger)index;

@end

@interface SHComposeToolBar : UIView

@property (nonatomic,weak) id<SHComposeToolBarDelegate> delegate;

@end
