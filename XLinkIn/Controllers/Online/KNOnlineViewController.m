//
//  KNOnlineViewController.m
//  XLinkIn
//
//  Created by Kevin Yin on 16/4/3.
//  Copyright © 2016年 Kevin Yin. All rights reserved.
//

#import "KNOnlineViewController.h"
#import "KNContentShowCollectionViewController.h"
#import "KNMenuLabel.h"
#import "KNMovieDetailViewController.h"
#import "KNDataCacheTool.h"

#define MenuHeight 44
#define movieURL @"http://video.hao123.com/commonapi/movie2level/?type=&area=&actor=&start=&complete=%E6%AD%A3%E7%89%87&order=hot&rating=&prop=&_=1370760423051&page_size=24&pn="
#define televisionURL @"http://video.hao123.com/commonapi/tvplay2level/?filter=false&type=&area=&actor=&start=&complete=&order=hot&rating=&prop=&page_size=24&pn="
#define animeURL @"http://video.hao123.com/commonapi/comic2level/?filter=false&type=&area=&actor=&start=&complete=&order=hot&rating=&prop=&page_size=24&pn="
#define varietyShowURL  @"http://v.hao123.com/commonapi/tvshow2level/?filter=false&type=&area=&actor=&start=&complete=&order=hot&rating=&prop=&page_size=24&pn="

@interface KNOnlineViewController ()
{
    NSMutableArray *labelArray;
    NSMutableArray *controllerArray;
    UICollectionViewFlowLayout *flowLayout;
}
@end

@implementation KNOnlineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"点播";
    self.navigationItem.leftBarButtonItem = nil;
    _arrayList = [NSArray arrayWithObjects:@"电影",@"电视剧",@"动漫",@"综艺", nil];

    [self setScrollView];

}

- (void)setScrollView
{
    UIScrollView *sScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, MenuHeight)];
    sScrollView.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    [self.view addSubview:sScrollView];
    _sScrollView = sScrollView;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, MenuHeight-0.7, WIDTH_SCREEN, 0.7)];
    line.backgroundColor = DEFAULT_LINE_GRAY_COLOR;
    [_sScrollView addSubview:line];
    
    UIScrollView *bScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, MenuHeight, WIDTH_SCREEN, HEIGHT_SCREEN - MenuHeight - 113)];
    CGFloat contentX = _arrayList.count * [UIScreen mainScreen].bounds.size.width;
    bScrollView.contentSize = CGSizeMake(contentX, 0);
    bScrollView.bounces = NO;
    bScrollView.pagingEnabled = YES;
    bScrollView.showsHorizontalScrollIndicator = NO;
//    bScrollView.backgroundColor = [UIColor blueColor];
    bScrollView.delegate = self;
    [self.view addSubview:bScrollView];
    _bScrollView = bScrollView;
    
    [self addLabel];
    [self addController];
    
    KNContentShowCollectionViewController *vc = [controllerArray objectAtIndex:0];
    vc.view.frame = _bScrollView.bounds;
    [_bScrollView addSubview:vc.view];
    KNMenuLabel *label = [labelArray objectAtIndex:0];
    label.scale = 1.0;
}

-(void)addLabel
{
    labelArray = [NSMutableArray arrayWithCapacity:_arrayList.count];
    CGFloat lblW = WIDTH_SCREEN/_arrayList.count;
    CGFloat lblH = MenuHeight;
    CGFloat lblY = 0;
    CGFloat lblX =0;
    for (int i=0 ; i < _arrayList.count ;i++){
        lblX = i * lblW;
        KNMenuLabel *label = [[KNMenuLabel alloc]init];
        label.text = [_arrayList objectAtIndex:i];
        label.frame = CGRectMake(lblX, lblY, lblW, lblH);
        label.textAlignment = NSTextAlignmentCenter;
        [_sScrollView addSubview:label];
        label.tag = i;
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelClicked:)]];
        [labelArray addObject:label];
    }
    //设置小scroll滚动的范围
    _sScrollView.contentSize=CGSizeMake(lblW*_arrayList.count, 0);
}

- (void)addController
{
    controllerArray = [NSMutableArray arrayWithCapacity:_arrayList.count];
    NSArray *urlArray = [NSArray arrayWithObjects:movieURL,televisionURL,animeURL,varietyShowURL, nil];
    NSArray *idArray = [NSArray arrayWithObjects:@"Movie",@"Television",@"Anime",@"varietyShow", nil];
    for(int i = 0; i < _arrayList.count; i++)
    {
        KNContentShowCollectionViewController *controller = [[KNContentShowCollectionViewController alloc] init];
        controller.url = urlArray[i];
        controller.idStr = idArray[i];
//        NSArray *arr = [KNDataCacheTool dataWithID:idArray[i]];
//        [controller.arrayList addObjectsFromArray:arr];
        __weak typeof(self) weakSelf = self;
        controller.showContent = ^(NSDictionary *dic){
            NSLog(@"dic = %@",dic);
            KNMovieDetailViewController *controller = [[KNMovieDetailViewController alloc] init];
            [weakSelf setHidesBottomBarWhenPushed:YES];
            [weakSelf.navigationController pushViewController:controller animated:YES];
            [weakSelf setHidesBottomBarWhenPushed:NO];
        };
        [controllerArray addObject:controller];
    }
}



- (void)labelClicked:(UITapGestureRecognizer *)recognizer
{
    KNMenuLabel *titlelable = (KNMenuLabel *)recognizer.view;
    CGFloat offsetX = titlelable.tag * _bScrollView.frame.size.width;
    CGFloat offsetY = _bScrollView.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    [_bScrollView setContentOffset:offset animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - ******************** scrollView代理方法
/** 滚动结束（手势导致） */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/** 滚动结束后调用（代码导致） */
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView

{
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / _bScrollView.frame.size.width;
    
    // 滚动标题栏
    KNMenuLabel *titleLable = (KNMenuLabel *)_sScrollView.subviews[index];
    
    CGFloat offsetx = titleLable.center.x - _sScrollView.frame.size.width * 0.5;
    
    CGFloat offsetMax = _sScrollView.contentSize.width - _sScrollView.frame.size.width;
    
    if (offsetx < 0) {
        offsetx = 0;
    }else if (offsetx > offsetMax){
        offsetx = offsetMax;
    }
    
    CGPoint offset = CGPointMake(offsetx, _sScrollView.contentOffset.y);
    //  NSLog(@"%@",NSStringFromCGPoint(offset));
    [_sScrollView setContentOffset:offset animated:YES];
    // 添加控制器
    KNContentShowCollectionViewController *newsVc = controllerArray[index];
//    newsVc.index = index;
    
    
    
    
    [labelArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        KNMenuLabel *temlabel = labelArray[idx];
        if (idx != index )
        {
            temlabel.scale = 0.0;
        }
        else
        {
            temlabel.scale = 1.0;
        }
    }];
    
    if (newsVc.view.superview) return;
    
    newsVc.view.frame = scrollView.bounds;
    [_bScrollView addSubview:newsVc.view];
}



/** 正在滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 取出绝对值 避免最左边往右拉时形变超过1
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    KNMenuLabel *labelLeft = labelArray[leftIndex];
    labelLeft.scale = scaleLeft;
//     考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
    if (rightIndex < labelArray.count) {
        
        KNMenuLabel *labelRight = labelArray[rightIndex];
        
        labelRight.scale = scaleRight;
    }
    
}

@end
