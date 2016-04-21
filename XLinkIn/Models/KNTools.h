//
//  KNTools.h
//  XLinkIn
//
//  Created by Kevin Yin on 4/6/16.
//  Copyright © 2016 Kevin Yin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNTools : NSObject

/**
 *  json数据转换为Dictionary
 *
 *  @param data NSData数据
 *
 *  @return 返回字典类型
 */
+(NSDictionary *)jsonDataToDictionary:(NSData *)data;

@end
