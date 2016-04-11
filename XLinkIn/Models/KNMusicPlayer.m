//
//  KNMusicPlayer.m
//  XLinkIn
//
//  Created by Kevin Yin on 4/9/16.
//  Copyright © 2016 Kevin Yin. All rights reserved.
//

#import "KNMusicPlayer.h"
#import "KNMusicModel.h"
#import <MediaPlayer/MediaPlayer.h>

static KNMusicPlayer *sharePlayerInstance = nil;

@implementation KNMusicPlayer
{
    NSTimer *timer;
}

+ (void)initialize
{
    // 音频会话
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    // 设置会话类型（播放类型、播放模式,会自动停止其他音乐的播放）
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    // 激活会话
    [session setActive:YES error:nil];
//    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
}

+ (instancetype)shareInstance
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharePlayerInstance = [[self alloc] init];
    });
    return sharePlayerInstance;
}

- (void)initWithContentsOfURL:(NSURL *)url error:(NSError * _Nullable __autoreleasing * _Nullable)outError
{
    if(_player)
    {
        _player = nil;
    }
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:outError];
    
    //设置当前的时间
    _player.currentTime = 0;
    
    //设置代理
    _player.delegate = self;
    
    //
    BOOL isPlay = [_player prepareToPlay];
    
    if (isPlay) {
        
        [_player play];
        self.playState = 1;
        
    }else{
        self.playState = 0;
        NSLog(@"播放失败");
    }
}

- (void)setVolume:(float)volume
{
    _player.volume = volume;
}

- (NSTimeInterval)duration
{
    return _player.duration;
}

- (NSTimeInterval)currentTime
{
    return _player.currentTime;
}

- (BOOL)isPlaying
{
    return _player.isPlaying;
}

- (void)stop
{
    if(timer)
    {
        [timer invalidate];
        timer = nil;
    }
    [_player stop];
    self.playState = 0;
}

- (void)pause
{
    if(timer)
    {
        [timer invalidate];
        timer = nil;
    }
    [_player pause];
    self.playState = 0;
}

- (void)play
{
    if(timer)
    {
        [timer invalidate];
        timer = nil;
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    [_player play];
    self.playState = 0;
}

- (void)next
{
    if(self.currentIndex == _musicList.count - 1)
    {
        self.currentIndex = 0;
    }
    else
    {
        self.currentIndex++;
    }
     [self startPlay];
}

- (void)previous
{
    if(self.currentIndex == 0)
    {
        self.currentIndex = _musicList.count - 1;
    }
    else
    {
        self.currentIndex--;
    }
    [self startPlay];
}

- (void)startPlay
{
    [self stop];
    if(timer)
    {
        [timer invalidate];
        timer = nil;
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    [self initWithContentsOfURL:[_musicList[_currentIndex] url] error:nil];
}

- (void)updateProgress
{
    self.progress = self.currentTime/self.duration;
    [self configNowPlayingInfoCenter];
}

- (void)configNowPlayingInfoCenter {
    
    KNMusicModel *music = [_musicList objectAtIndex:_currentIndex];
    
    if (NSClassFromString(@"MPNowPlayingInfoCenter") && music) {
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        
        [dict setObject: music.title forKey:MPMediaItemPropertyTitle];
        
        [dict setObject: music.artist forKey:MPMediaItemPropertyArtist];
        
        [dict setObject: music.duration forKey:MPMediaItemPropertyPlaybackDuration];
        
        [dict setObject:[NSNumber numberWithDouble:self.currentTime] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime]; //音乐当前已经过时间
        MPMediaItemArtwork * mArt = [[MPMediaItemArtwork alloc] initWithImage:music.thumbnail];

        [dict setObject:mArt forKey:MPMediaItemPropertyArtwork];
        
        //        [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = nil;
        
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
    }
    
}

#pragma mark -AvaudioPlayer Delegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self next];
}

/* if an error occurs while decoding it will be reported to the delegate. */
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error
{
    NSLog(@"error %@",error);
}

#pragma mark - 处理播放音频时的中断
-(void)audioPlayerBeginInterruption:(AVAudioPlayer *)player{
    /*audio session is interrupted.The player will be paused here */
    [player pause];
}

-(void)audioPlayerEndInterruption:(AVAudioPlayer *)player withFlags:(NSUInteger)flags{
    [player play];
}
@end
