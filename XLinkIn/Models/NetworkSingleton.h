//
//  NetworkSingleton.h
//  WeChat
//
//  Created by emper on 15/12/17.
//  Copyright © 2015年 Kevin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#define TIMEOUT 30

typedef void (^SuccessBlock)(id responseObject);
typedef void (^ErrorBlock)(NSError *error);
typedef void(^NetworkStatus)(AFNetworkReachabilityStatus status);
@interface NetworkSingleton : NSObject

+ (NetworkSingleton *)sharedManager;
- (AFHTTPSessionManager *)baseHttpManager;

#pragma mark AFNetworking --GET
/**
 *  AFNetworking 网络请求-get方法
 *
 *  @param parameter    get参数
 *  @param url          url
 *  @param successBlock 请求成功
 *  @param errorBlock   请求失败
 */
- (void)getResultWithParameter:(NSDictionary *)parameter url:(NSString *)url success:(SuccessBlock)successBlock failure:(ErrorBlock)errorBlock;
#pragma mark AFNetworking --POST
- (void)postResultWithParameter:(NSDictionary *)parameter url:(NSString *)url success:(SuccessBlock)successBlock failure:(ErrorBlock)errorBlock;
#pragma mark AFNetworking --UPLOAD image
- (void)uploadImageWithParameter:(NSDictionary *)parameter url:(NSString *)url imageArray:(NSArray *)imageArray success:(SuccessBlock)successBlock failure:(ErrorBlock)errorBlock;
#pragma mark AFNetworking --监控网络状态
- (void)MonitorReachabilityStatusChangeBlock:(NetworkStatus)networkStatus;
- (BOOL)networkReachable;
@end
