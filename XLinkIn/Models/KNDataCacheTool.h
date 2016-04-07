//
//  KNDataCacheTool.h
//  XLinkIn
//
//  Created by Kevin Yin on 4/7/16.
//  Copyright © 2016 Kevin Yin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@interface KNDataCacheTool : NSObject

+(void)addArr:(NSArray*)arr andId:(NSString*)idstr;
+(void)addDict:(NSDictionary*)dict andId:(NSString*)idstr;

+(NSArray*)dataWithID:(NSString*)ID;
+(void)deleteWidthId:(NSString*)ID;

@end
