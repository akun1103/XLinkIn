//
//  AppDelegate.m
//  XLinkIn
//
//  Created by Kevin Yin on 16/4/3.
//  Copyright © 2016年 Kevin Yin. All rights reserved.
//

#import "AppDelegate.h"
#import "KNRootTabBarViewController.h"
#import "KNMusicPlayer.h"
#import "KNMusicModel.h"
#import <MediaPlayer/MediaPlayer.h>

@interface AppDelegate ()
{
    KNMusicPlayer *player;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    KNRootTabBarViewController *rootViewController = [[KNRootTabBarViewController alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setRootViewController:rootViewController];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    player = [KNMusicPlayer shareInstance];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    [self becomeFirstResponder];
//    [self configNowPlayingInfoCenter];

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
//    
//    [self resignFirstResponder];
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    [self becomeFirstResponder];
//    [self configNowPlayingInfoCenter];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.

}

//remoteControl
-(void)remoteControlReceivedWithEvent:(UIEvent *)event{
    
    //if it is a remote control event handle it correctly
    
    if (event.type == UIEventTypeRemoteControl) {
        if (event.subtype == UIEventSubtypeRemoteControlPause)
        {
            [player pause];
        }
        else if(event.subtype == UIEventSubtypeRemoteControlPlay)
        {
            [player play];
        }
        else if (event.subtype == UIEventSubtypeRemoteControlNextTrack)
        {
            [player next];
//            [self configNowPlayingInfoCenter];
        } else if(event.subtype == UIEventSubtypeRemoteControlPreviousTrack)
        {
            [player previous];
//            [self configNowPlayingInfoCenter];//放到player timer中更新播放时间
        }
    }
    
}

//Make sure we can recieve remote control events
- (BOOL)canBecomeFirstResponder {
    
    return YES;
}

//- (void)configNowPlayingInfoCenter {
//    
//    KNMusicModel *music = [player.musicList objectAtIndex:player.currentIndex];
//    
//    if (NSClassFromString(@"MPNowPlayingInfoCenter") && music) {
//        
//        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
//        
//        [dict setObject: music.title forKey:MPMediaItemPropertyTitle];
//        
//        [dict setObject: music.artist forKey:MPMediaItemPropertyArtist];
//        
//        [dict setObject: music.duration forKey:MPMediaItemPropertyPlaybackDuration];
//
////        MPMediaItemArtwork * mArt = [[MPMediaItemArtwork alloc] initWithImage:music.thumbnail];
////        
////        [dict setObject:mArt forKey:MPMediaItemPropertyArtwork];
//        
////        [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = nil;
//        
//        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
//        
//    }
//    
//}

@end
