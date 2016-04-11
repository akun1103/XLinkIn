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
#import "KNVideoViewController.h"
#import "KNDocumentViewController.h"
#import <Photos/Photos.h>
#import "KNMusicModel.h"
#import "KNPhotoModel.h"
#import "KNVideoModel.h"

@interface KNLocalViewController ()
{
    NSMutableArray *_musicList;
    NSMutableArray *_photoList;
    NSMutableArray *_videoList;
    UILabel *musicL;
    UILabel *photoL;
    UILabel *videoL;
    UILabel *documentL;
    
    NSUInteger documentCount;
}
@end

@implementation KNLocalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"本地";
    self.navigationItem.leftBarButtonItem = nil;
    
    [self setUI];
    [self getAllPhotoAndVideo];
    [self getAllMusic];
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
    
    photoL = [[UILabel alloc] init];
    photoL.text = @"照片";
    photoL.font = [UIFont systemFontOfSize:14];
    photoL.textAlignment = NSTextAlignmentCenter;
    [v addSubview:photoL];
    
    UIButton *musicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [musicBtn setImage:[UIImage imageNamed:@"btn_music"] forState:UIControlStateNormal];
    [musicBtn addTarget:self action:@selector(gotoMusic) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:musicBtn];
    
    musicL = [[UILabel alloc] init];
    musicL.text = @"音乐";
    musicL.font = [UIFont systemFontOfSize:14];
    musicL.textAlignment = NSTextAlignmentCenter;
    [v addSubview:musicL];
    
    UIButton *movieBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [movieBtn setImage:[UIImage imageNamed:@"btn_movie"] forState:UIControlStateNormal];
    [movieBtn addTarget:self action:@selector(gotoMovie) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:movieBtn];
    
    videoL = [[UILabel alloc] init];
    videoL.text = @"视频";
    videoL.font = [UIFont systemFontOfSize:14];
    videoL.textAlignment = NSTextAlignmentCenter;
    [v addSubview:videoL];
    
    UIButton *documentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [documentBtn setImage:[UIImage imageNamed:@"btn_app"] forState:UIControlStateNormal];
    [documentBtn addTarget:self action:@selector(gotoDocument) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:documentBtn];
    
    documentL = [[UILabel alloc] init];
    documentL.text = @"文档";
    documentL.font = [UIFont systemFontOfSize:14];
    documentL.textAlignment = NSTextAlignmentCenter;
    [v addSubview:documentL];
    
    __weak typeof(self) weakSelf = self;
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(230);
        make.height.mas_equalTo(250);
        make.centerX.mas_equalTo(weakSelf.view.mas_centerX);
        make.centerY.mas_equalTo(weakSelf.view.mas_centerY);
    }];
    
    [photoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@[@80,photoL,musicBtn,musicL,movieBtn,movieBtn,videoL,documentBtn,documentL]);
        make.height.mas_equalTo(@[@80,musicBtn,movieBtn,documentBtn]);
        make.top.equalTo(@[v.mas_top,musicBtn.mas_top]);
        make.left.equalTo(@[v.mas_left,photoL.mas_left,movieBtn.mas_left,videoL.mas_left]);
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
    
    [videoL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(movieBtn.mas_bottom).with.offset(10);
    }];
    
    [documentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(movieBtn.mas_top);
    }];
    [documentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(documentBtn.mas_bottom).with.offset(10);
    }];
}

- (void)getAllPhotoAndVideo
{
    if (self.assetsLibrary == nil)
    {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    _photoList = [NSMutableArray array];
    _videoList = [NSMutableArray array];
    
    ALAssetsGroupEnumerationResultsBlock resultsBlock = ^(ALAsset *asset, NSUInteger index ,BOOL *stop){
        if (asset)
        {
            NSString *type = [asset valueForProperty:ALAssetPropertyType];
            NSURL *url = [asset valueForProperty:ALAssetPropertyAssetURL];
            UIImage *thumbnail = [UIImage imageWithCGImage:asset.aspectRatioThumbnail];
            NSString *fileName = asset.defaultRepresentation.filename;
            //            NSTimeInterval duration = [asset valueForProperty:ALAssetPropertyDuration];
            if ([type isEqualToString:ALAssetTypePhoto])
            {
                KNPhotoModel *photo = [[KNPhotoModel alloc] init];
                photo.url = url;
                photo.thumbnail = thumbnail;
                photo.fileName = fileName;
                [_photoList addObject:photo];
            }
            else if([type isEqualToString:ALAssetTypeVideo])
            {
                NSNumber *duration = [asset valueForProperty:ALAssetPropertyDuration];
                int time = round([duration doubleValue]);
                int minutes = time/60;
                int seconds = time%60;
                NSString *videoTime = [NSString stringWithFormat:@"%d:%02d",minutes,seconds];
                KNVideoModel *video = [[KNVideoModel alloc] init];
                video.url = url;
                video.duration = videoTime;
                video.thumbnail = thumbnail;
                video.fileName = fileName;
                [_videoList addObject:video];
            }
        }
    };
    
    ALAssetsLibraryGroupsEnumerationResultsBlock groupBlock = ^(ALAssetsGroup *group, BOOL *stop)
    {
        ALAssetsFilter *videoFilter = [ALAssetsFilter allAssets];
        [group setAssetsFilter:videoFilter];
        if(group)
        {
            [group enumerateAssetsUsingBlock:resultsBlock];
        }
        else
        {
            NSLog(@"photo %lu,video %lu",(unsigned long)_photoList.count,(unsigned long)_videoList.count);
            photoL.text = [NSString stringWithFormat:@"照片(%lu)",(unsigned long)_photoList.count];
            videoL.text = [NSString stringWithFormat:@"视频(%lu)",(unsigned long)_videoList.count];
        }
        
    };
    
    NSUInteger groupTypes = ALAssetsGroupAlbum | ALAssetsGroupEvent | ALAssetsGroupSavedPhotos;
    [_assetsLibrary enumerateGroupsWithTypes:groupTypes usingBlock:groupBlock failureBlock:nil];
}

//- (void)getAllPhoto
//{
//    //获取所有资源的集合，并按资源的创建时间排序
//    PHFetchOptions *options = [[PHFetchOptions alloc] init];
//    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
//    PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
//    // 这时 assetsFetchResults 中包含的，应该就是各个资源（PHAsset）
//    for (PHAsset *asset in assetsFetchResults) {
//        // 获取一个资源（PHAsset）
//        PHAssetMediaType type = asset.mediaType;
//        NSURL *url = asset.defaultRepresentation.url;
//        NSString *fileName = asset.defaultRepresentation.filename;
//        if(type == PHAssetMediaTypeImage)
//        {
//            KNPhotoModel *photo = [[KNPhotoModel alloc] init];
//            photo.url = url;
//            photo.thumbnail = thumbnail;
//            photo.fileName = fileName;
//            [_photoList addObject:photo];
//        }
//        else if(type == PHAssetMediaTypeVideo)
//        {
//            
//        }
//    }
//}

- (void)getAllMusic
{
    _musicList = [NSMutableArray array];
    MPMediaQuery *mediaQuery = [[MPMediaQuery alloc] init];
    MPMediaPropertyPredicate *albumPredicate = [MPMediaPropertyPredicate predicateWithValue:[NSNumber numberWithInt:MPMediaTypeMusic] forProperty:MPMediaItemPropertyMediaType];
    [mediaQuery addFilterPredicate:albumPredicate];
    NSArray *items = [mediaQuery items];
    musicL.text = [NSString stringWithFormat:@"音乐(%lu)",(unsigned long)items.count];
    for(MPMediaItem *item in items)
    {
        @autoreleasepool {
            KNMusicModel *music = [KNMusicModel alloc];
            //获得专辑对象
            MPMediaItemArtwork *artWork = item.artwork;//[item valueForProperty:MPMediaItemPropertyArtwork];
            UIImage *img = [artWork imageWithSize:CGSizeMake(100, 100)];
            if (!img)
            {
                img = [UIImage imageNamed:@"defaultImage"];
            }
            
            //歌曲url
            NSURL *url = item.assetURL;//[item valueForProperty:MPMediaItemPropertyAssetURL];

            //时间label转换格式MM：SS
            NSNumber *duration = [item valueForProperty:MPMediaItemPropertyPlaybackDuration];
//            int time = [duration intValue];
//            int minutes = time/60;
//            int seconds = time%60;
//            NSString *songtime = [NSString stringWithFormat:@"%d:%02d",minutes,seconds];
            
            //歌曲名字
            NSString *title = item.title;//[item valueForProperty:MPMediaItemPropertyTitle];
            
            
            //歌手名字
            NSString *singerName = item.artist;//[item valueForProperty:MPMediaItemPropertyArtist];
            if (singerName == nil)
            {
                singerName = @"unknow";
            }
            music.thumbnail = img;
            music.url = url;
            music.duration = duration;
            music.title = title;
            music.artist = singerName;
            [_musicList addObject:music];
        }
    }
}

- (void)gotoPhoto
{
    KNPhotoViewController *controller = [[KNPhotoViewController alloc] init];
    controller.photoList = _photoList;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

- (void)gotoMusic
{
    KNMusicViewController *controller = [[KNMusicViewController alloc] init];
    controller.musicList = _musicList;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}

- (void)gotoMovie
{
    KNVideoViewController *controller = [[KNVideoViewController alloc] init];
    controller.videoList = _videoList;
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
