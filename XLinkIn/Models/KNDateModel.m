//
//  KNDateModel.m
//  XLinkIn
//
//  Created by emper on 16/4/20.
//  Copyright © 2016年 Kevin Yin. All rights reserved.
//

#import "KNDateModel.h"

@implementation KNDateModel

+ (NSString*)getChineseCalendarWithDate:(NSDate *)date {
    
    NSArray *chineseYears = [NSArray arrayWithObjects:
                             @"甲子",   @"乙丑",  @"丙寅",  @"丁卯",  @"戊辰",  @"己巳",  @"庚午",  @"辛未",  @"壬申",  @"癸酉",
                             @"甲戌",   @"乙亥",  @"丙子",  @"丁丑",  @"戊寅",  @"己卯",  @"庚辰",  @"辛己",  @"壬午",  @"癸未",
                             @"甲申",   @"乙酉",  @"丙戌",  @"丁亥",  @"戊子",  @"己丑",  @"庚寅",  @"辛卯",  @"壬辰",  @"癸巳",
                             @"甲午",   @"乙未",  @"丙申",  @"丁酉",  @"戊戌",  @"己亥",  @"庚子",  @"辛丑",  @"壬寅",  @"癸丑",
                             @"甲辰",   @"乙巳",  @"丙午",  @"丁未",  @"戊申",  @"己酉",  @"庚戌",  @"辛亥",  @"壬子",  @"癸丑",
                             @"甲寅",   @"乙卯",  @"丙辰",  @"丁巳",  @"戊午",  @"己未",  @"庚申",  @"辛酉",  @"壬戌",  @"癸亥", nil];
    
    NSArray *chineseMonths=[NSArray arrayWithObjects:
                            @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                            @"九月", @"十月", @"冬月", @"腊月", nil];
    
    
    NSArray *chineseDays=[NSArray arrayWithObjects:
                          @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                          @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                          @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:date];
    
    NSLog(@"%ld_%ld_%ld  %@",(long)localeComp.year,(long)localeComp.month,(long)localeComp.day, localeComp.date);
    
    NSString *y_str = [chineseYears objectAtIndex:localeComp.year-1];
    NSString *m_str = [chineseMonths objectAtIndex:localeComp.month-1];
    NSString *d_str = [chineseDays objectAtIndex:localeComp.day-1];
    
    NSLog(@"农历:%@ %@ %@",y_str,m_str,d_str);
    NSString *chineseCal_str =[NSString stringWithFormat: @"%@年%@%@",y_str,m_str,d_str];
    
    return chineseCal_str;
}

+ (NSString *)getCurrentWeekday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unitFlags = NSCalendarUnitWeekOfMonth|NSCalendarUnitWeekday;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:[NSDate dateWithTimeIntervalSinceNow:3600*24*7]];
    NSLog(@"[comps week]:%ld [comps weekday]:%ld",(long)[comps weekOfMonth],(long)[comps weekday]);
    NSString *weekday = nil;
    switch ([comps weekday]) {
        case 1:
            weekday = @"周日";
            break;
        case 2:
            weekday = @"周一";
            break;
        case 3:
            weekday = @"周二";
            break;
        case 4:
            weekday = @"周三";
            break;
        case 5:
            weekday = @"周四";
            break;
        case 6:
            weekday = @"周五";
            break;
        case 7:
            weekday = @"周六";
            break;
        default:
            break;
    }
    return weekday;
}

+ (NSInteger)getCurrentYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =  NSCalendarUnitYear;
    NSDateComponents *monthComponent = [calendar components:unitFlags fromDate:[NSDate new]];
    return [monthComponent year];
}

+ (NSInteger)getCurrentMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =  NSCalendarUnitMonth;
    NSDateComponents *monthComponent = [calendar components:unitFlags fromDate:[NSDate new]];
    return [monthComponent month];
}

+ (NSInteger)getCurrentDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags =  NSCalendarUnitDay;
    NSDateComponents *dayComponent = [calendar components:unitFlags fromDate:[NSDate new]];
    return [dayComponent day];
}

+ (NSInteger)getCurrentHour {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitHour;
    NSDateComponents *hourComponent = [calendar components:unitFlags fromDate:[NSDate new]];
    return [hourComponent hour];
}
@end
