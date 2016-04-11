//
//  KNVideoModel.h
//  XLinkIn
//
//  Created by emper on 16/4/11.
//  Copyright © 2016年 Kevin Yin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNVideoModel : NSObject

@property (nonatomic,strong) UIImage *thumbnail;
@property (nonatomic,strong) NSString *fileName;
@property (nonatomic,strong) NSURL *url;
@property (nonatomic,strong) NSString *duration;
@end
