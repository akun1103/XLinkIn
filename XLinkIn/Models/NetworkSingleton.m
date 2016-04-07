//
//  NetworkSingleton.m
//  WeChat
//
//  Created by emper on 15/12/17.
//  Copyright © 2015年 Kevin. All rights reserved.
//

#import "NetworkSingleton.h"

static NetworkSingleton *shareNetworkSingleton = nil;

@implementation NetworkSingleton

+ (NetworkSingleton *)sharedManager
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareNetworkSingleton = [[self alloc] init];
    });
    return shareNetworkSingleton;
}

- (AFHTTPSessionManager *)baseHttpManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setTimeoutInterval:TIMEOUT];
    //默认 responseObject是JSON
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//使用这个将得到的是NSData
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];//使用这个将得到的是JSON
    return manager;
}

- (void)getResultWithParameter:(NSDictionary *)parameter url:(NSString *)url success:(SuccessBlock)successBlock failure:(ErrorBlock)errorBlock
{
    AFHTTPSessionManager *manager = [self baseHttpManager];
    NSString *urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manager GET:urlStr parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

- (void)postResultWithParameter:(NSDictionary *)parameter url:(NSString *)url success:(SuccessBlock)successBlock failure:(ErrorBlock)errorBlock
{
    AFHTTPSessionManager *manager = [self baseHttpManager];
    NSString *urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manager POST:urlStr parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

- (void)uploadImageWithParameter:(NSDictionary *)parameter url:(NSString *)url imageArray:(NSArray *)imageArray success:(SuccessBlock)successBlock failure:(ErrorBlock)errorBlock
{
    AFHTTPSessionManager *manager = [self baseHttpManager];
    NSString *urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [manager POST:urlStr parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i = 1; i <= imageArray.count; i++)
        {
            NSData *imageData = UIImageJPEGRepresentation(imageArray[i-1], 1.0);
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"image%d",i] fileName:@"image" mimeType:@"image/jpg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock(error);
    }];
}

- (void)MonitorReachabilityStatusChangeBlock:(NetworkStatus)networkStatus
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        networkStatus(status);
    }];
    [manager startMonitoring];
}
@end
