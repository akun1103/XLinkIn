//
//  KNNavigationController.m
//  XLinkIn
//
//  Created by Kevin Yin on 16/4/3.
//  Copyright © 2016年 Kevin Yin. All rights reserved.
//

#import "KNNavigationController.h"

@interface KNNavigationController ()

@end

@implementation KNNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.navigationBar setTintColor:[UIColor whiteColor]];
//    [self.navigationBar setBarTintColor:[UIColor redColor]];
    self.navigationBar.translucent = NO;
    [self.navigationBar setTintColor:DEFAULT_TABBAR_COLOR];
//    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:DEFAULT_TABBAR_COLOR}];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    [super pushViewController:viewController animated:YES];
    
    [self addbackBtn:viewController];
    
}

-(void)addbackBtn:(UIViewController *)viewController{
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_back_white"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClick)];
    
    
    viewController.navigationItem.leftBarButtonItems = @[back];
    
    
    
}

-(void)backBtnClick{
    
    [self popViewControllerAnimated:YES];
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
