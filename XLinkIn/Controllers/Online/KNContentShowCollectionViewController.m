//
//  KNContentShowCollectionViewController.m
//  XLinkIn
//
//  Created by Kevin Yin on 4/6/16.
//  Copyright © 2016 Kevin Yin. All rights reserved.
//

#import "KNContentShowCollectionViewController.h"
#import "KNOnlineViewController.h"
#import "MJRefresh.h"
#import "KNOnlineCollectionViewCell.h"

#define CollectionViewCell_WIDTH 100

@interface KNContentShowCollectionViewController ()
{
    NSInteger refreshPage;
}
@end

@implementation KNContentShowCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

-(NSMutableArray *)arrayList
{
    if(_arrayList==nil){
        _arrayList= [NSMutableArray array];
    }
    return _arrayList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.collectionView registerClass:[KNOnlineCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];

    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    __weak typeof(self) weakSelf = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
    [self.collectionView.mj_header beginRefreshing];
}

- (void)loadData
{
    refreshPage = 1;
    NSString *url = [NSString stringWithFormat:@"%@%li",_url,(long)refreshPage];
//    NSLog(@"上拉刷新");
//    if([[NetworkSingleton sharedManager] networkReachable] == NO)
//    {
//        NSLog(@"网络断开了！");
//        [self.collectionView.mj_header endRefreshing];
//    }
//    else
//    {
        [self getDataForType:1 WithURL:url];
//    }
}

- (void)loadMoreData
{
    NSLog(@"下拉刷新");
    NSString *url = [NSString stringWithFormat:@"%@%li",_url,(long)refreshPage];
    [self getDataForType:2 WithURL:url];
}

- (NSArray *)parseData:(NSDictionary *)dictionary
{
    NSArray *array = nil;
    if(dictionary != nil)
    {
        array = [[dictionary objectForKey:@"videoshow"] objectForKey:@"videos"];
    }
    return array;
}

- (void)getDataForType:(int)type WithURL:(NSString *)url
{
    NSLog(@"url = %@",url);
    __weak typeof(self) weakSelf = self;
    [[NetworkSingleton sharedManager] getResultWithParameter:nil url:url success:^(id responseObject) {
        NSLog(@"success");
        refreshPage++;
        if(type == 1)
        {
            [_arrayList removeAllObjects];
            NSArray *array = [weakSelf parseData:responseObject];
            [weakSelf.arrayList addObjectsFromArray:array];
            [self.collectionView reloadData];
            [weakSelf.collectionView.mj_header endRefreshing];
        }
        else if(type == 2)
        {
            NSArray *array = [weakSelf parseData:responseObject];
            [weakSelf.arrayList addObjectsFromArray:array];
            [self.collectionView reloadData];
            [weakSelf.collectionView.mj_footer endRefreshing];
        }

    } failure:^(NSError *error) {
        NSLog(@" error = %@",error);
        NSLog(@"failure");
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _arrayList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    KNOnlineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//    cell.imageView = []
    cell.label.text = [[_arrayList objectAtIndex:indexPath.row] objectForKey:@"title"];
//    cell.backgroundColor = [UIColor blueColor];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
//定义每个UICollectionView 的大小（返回CGSize：宽度和高度）
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = CollectionViewCell_WIDTH * 4/3 + 20;
    return CGSizeMake(CollectionViewCell_WIDTH, height);
}
//定义每个UICollectionView 的间距（返回UIEdgeInsets：上、左、下、右）
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGFloat left = (WIDTH_SCREEN - CollectionViewCell_WIDTH * 3)/6;
    return UIEdgeInsetsMake(0, left, 0, left);
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
