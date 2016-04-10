//
//  KNMenuLabel.m
//  XLinkIn
//
//  Created by Kevin Yin on 4/5/16.
//  Copyright © 2016 Kevin Yin. All rights reserved.
//

#import "KNMenuLabel.h"

@implementation KNMenuLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:19];
        self.scale = 0.0;
    }
    return self;
}



/** 通过scale的改变改变多种参数 */
- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    
    self.textColor = [UIColor colorWithRed:scale * 50.0/255.0 green:scale * 163.0/255.0 blue:scale * 221.0/255.0 alpha:1];
    
    CGFloat minScale = 0.85;
    CGFloat trueScale = minScale + (1-minScale)*scale;
    self.transform = CGAffineTransformMakeScale(trueScale, trueScale);
}

@end
