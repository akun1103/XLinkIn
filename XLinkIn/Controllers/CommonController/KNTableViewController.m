//
//  KNTableViewController.m
//  XLinkIn
//
//  Created by emper on 16/4/7.
//  Copyright © 2016年 Kevin Yin. All rights reserved.
//

#import "KNTableViewController.h"

@interface KNTableViewController ()

@end

@implementation KNTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    // 设置CGRectZero从导航栏下开始计算
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}
@end
