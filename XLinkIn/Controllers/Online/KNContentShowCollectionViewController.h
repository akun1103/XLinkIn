//
//  KNContentShowCollectionViewController.h
//  XLinkIn
//
//  Created by Kevin Yin on 4/6/16.
//  Copyright © 2016 Kevin Yin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShowContentBlock)(NSDictionary * dictionary);

@interface KNContentShowCollectionViewController : KNViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) NSString *idStr;
@property (copy) ShowContentBlock showContent;
@property (nonatomic,strong) NSDictionary *dataDic;
@property (nonatomic,strong) NSMutableArray *arrayList;
@property (nonatomic,strong) UICollectionView *collectionView;
@end
