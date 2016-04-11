//
//  KNMovieViewController.h
//  XLinkIn
//
//  Created by Kevin Yin on 4/5/16.
//  Copyright © 2016 Kevin Yin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWPhotoBrowser.h"

@interface KNVideoViewController : KNViewController<UICollectionViewDataSource,UICollectionViewDelegate,MWPhotoBrowserDelegate>

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSArray *videoList;

@end
