//
//  KNVideoModel.h
//  XLinkIn
//
//  Created by emper on 16/4/11.
//  Copyright © 2016年 Kevin Yin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNVideoModel : NSObject
/**
 *  视频封面
 */
@property (nonatomic,strong) UIImage *thumbnail;
/**
 *  视频名称
 */
@property (nonatomic,strong) NSString *fileName;
/**
 *  视频URL
 */
@property (nonatomic,strong) NSURL *url;
/**
 *  视频时长
 */
@property (nonatomic,strong) NSString *duration;

@end
