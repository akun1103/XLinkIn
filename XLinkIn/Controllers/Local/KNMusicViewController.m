//
//  KNMusicViewController.m
//  XLinkIn
//
//  Created by Kevin Yin on 4/5/16.
//  Copyright © 2016 Kevin Yin. All rights reserved.
//

#import "KNMusicViewController.h"
#import "KNMusicModel.h"
#import "KNMusicTableViewCell.h"
#import "KNMusicPlayer.h"
#import "KNSimleMusicControlView.h"

#define NULLPlayCount 102400
#define ControlViewHeight 50

@interface KNMusicViewController ()
{
    KNMusicPlayer *player;
    int currentPlayCount;
    BOOL showControl;
}
@end

@implementation KNMusicViewController

static NSString * const reuseIdentifier = @"Cell";

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [player stop];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"音乐";
//   UIBarButtonItem *controlItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_control_h"] style:UIBarButtonItemStylePlain target:self action:@selector(controlBtnClicked)];
//    self.navigationItem.rightBarButtonItem = controlItem;
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    __weak typeof(self) weakSelf = self;
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(weakSelf.view);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    [self.tableView setSeparatorStyle: UITableViewCellSeparatorStyleNone];
    [self.tableView registerClass:[KNMusicTableViewCell class] forCellReuseIdentifier:reuseIdentifier];

    _controlView = [[KNSimleMusicControlView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, ControlViewHeight)];
    [self.view addSubview:_controlView];
    [_controlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(weakSelf.view.frameWidth, ControlViewHeight));
        make.left.mas_equalTo(0);
        make.bottom.mas_equalTo(ControlViewHeight);
    }];
    
    currentPlayCount = NULLPlayCount;
    player = [KNMusicPlayer shareInstance];
    [player addObserver:self forKeyPath:@"currentIndex" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)controlBtnClicked
{
    if(showControl)
    {
        [self hideControl];
    }
    else
    {
        [self showControl];
    }
    showControl = !showControl;
}

- (void)hideControl
{
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:1.0 animations:^{
        [weakSelf.controlView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(ControlViewHeight);
        }];
    } completion:^(BOOL finished) {
        [weakSelf.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
        }];
    }];
}

- (void)showControl
{
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:1.0 animations:^{
        [weakSelf.controlView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
        }];
    } completion:^(BOOL finished) {
        [weakSelf.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-ControlViewHeight);

        }];
//            weakSelf.tableView.frameHeight = weakSelf.view.frameHeight - ControlViewHeight;
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _musicList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    KNMusicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    KNMusicModel *music = [_musicList objectAtIndex:indexPath.row];
    cell.thumbnailImageView.image = music.thumbnail;
    cell.titile.text = music.title;
    cell.artist.text = music.artist;
    cell.topLineStyle = CellLineStyleNone;
    cell.bottomLineStyle = CellLineStyleSpace;
    if(currentPlayCount == indexPath.row)
    {
        cell.leftView.hidden = NO;
    }
    else
    {
        cell.leftView.hidden = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(!showControl)
    {
        [self showControl];
        showControl = YES;
    }
    
    player.musicList = _musicList;
    player.currentIndex = indexPath.row;
    [player startPlay];


}

#pragma mark - 覆盖方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([keyPath isEqualToString:@"currentIndex"])
    {
        currentPlayCount = (int)player.currentIndex;
        [self.tableView reloadData];
    }
}
#pragma mark 重写销毁方法
-(void)dealloc{
    [player removeObserver:self forKeyPath:@"currentIndex"];//移除监听
}

@end
