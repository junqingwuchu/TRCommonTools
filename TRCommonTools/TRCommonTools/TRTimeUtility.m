//
//  TRTimeUtility.m
//  YomoProject
//
//  Created by Tracky on 2016/4/26.
//  Copyright © 2018年 Tracky. All rights reserved.
//

#import "TRTimeUtility.h"

static NSDateFormatter *_dateFormatter;

@implementation TRTimeUtility

+ (void)initialize {
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    _dateFormatter.timeZone = [NSTimeZone localTimeZone];
}

+ (NSDate *)startOfYesterday {
    NSDate *todayStart = [self startOfToday];
    return [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay value:-1 toDate:todayStart options:0];
}

+ (NSDate *)startOfToday {
    return [self startOfDayForSomeDate:[NSDate date]];
}

+ (NSDate *)startOfTomorrow {
    NSDate *todayStart = [self startOfToday];
    return [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay value:1 toDate:todayStart options:0];
}

+ (NSDate *)startOfDayForSomeDate:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar startOfDayForDate:date];
}

+ (NSDate *)getCurrentTime{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970];
    NSDate *correctDate = [NSDate dateWithTimeIntervalSince1970:interval];
    return correctDate;
}

+ (NSString *)getFormatTimeByTimeInterval:(NSTimeInterval)timeInterval{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [_dateFormatter stringFromDate:date];
}

+ (NSString *)getCurrentFormatTime{
    NSDate *date = [self getCurrentTime];
    [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [_dateFormatter stringFromDate:date];
}

+ (NSString *)getCurrentLocalZoneFormatTime{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:[self getCurrentTime]];
}

+ (NSString *)getFormatTimeByDate:(NSDate *)date{
    [_dateFormatter setDateFormat:@"HH:mm:ss yyyy-MM-dd"];
    return [_dateFormatter stringFromDate:date];
}

+ (NSString *)getFormatTimeByDate2:(NSDate *)date{
    [_dateFormatter setDateFormat:@"HH:mm:ss"];
    return [_dateFormatter stringFromDate:date];
}

+ (NSString *)getFormatTimeNormalByDate:(NSDate *)date{
    [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [_dateFormatter stringFromDate:date];
}

+ (NSString *)getFormatTimeLocalZoneNormalByDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:date];
}

+ (NSDate *)getDateByFromateTime1:(NSString *)time {
    [_dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    return [_dateFormatter dateFromString:time];
}

+ (NSDate *)getDateByFromateTime2:(NSString *)time {
    [_dateFormatter setDateFormat: @"HH:mm:ss yyyy-MM-dd"];
    return [_dateFormatter dateFromString:time];
}

+ (NSDate *)getDateByFromateTime3:(NSString *)time {
    [_dateFormatter setDateFormat: @"yyyy-MM-dd"];
    return [_dateFormatter dateFromString:time];
}

+ (NSString *)dateStringWithInterval:(NSTimeInterval )time {
    [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [_dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:time]];
}

+ (NSString *)dateStringWithString:(NSString *)string{
    if (string.length >= 10) {
        return [string substringToIndex:10];
    }else{
        return string;
    }
}

+ (NSTimeInterval)timeIntervalWithDate:(NSDate *)date {
    return [date timeIntervalSince1970] * 1000;
}

+ (NSDate *)dateByAddingDays:(NSInteger)days {
    NSDate *currentDate = [NSDate date];
    return [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay value:days toDate:currentDate options:0];
}

+ (NSDate *)dateByAddingDays:(NSInteger)days fromDate:(NSDate *)date {
    return [[NSCalendar currentCalendar] dateByAddingUnit:NSCalendarUnitDay value:days toDate:date options:0];
}

+ (NSDate *)dateWithTimeInterval:(NSTimeInterval)interval {
    return [NSDate dateWithTimeIntervalSince1970:interval / 1000.0];
}

//////////////////////////////
///       设置时间显示风格
//////////////////////////////
// 字符串类型
+ (NSString *)dateStyleWithDateString:(NSString *)dateString{
    NSString * tempString = @"";
    
    NSDate * messageDate = [NSDate dateWithTimeIntervalSince1970:[dateString doubleValue]];
    NSTimeInterval seconds = [[NSDate date] timeIntervalSinceDate:messageDate];
    if (seconds > 60 && seconds <= 3600 ) {
        tempString = [NSString stringWithFormat:@"%d分钟前", (int)seconds / 60];
    }
    
    if (seconds > 3600 && seconds <= 3600 * 24) {
        tempString = [NSString stringWithFormat:@"%d小时前", (int)seconds / 3600];
    }
    if (seconds > 3600 * 24 ) {
        tempString = [NSString stringWithFormat:@"%d天前", (int)seconds / 3600 / 24];
    }
    return tempString;
}

// NSNumber 类型
+ (NSString *)dateStyleWithDateTime:(NSDate *)dateTime{
    NSString * tempString = @"";
    
    NSDate * date = [NSDate date];
    NSTimeInterval seconds = [date timeIntervalSince1970];
    long ceatedTime = (long)seconds * 1000 - [dateTime timeIntervalSince1970];
    if (ceatedTime/60/60/24 / 1000 >= 365) {
        tempString = [NSString stringWithFormat:@"%ld年前", ceatedTime/60/60/24 / 1000 / 365];
    } else{
        tempString = [NSString stringWithFormat:@"%ld天前", ceatedTime/60/60/24 / 1000];
    }
    return tempString;
}
@end
