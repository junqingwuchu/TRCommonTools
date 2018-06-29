//
//  TRTimeUtility.h
//  YomoProject
//
//  Created by Tracky on 2016/4/26.
//  Copyright © 2018年 Tracky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRTimeUtility : NSObject

+ (NSDate *)startOfDayForSomeDate:(NSDate *)date;

+ (NSDate *)startOfTomorrow;

+ (NSDate *)startOfToday;

+ (NSDate *)startOfYesterday;

/*!
 *  @author Tracky
 *
 *  @brief 获取当前时间
 *
 *  @return "NSDate"类型
 */
+ (NSDate *)getCurrentTime;
/*!
 *  @author Tracky
 *
 *  @brief 当前时间的格式化字符串  "yyyy-MM-dd HH:mm:ss"
 *
 *  @return UTC时区下当前时间格式化字符串
 */
+ (NSString *)getCurrentFormatTime;
/*!
 *  @author Tracky
 *
 *  @brief 当前时间的格式化字符串  "yyyy-MM-dd HH:mm:ss"
 *
 *  @return 当前系统时区下当前时间格式化字符串
 */
+ (NSString *)getCurrentLocalZoneFormatTime;
/*!
 *  @author Tracky
 *
 *  @brief 指定时间的格式化字符串  "HH:mm:ss yyyy-MM-dd"
 *
 *  @return 指定时间格式化字符串
 */
+ (NSString *)getFormatTimeByDate:(NSDate *)date;
/*!
 *  @author Tracky
 *
 *  @brief 指定时间的格式化字符串  "HH:mm:ss"
 *
 *  @param date date
 *
 *  @return 指定时间格式化字符串
 */
+ (NSString *)getFormatTimeByDate2:(NSDate *)date;
/*!
 *  @author Tracky
 *
 *  @brief 获取指定时间指定格式字符串 "yyyy-MM-dd HH:mm:ss"
 *
 *  @param timeInterval 指定时间
 *
 *  @return 指定时间指定格式字符串
 */
+ (NSString *)getFormatTimeByTimeInterval:(NSTimeInterval)timeInterval;
/*!
 *  @author Tracky,
 *
 *  @brief 通过格式化的字符串返回NSDate
 *
 *  @param time 字符串“yyyy-MM-dd HH:mm:ss”
 *
 *  @return date
 */

+ (NSDate *)getDateByFromateTime1:(NSString *)time;

/*!
 *  @author Tracky,
 *
 *  @brief 通过格式化的字符串返回NSDate
 *
 *  @param time 字符串“HH:mm:ss yyyy-MM-dd”
 *
 *  @return date
 */
+ (NSDate *)getDateByFromateTime2:(NSString *)time;

/*!
 *  @author Tracky, 
 *
 *  @brief 通过格式化的字符串返回NSDate
 *
 *  @param time 字符串“yyyy-MM-dd”
 *
 *  @return date
 */
+ (NSDate *)getDateByFromateTime3:(NSString *)time;

/*!格式：“yyyy-MM-dd HH:mm:ss”*/
+ (NSString *)getFormatTimeNormalByDate:(NSDate *)date;

/*!
 *  @author Tracky
 *
 *  @brief 获取指定时间指定格式字符串 "yyyy-MM-dd"
 *
 *  @param timeInterval 指定时间
 *
 *  @return 当前系统时区下指定时间指定格式字符串
 */
+ (NSString *)getFormatTimeLocalZoneNormalByDate:(NSDate *)date;
/*!
 *  @author Tracky
 *
 *  @brief 获取指定时间指定格式字符串 "yyyy-MM-dd"
 *
 *  @param timeInterval 指定时间
 *
 *  @return 指定时间指定格式字符串
 */
+ (NSString *)dateStringWithString:(NSString *)string;

+ (NSTimeInterval)timeIntervalWithDate:(NSDate *)date;

/**
 @brief 获取指定时间指定格式字符串 "yyyy-MM-dd HH:mm"
 */
+ (NSString *)dateStringWithInterval:(NSTimeInterval )time;

+ (NSDate *)dateByAddingDays:(NSInteger)days;

+ (NSDate *)dateByAddingDays:(NSInteger)days fromDate:(NSDate *)date;

+ (NSDate *)dateWithTimeInterval:(NSTimeInterval)interval;

//////////////////////////////
///       设置时间显示风格
//////////////////////////////
// 字符串类型
+ (NSString *)dateStyleWithDateString:(NSString *)dateString;
@end
