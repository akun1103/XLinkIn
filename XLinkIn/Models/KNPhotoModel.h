//
//  KNPhotoModel.h
//  XLinkIn
//
//  Created by Kevin Yin on 4/10/16.
//  Copyright © 2016 Kevin Yin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNPhotoModel : NSObject

@property (nonatomic,strong) UIImage *thumbnail;
@property (nonatomic,strong) NSString *fileName;
@property (nonatomic,strong) NSURL *url;

@end
