//
//  KNMusicViewController.h
//  XLinkIn
//
//  Created by Kevin Yin on 4/5/16.
//  Copyright © 2016 Kevin Yin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "KNSimleMusicControlView.h"

@interface KNMusicViewController : KNViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *musicList;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) KNSimleMusicControlView *controlView;
@end
