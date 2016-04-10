//
//  KNMusicTableViewCell.m
//  XLinkIn
//
//  Created by Kevin Yin on 4/9/16.
//  Copyright © 2016 Kevin Yin. All rights reserved.
//

#import "KNMusicTableViewCell.h"

@implementation KNMusicTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _thumbnailImageView = [[UIImageView alloc] init];
        [self addSubview:_thumbnailImageView];
        
        _titile = [[UILabel alloc] init];
        _titile.font = [UIFont systemFontOfSize:16.0];
        [self addSubview:_titile];
        
        _artist = [[UILabel alloc] init];
        _artist.font = [UIFont systemFontOfSize:11.0];
        _artist.textColor = DEFAULT_TEXT_GRAY_COLOR;
        [self addSubview:_artist];
        
        _leftView = [[UIView alloc] init];
        _leftView.backgroundColor = DEFAULT_TABBAR_COLOR;
        _leftView.hidden = YES;
        [self addSubview:_leftView];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    float spaceX = self.leftFreeSpace;
    float spaceY = self.frameHeight *0.08;
    float height = self.frameHeight - spaceY * 2;
    float labelHeight = self.frameHeight * 0.4;
    float x = spaceX + spaceY * 2 + height;
    float labelWidth = self.frameWidth - x - spaceX;
    [_thumbnailImageView setFrame:CGRectMake(spaceX, spaceY, height, height)];
    
    [_titile setFrame:CGRectMake(x, spaceY * 2, labelWidth, labelHeight)];
    [_artist setFrame:CGRectMake(x, spaceY * 2 + labelHeight, labelWidth, labelHeight)];
    
    [_leftView setFrame:CGRectMake(0, 0, spaceX/2, self.frameHeight)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
