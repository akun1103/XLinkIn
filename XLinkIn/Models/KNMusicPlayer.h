//
//  KNMusicPlayer.h
//  XLinkIn
//
//  Created by Kevin Yin on 4/9/16.
//  Copyright © 2016 Kevin Yin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface KNMusicPlayer : NSObject<AVAudioPlayerDelegate>

@property (nonatomic,strong) AVAudioPlayer *player;
@property (nonatomic,strong) NSArray *musicList;
@property (nonatomic) NSUInteger currentIndex;
@property (nonatomic) NSTimeInterval currentTime;
@property(readonly) NSTimeInterval duration;
@property(readonly, getter=isPlaying) BOOL playing;
@property(nonatomic) NSUInteger playState;
@property(nonatomic,assign) float volume;
@property(nonatomic,assign) float progress;
+ (instancetype)shareInstance;

- (void)initWithContentsOfURL:(NSURL *)url error:(NSError * _Nullable __autoreleasing * _Nullable)outError;
- (void)startPlay;
- (void)previous;
- (void)next;
- (void)play;
- (void)pause;
- (void)stop;

@end
