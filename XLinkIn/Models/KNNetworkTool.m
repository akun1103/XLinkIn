//
//  KNNetworkTool.m
//  XLinkIn
//
//  Created by emper on 16/4/20.
//  Copyright © 2016年 Kevin Yin. All rights reserved.
//

#import "KNNetworkTool.h"

@implementation KNNetworkTool

static KNNetworkTool *_instance = nil;

+ (instancetype) shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _instance = [[KNNetworkTool alloc] init];
    });
    return _instance;
}

+ (instancetype)init {
    return [KNNetworkTool shareInstance];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [KNNetworkTool shareInstance];
}

- (instancetype)copyWithZone:(struct _NSZone *)zone {
    return [KNNetworkTool shareInstance];
}
@end
