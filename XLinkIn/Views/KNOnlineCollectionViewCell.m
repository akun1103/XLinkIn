//
//  KNOnlineCollectionViewCell.m
//  XLinkIn
//
//  Created by emper on 16/4/7.
//  Copyright © 2016年 Kevin Yin. All rights reserved.
//

#import "KNOnlineCollectionViewCell.h"

@implementation KNOnlineCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _imageView = [[UIImageView alloc] init];
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:_imageView];
        [self addSubview:_label];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_imageView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-18)];
    [_label setFrame:CGRectMake(0, self.frame.size.height-16, self.frame.size.width, 16)];
}
@end
