//
//  KNPhotosViewController.h
//  XLinkIn
//
//  Created by Kevin Yin on 4/4/16.
//  Copyright © 2016 Kevin Yin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KNPhotoViewController : KNViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSArray *photoList;

@end
