//
//  KNLocalViewController.m
//  XLinkIn
//
//  Created by Kevin Yin on 16/4/3.
//  Copyright © 2016年 Kevin Yin. All rights reserved.
//

#import "KNLocalViewController.h"
#import "KNPhotoViewController.h"
#import "KNMusicViewController.h"
#import "KNMovieViewController.h"
#import "KNDocumentViewController.h"
#import <Photos/Photos.h>

@interface KNLocalViewController ()

@end

@implementation KNLocalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"本地";
    self.navigationItem.leftBarButtonItem = nil;
    
    [self setUI];
    [self getPhotoGroup];
}

- (void)getPhotoGroup
{

}

- (void)setUI
{
    UIView *v = [[UIView alloc] init];
    //    v.backgroundColor = [UIColor redColor];
    [self.view addSubview:v];
    
    UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [photoBtn setImage:[UIImage imageNamed:@"btn_photo"] forState:UIControlStateNormal];
    [photoBtn addTarget:self action:@selector(gotoPhoto) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:photoBtn];
    
    UILabel *photoL = [[UILabel alloc] init];
    photoL.text = @"照片";
    photoL.font = [UIFont systemFontOfSize:14];
    photoL.textAlignment = NSTextAlignmentCenter;
    [v addSubview:photoL];
    
    UIButton *musicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [musicBtn setImage:[UIImage imageNamed:@"btn_music"] forState:UIControlStateNormal];
    [musicBtn addTarget:self action:@selector(gotoMusic) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:musicBtn];
    
    UILabel *musicL = [[UILabel alloc] init];
    musicL.text = @"音乐";
    musicL.font = [UIFont systemFontOfSize:14];
    musicL.textAlignment = NSTextAlignmentCenter;
    [v addSubview:musicL];
    
    UIButton *movieBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [movieBtn setImage:[UIImage imageNamed:@"btn_movie"] forState:UIControlStateNormal];
    [movieBtn addTarget:self action:@selector(gotoMovie) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:movieBtn];
    
    UILabel *movieL = [[UILabel alloc] init];
    movieL.text = @"视频";
    movieL.font = [UIFont systemFontOfSize:14];
    movieL.textAlignment = NSTextAlignmentCenter;
    [v addSubview:movieL];
    
    UIButton *documentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [documentBtn setImage:[UIImage imageNamed:@"btn_app"] forState:UIControlStateNormal];
    [documentBtn addTarget:self action:@selector(gotoDocument) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:documentBtn];
    
    UILabel *documentL = [[UILabel alloc] init];
    documentL.text = @"文档";
    documentL.font = [UIFont systemFontOfSize:14];
    documentL.textAlignment = NSTextAlignmentCenter;
    [v addSubview:documentL];
    
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(230);
        make.height.mas_equalTo(250);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
    }];
    
    [photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@[@80,photoL,musicBtn,musicL,movieBtn,movieBtn,movieL,documentBtn,documentL]);
        make.height.mas_equalTo(@[@80,musicBtn,movieBtn,documentBtn]);
        make.top.equalTo(@[v.mas_top,musicBtn.mas_top]);
        make.left.equalTo(@[v.mas_left,photoL.mas_left,movieBtn.mas_left,movieL.mas_left]);
    }];
    
    [photoL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(photoBtn.mas_centerX);
        make.top.equalTo(photoBtn.mas_bottom).with.offset(10);
    }];
    
    [musicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(v.mas_top);
        make.right.equalTo(@[v.mas_right,musicL.mas_right,documentBtn.mas_right,documentL.mas_right]);
    }];
    
    [musicL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(musicBtn.mas_bottom).with.offset(10);
    }];
    
    [movieBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(photoBtn.mas_bottom).with.offset(60);
    }];
    
    [movieL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(movieBtn.mas_bottom).with.offset(10);
    }];
    
    [documentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(movieBtn.mas_top);
    }];
    [documentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(documentBtn.mas_bottom).with.offset(10);
    }];
}

- (void)gotoPhoto
{
    KNPhotoViewController *controller = [[KNPhotoViewController alloc] init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

- (void)gotoMusic
{
    KNMusicViewController *controller = [[KNMusicViewController alloc] init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

- (void)gotoMovie
{
    KNMovieViewController *controller = [[KNMovieViewController alloc] init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

- (void)gotoDocument
{
    KNDocumentViewController *controller = [[KNDocumentViewController alloc] init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
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
