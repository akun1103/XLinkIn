//
//  KNDateModel.h
//  XLinkIn
//
//  Created by emper on 16/4/20.
//  Copyright © 2016年 Kevin Yin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KNDateModel : NSObject

+ (NSString*)getChineseCalendarWithDate:(NSDate *)date;
+ (NSString *)getCurrentWeekday;
+ (NSInteger)getCurrentYear;
+ (NSInteger)getCurrentMonth;
+ (NSInteger)getCurrentDay;
+ (NSInteger)getCurrentHour;

@end
