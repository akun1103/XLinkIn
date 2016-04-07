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
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 90, 120)];
        _label = [[UILabel alloc] initWithFrame:CGRectMake(5, 125, 90, 20)];
        [self addSubview:_imageView];
        [self addSubview:_label];
    }
    return self;
}
@end
