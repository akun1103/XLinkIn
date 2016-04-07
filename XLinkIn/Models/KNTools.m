//
//  KNTools.m
//  XLinkIn
//
//  Created by Kevin Yin on 4/6/16.
//  Copyright © 2016 Kevin Yin. All rights reserved.
//

#import "KNTools.h"

@implementation KNTools

+(NSDictionary *)jsonToDictionary:(id)response
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
    return dic;
}
@end
