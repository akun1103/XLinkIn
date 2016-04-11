//
//  KNVideoCollectionViewCell.m
//  XLinkIn
//
//  Created by emper on 16/4/11.
//  Copyright © 2016年 Kevin Yin. All rights reserved.
//

#import "KNVideoCollectionViewCell.h"

@implementation KNVideoCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _thumbnailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frameWidth, self.frameHeight)];
        _thumbnailImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_thumbnailImageView setClipsToBounds:YES];
        [self addSubview:_thumbnailImageView];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frameHeight/2, self.frameHeight - 20,self.frameHeight/2 - 5, 20)];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.font = [UIFont systemFontOfSize:12.0];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_timeLabel];
    }
    return self;
}

@end
