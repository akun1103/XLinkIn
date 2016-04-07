//
//  KNRootTabBarViewController.m
//  XLinkIn
//
//  Created by Kevin Yin on 16/4/3.
//  Copyright © 2016年 Kevin Yin. All rights reserved.
//

#import "KNRootTabBarViewController.h"
#import "KNLocalViewController.h"
#import "KNLiveViewController.h"
#import "KNOnlineViewController.h"
#import "KNNavigationController.h"

@interface KNRootTabBarViewController ()

@end

@implementation KNRootTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tabBar setTintColor:DEFAULT_NAVBAR_COLOR];
    [self initChildViewControllers];
}

- (void)initChildViewControllers
{
    NSMutableArray *childViewControllers = [[NSMutableArray alloc] initWithCapacity:3];
    
    KNLocalViewController *local = [[KNLocalViewController alloc] init];
    [local.tabBarItem setTitle:@"本地"];
    [local.tabBarItem setImage:[UIImage imageNamed:@"local"]];
//    [local.tabBarItem setSelectedImage:[UIImage imageNamed:@"local_h"]];
    KNNavigationController *localNav = [[KNNavigationController alloc] initWithRootViewController:local];
    
    KNOnlineViewController *online = [[KNOnlineViewController alloc] init];
    [online.tabBarItem setTitle:@"点播"];
    [online.tabBarItem setImage:[UIImage imageNamed:@"online"]];
//    [online.tabBarItem setSelectedImage:[UIImage imageNamed:@"online_h"]];
    KNNavigationController *onlineNav = [[KNNavigationController alloc] initWithRootViewController:online];
    
    KNLiveViewController *live = [[KNLiveViewController alloc] init];
    [live.tabBarItem setTitle:@"直播"];
    [live.tabBarItem setImage:[UIImage imageNamed:@"live"]];
//    [live.tabBarItem setSelectedImage:[UIImage imageNamed:@"live_h"]];
    KNNavigationController *liveNav = [[KNNavigationController alloc] initWithRootViewController:live];
    
    [childViewControllers addObjectsFromArray:@[localNav,onlineNav,liveNav]];
    [self setViewControllers:childViewControllers];
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

@end
