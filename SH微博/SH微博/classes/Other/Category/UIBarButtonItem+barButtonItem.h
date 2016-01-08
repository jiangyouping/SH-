//
//  UIBarButtonItem+barButtonItem.h
//  SH微博
//
//  Created by juan on 15/11/5.
//  Copyright © 2015年 juan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (barButtonItem)

+ (UIBarButtonItem *) barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
