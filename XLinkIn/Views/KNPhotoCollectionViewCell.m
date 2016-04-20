//
//  KNPhotoCollectionViewCell.m
//  XLinkIn
//
//  Created by Kevin Yin on 4/10/16.
//  Copyright © 2016 Kevin Yin. All rights reserved.
//

#import "KNPhotoCollectionViewCell.h"

@implementation KNPhotoCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _thumbnailImageView = [[UIImageView alloc] init];
        _thumbnailImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_thumbnailImageView setClipsToBounds:YES];
        [self addSubview:_thumbnailImageView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_thumbnailImageView setFrame:CGRectMake(0, 0, self.frameWidth, self.frameHeight)];
}
@end
