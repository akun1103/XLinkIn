//
//  KNMusicModel.h
//  XLinkIn
//
//  Created by Kevin Yin on 4/8/16.
//  Copyright © 2016 Kevin Yin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNMusicModel : NSObject

@property (nonatomic,strong) UIImage *thumbnail;
@property (nonatomic,strong) NSNumber *duration;
@property (nonatomic,strong) NSURL *url;
@property (nonatomic,strong) NSString *artist;
@property (nonatomic,strong) NSString *title;
@end
