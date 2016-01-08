//
//  UIBarButtonItem+barButtonItem.m
//  SH微博
//
//  Created by juan on 15/11/5.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "UIBarButtonItem+barButtonItem.h"

@implementation UIBarButtonItem (barButtonItem)

+ (UIBarButtonItem *) barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    
    [btn addTarget:target action:action forControlEvents:controlEvents];
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

@end
