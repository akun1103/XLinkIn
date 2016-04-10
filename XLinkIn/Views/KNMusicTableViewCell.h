//
//  KNMusicTableViewCell.h
//  XLinkIn
//
//  Created by Kevin Yin on 4/9/16.
//  Copyright © 2016 Kevin Yin. All rights reserved.
//

#import "KNCommonTableViewCell.h"

@interface KNMusicTableViewCell : KNCommonTableViewCell

@property (nonatomic,strong) UIImageView *thumbnailImageView;
@property (nonatomic,strong) UILabel *titile;
@property (nonatomic,strong) UILabel *artist;
@property (nonatomic,strong) UIView *leftView;
@end
