//
//  KNLiveTableViewCell.m
//  XLinkIn
//
//  Created by emper on 16/4/21.
//  Copyright © 2016年 Kevin Yin. All rights reserved.
//

#import "KNLiveTableViewCell.h"

@implementation KNLiveTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.contentMode = UIViewContentModeScaleToFill;
        [_iconImageView setClipsToBounds:YES];
        [self addSubview:_iconImageView];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:19];
        [self addSubview:_nameLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float space = self.leftFreeSpace;
    [_iconImageView setFrame:CGRectMake(space, self.frameHeight * 0.1, self.frameHeight * 0.8, self.frameHeight * 0.8)];
    [_nameLabel setFrame:CGRectMake(space + self.frameHeight, 0, self.frameWidth - self.frameHeight - space * 2, self.frameHeight)];
}

@end
