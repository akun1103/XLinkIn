//
//  KNOnlineViewController.h
//  XLinkIn
//
//  Created by Kevin Yin on 16/4/3.
//  Copyright © 2016年 Kevin Yin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KNOnlineViewController : KNViewController<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *bScrollView;
@property (nonatomic,strong) UIScrollView *sScrollView;
@property (nonatomic,strong) NSArray *arrayList;
@end
