//
//  KNMusicPlayer.m
//  XLinkIn
//
//  Created by Kevin Yin on 4/9/16.
//  Copyright © 2016 Kevin Yin. All rights reserved.
//

#import "KNMusicPlayer.h"

static KNMusicPlayer *sharePlayerInstance = nil;

@implementation KNMusicPlayer
{
    NSTimer *timer;
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
        
    }else{
        
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
}

- (void)pause
{
    if(timer)
    {
        [timer invalidate];
        timer = nil;
    }
    [_player pause];
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
}

- (void)next
{
    if(self.currentIndex == _musicList.count)
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
        self.currentIndex = _musicList.count;
    }
    else
    {
        self.currentIndex--;
    }
    [self startPlay];
}

- (void)startPlay
{
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
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"finish %i",flag);
    [self next];
}

/* if an error occurs while decoding it will be reported to the delegate. */
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error
{
    NSLog(@"error %@",error);
}

@end
