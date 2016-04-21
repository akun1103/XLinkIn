//
//  KNLiveViewController.m
//  XLinkIn
//
//  Created by Kevin Yin on 16/4/3.
//  Copyright © 2016年 Kevin Yin. All rights reserved.
//

#import "KNLiveViewController.h"
#import "KNLiveTableViewController.h"
#import "KNMenuLabel.h"

#define MenuHeight 44
#define LiveChannelURL @"http://live.shanzhai.us/licenseFile/live/channelListNew_.html"
@interface KNLiveViewController ()
{
    NSMutableArray *labelArray;
    NSMutableArray *controllerArray;
}
@end

@implementation KNLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"直播";
    self.navigationItem.leftBarButtonItem = nil;
    [self getLivechannelList];
}

- (void)parseLiveChannelWithDictionary:(NSDictionary *)dictionary {
    NSArray *array = [dictionary objectForKey:@"typeLists"];
    NSMutableArray *channelTypeList = [NSMutableArray arrayWithCapacity:array.count];
    NSMutableArray *channelDataList = [NSMutableArray arrayWithCapacity:array.count];
    for(int i = 0; i < array.count; i++) {
        if (i > 5) {
            break;
        }
        NSDictionary *dic = [array objectAtIndex:i];
        [channelTypeList addObject:[dic objectForKey:@"name"]];
        [channelDataList addObject:[[dic objectForKey:@"map"] objectForKey:@"channelLists"]];
    }
    _channelTypeList = channelTypeList;
    _channelDataList = channelDataList;
}

- (void)getLivechannelList {
    [SVProgressHUD showWithStatus:@"加载中，请稍后。。。"];
    __weak typeof(self) weakSelf = self;
    [[NetworkSingleton sharedManager] postResultWithParameter:nil url:LiveChannelURL success:^(id responseObject) {
        NSLog(@"ok");
        [weakSelf parseLiveChannelWithDictionary:[KNTools jsonDataToDictionary:responseObject]];
        [weakSelf setScrollView];
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        NSLog(@"error");
        [SVProgressHUD dismiss];
    }];
}

- (void)setScrollView {
    UIScrollView *sScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, MenuHeight)];
    sScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:sScrollView];
    _sScrollView = sScrollView;
    
    UIScrollView *bScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, MenuHeight, WIDTH_SCREEN, HEIGHT_SCREEN - MenuHeight - 113)];
    CGFloat contentX = _channelTypeList.count * [UIScreen mainScreen].bounds.size.width;
    bScrollView.contentSize = CGSizeMake(contentX, 0);
    bScrollView.bounces = NO;
    bScrollView.pagingEnabled = YES;
    bScrollView.showsHorizontalScrollIndicator = NO;
    bScrollView.delegate = self;
    [self.view addSubview:bScrollView];
    _bScrollView = bScrollView;
    
    [self addLabel];
    [self addController];
    
    KNLiveTableViewController *vc = [controllerArray objectAtIndex:0];
    vc.view.frame = _bScrollView.bounds;
    [_bScrollView addSubview:vc.view];
    KNMenuLabel *label = [labelArray objectAtIndex:0];
    label.scale = 1.0;
}

-(void)addLabel
{
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, MenuHeight-0.7, WIDTH_SCREEN * _channelTypeList.count/4, 0.7)];
    line.backgroundColor = DEFAULT_LINE_GRAY_COLOR;
    [_sScrollView addSubview:line];
    
    labelArray = [NSMutableArray arrayWithCapacity:_channelTypeList.count];
    CGFloat lblW = WIDTH_SCREEN/4;
    CGFloat lblH = MenuHeight;
    CGFloat lblY = 0;
    CGFloat lblX =0;
    for (int i=0 ; i < _channelTypeList.count ;i++){
        lblX = i * lblW;
        KNMenuLabel *label = [[KNMenuLabel alloc]init];
        label.text = [_channelTypeList objectAtIndex:i];
        label.frame = CGRectMake(lblX, lblY, lblW, lblH);
        label.textAlignment = NSTextAlignmentCenter;
        [_sScrollView addSubview:label];
        label.tag = i;
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelClicked:)]];
        [labelArray addObject:label];
    }
    //设置小scroll滚动的范围
    _sScrollView.contentSize=CGSizeMake(lblW*_channelTypeList.count, 0);
}

- (void)addController
{
    controllerArray = [NSMutableArray arrayWithCapacity:_channelTypeList.count];
    for(int i = 0; i < _channelTypeList.count; i++)
    {
        KNLiveTableViewController *controller = [[KNLiveTableViewController alloc] init];
        controller.channelDataList = [_channelDataList objectAtIndex:i];
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
    KNMenuLabel *titleLable = labelArray[index];
    
    CGFloat offsetx = titleLable.center.x - _sScrollView.frame.size.width * 0.5;
    
    CGFloat offsetMax = _sScrollView.contentSize.width - _sScrollView.frame.size.width;
    
    if (offsetx < 0) {
        offsetx = 0;
    }else if (offsetx > offsetMax){
        offsetx = offsetMax;
    }
    
    CGPoint offset = CGPointMake(offsetx, _sScrollView.contentOffset.y);
    [_sScrollView setContentOffset:offset animated:YES];
    // 添加控制器
    KNLiveTableViewController *newsVc = controllerArray[index];
  
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
