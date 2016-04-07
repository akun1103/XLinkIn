//
//  KNNetworkTool.h
//  XLinkIn
//
//  Created by emper on 16/4/7.
//  Copyright © 2016年 Kevin Yin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNNetworkTool : NSObject

- (void)getResultWithParameter:(NSDictionary *)parameter url:(NSString *)url success:(SuccessBlock)successBlock failure:(ErrorBlock)errorBlock;
@end
