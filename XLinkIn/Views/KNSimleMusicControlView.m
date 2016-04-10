//
//  KNSimleMusicControlView.m
//  XLinkIn
//
//  Created by Kevin Yin on 4/9/16.
//  Copyright © 2016 Kevin Yin. All rights reserved.
//

#import "KNSimleMusicControlView.h"
#import "KNMusicPlayer.h"
#import "KNMusicModel.h"
#import <MediaPlayer/MPVolumeView.h>

@implementation KNSimleMusicControlView

{
    KNMusicPlayer *player;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
        
        UIView *topLine = [[UIView alloc] init];
        topLine.frame = CGRectMake(0, 0, self.frameWidth, 0.8);
        topLine.backgroundColor = DEFAULT_LINE_GRAY_COLOR;
        [self addSubview:topLine];
        
        _progressView = [[UIView alloc] init];
        _progressView.frame = CGRectMake(0, 0, 0, 0.8);
        _progressView.backgroundColor = DEFAULT_TABBAR_COLOR;
        [self addSubview:_progressView];
        
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(self.frameHeight * 0.2, self.frameHeight * 0.1, self.frameHeight * 0.8, self.frameHeight * 0.8);
        _imageView.layer.cornerRadius = _imageView.frameHeight/2;
        _imageView.layer.masksToBounds = YES;
        [self addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.frame = CGRectMake(self.frameHeight * 1.2, self.frameHeight * 0.2, self.frameWidth - self.frameHeight * 2.2, self.frameHeight * 0.3);
        _titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_titleLabel];
        
        _artistLabel = [[UILabel alloc] init];
        _artistLabel.frame = CGRectMake(self.frameHeight * 1.2, self.frameHeight * 0.6, self.frameWidth - self.frameHeight * 2.2, self.frameHeight * 0.3);
        _artistLabel.font = [UIFont systemFontOfSize:11];
        _artistLabel.textColor = DEFAULT_TEXT_GRAY_COLOR;
        [self addSubview:_artistLabel];
        
        _playOrPauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playOrPauseBtn setImage:[UIImage imageNamed:@"playing_btn_pause_h"] forState:UIControlStateNormal];
        [_playOrPauseBtn addTarget:self action:@selector(playOrPauseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        _playOrPauseBtn.frame = CGRectMake(self.frameWidth - self.frameHeight * 0.9, self.frameHeight * 0.2, self.frameHeight * 0.6, self.frameHeight * 0.6);
        [self addSubview:_playOrPauseBtn];
        
        [self addAnimationForLayer:_imageView.layer];
         player = [KNMusicPlayer shareInstance];
        [player addObserver:self forKeyPath:@"currentIndex" options:NSKeyValueObservingOptionNew context:nil];
        [player addObserver:self forKeyPath:@"progress" options:NSKeyValueObservingOptionNew context:nil];
        
        //添加AirPlayer
//        MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame:CGRectMake(self.frameWidth - self.frameHeight * 1.3, self.frameHeight * 0.2, self.frameHeight * 0.6, self.frameHeight * 0.6)];
//        [volumeView setShowsVolumeSlider:NO];
//        [volumeView setShowsRouteButton:YES];
//        [volumeView sizeToFit];
//        [self addSubview:volumeView];
    }
    return self;
}

- (void)addAnimationForLayer:(CALayer *)layer
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.removedOnCompletion = NO; // 当duration值已经达到时，是否将动画自动从渲染树上移除（app进入后台后，重新进入前台动画继续）
    rotationAnimation.duration = 6;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 3.40282347E+38;
    [layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)playOrPauseBtnClicked:(id)sender
{
    if([player isPlaying])
    {
        [player pause];
        [_playOrPauseBtn setImage:[UIImage imageNamed:@"playing_btn_play_h"] forState:UIControlStateNormal];
        [self pauseLayer:_imageView.layer];
    }
    else
    {
        [player play];
        [_playOrPauseBtn setImage:[UIImage imageNamed:@"playing_btn_pause_h"] forState:UIControlStateNormal];
        [self resumeLayer:_imageView.layer];
    }
}

//暂停layer上面的动画
- (void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

//继续layer上面的动画
- (void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

#pragma mark - Observe Delegate
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if([keyPath isEqualToString:@"currentIndex"])
    {
        KNMusicModel *model = [player.musicList objectAtIndex:player.currentIndex];
        _titleLabel.text = model.title;
        _imageView.image = model.thumbnail;
        _artistLabel.text = model.artist;
        [_playOrPauseBtn setImage:[UIImage imageNamed:@"playing_btn_pause_h"] forState:UIControlStateNormal];
        [self pauseLayer:_imageView.layer];
        [self resumeLayer:_imageView.layer];
    }
    else if([keyPath isEqualToString:@"progress"])
    {
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:1.0 animations:^{
            weakSelf.progressView.frameWidth = weakSelf.frameWidth * player.progress;
        }];
    }
}
#pragma mark 重写销毁方法
-(void)dealloc{
    [player removeObserver:self forKeyPath:@"currentIndex"];//移除监听
    [player removeObserver:self forKeyPath:@"progress"];//移除监听
    //[super dealloc];//注意启用了ARC，此处不需要调用
}

@end
