//
//  KNCollectionViewController.m
//  XLinkIn
//
//  Created by emper on 16/4/7.
//  Copyright © 2016年 Kevin Yin. All rights reserved.
//

#import "KNCollectionViewController.h"

@interface KNCollectionViewController ()

@end

@implementation KNCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    // 设置CGRectZero从导航栏下开始计算
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

@end
