//
//  KNSimleMusicControlView.h
//  XLinkIn
//
//  Created by Kevin Yin on 4/9/16.
//  Copyright © 2016 Kevin Yin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KNSimleMusicControlView : UIView

@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UIButton *playOrPauseBtn;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *artistLabel;
@property(nonatomic,strong) UIView *progressView;

@property (nonatomic,assign) int str;
@end
