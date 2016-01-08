//
//  SHTextView.m
//  SH微博
//
//  Created by juan on 15/11/11.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "SHTextView.h"

@interface SHTextView()

@property (nonatomic,weak) UILabel *placeHolderLabel;

@end

@implementation SHTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:13];
    }
    
    return  self;
}

- (UILabel *)placeHolderLabel
{
    if (_placeHolderLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        
        [self addSubview:label];
        
        _placeHolderLabel = label;
    }
    
    return _placeHolderLabel;
}

- (void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = placeHolder;
    
    self.placeHolderLabel.text = placeHolder;
    
    // label的尺寸跟文字一样
    [self.placeHolderLabel sizeToFit];
}

- (void)setHidePlaceHolder:(BOOL)hidePlaceHolder
{
    _hidePlaceHolder = hidePlaceHolder;
    
    self.placeHolderLabel.hidden = hidePlaceHolder;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.placeHolderLabel.x = 5;
    self.placeHolderLabel.y = 8;
    
    [self.placeHolderLabel sizeToFit];
    self.placeHolderLabel.font = self.font;
}

@end
