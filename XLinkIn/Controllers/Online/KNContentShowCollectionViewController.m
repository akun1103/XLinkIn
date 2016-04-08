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
#import "KNDataCacheTool.h"

#define CollectionViewCell_WIDTH 100

@interface KNContentShowCollectionViewController ()
{
    NSInteger refreshPage;
}
@end

@implementation KNContentShowCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(_arrayList == nil)
    {
        _arrayList = [NSMutableArray array];
    }
    //加载缓存数据
    [_arrayList addObjectsFromArray:[self readCacheDataForType:_idStr]];
    // Register cell classes
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.collectionView registerClass:[KNOnlineCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];

    __weak typeof(self) weakSelf = self;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadData];
    }];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
    self.collectionView.mj_footer.automaticallyHidden = YES;
    [self.collectionView.mj_header beginRefreshing];
    //监控网络状态
    [[NetworkSingleton sharedManager] MonitorReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"%ld",(long)status);
    }];
}

- (NSArray *)readCacheDataForType:(NSString *)type
{
    NSArray *arr = [KNDataCacheTool dataWithID:type];
    return arr;
}

- (void)loadData
{
    NSLog(@"上拉刷新");
    refreshPage = 1;
    NSString *url = [NSString stringWithFormat:@"%@%li",_url,(long)refreshPage];

    if([[NetworkSingleton sharedManager] networkReachable] == NO)
    {
        [self.collectionView.mj_header endRefreshing];
    }
    else
    {
        [self getDataForType:1 WithURL:url];
    }
}

- (void)loadMoreData
{
    NSLog(@"下拉刷新");
    NSString *url = [NSString stringWithFormat:@"%@%li",_url,(long)refreshPage];
    if([[NetworkSingleton sharedManager] networkReachable] == NO)
    {
        NSLog(@"网络断开了！");
        [self.collectionView.mj_header endRefreshing];
    }
    else
    {
        [self getDataForType:2 WithURL:url];
    }

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
            //只缓存最新一页的数据
            [KNDataCacheTool deleteWidthId:weakSelf.idStr];
            [KNDataCacheTool addArr:array andId:weakSelf.idStr];
            
            [weakSelf.arrayList addObjectsFromArray:array];
            [weakSelf.collectionView reloadData];
            [weakSelf.collectionView.mj_header endRefreshing];
        }
        else if(type == 2)
        {
            NSArray *array = [weakSelf parseData:responseObject];
            [weakSelf.arrayList addObjectsFromArray:array];
            [weakSelf.collectionView reloadData];
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
    NSString *url = [[_arrayList objectAtIndex:indexPath.row] objectForKey:@"imgh_url"];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"movie_default"]];
    cell.label.text = [[_arrayList objectAtIndex:indexPath.row] objectForKey:@"title"];
    return cell;
}

#pragma mark <UICollectionViewDelegate>
//定义每个UICollectionView 的大小（返回CGSize：宽度和高度）
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = CollectionViewCell_WIDTH * 4/3 + 18;
    return CGSizeMake(CollectionViewCell_WIDTH, height);
}
//定义每个UICollectionView 的间距（返回UIEdgeInsets：上、左、下、右）
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGFloat left = (WIDTH_SCREEN - CollectionViewCell_WIDTH * 3)/6;
    return UIEdgeInsetsMake(5, left, 0, left);
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    self.showContent(_arrayList[indexPath.row]);
}

@end
