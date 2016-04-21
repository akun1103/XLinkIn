//
//  KNLiveViewController.h
//  XLinkIn
//
//  Created by Kevin Yin on 16/4/3.
//  Copyright © 2016年 Kevin Yin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KNLiveViewController : KNViewController<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *bScrollView;
@property (nonatomic,strong) UIScrollView *sScrollView;
@property (nonatomic,copy) NSArray *channelTypeList;
@property (nonatomic,copy) NSArray *channelDataList;

@end
