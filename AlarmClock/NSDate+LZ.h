//
//  NSDate+LZ.h
//  分类
//
//  Created by administrator on 16/1/24.
//  Copyright © 2016年 lizhen. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDate (LZ)

#pragma mark 比较两个yyyy-MM-dd的时间戳, 相差多少天

///比较两个yyyy-MM-dd的时间戳, 相差多少天
///
///  @param timeStr1
///  @param timeStr2
///
///  @return <#return value description#>
+(NSInteger )compareTimeStr1:(NSString *)timeStr1 timeStr2:(NSString *)timeStr2;

#pragma mark 返回相隔天数
+(NSInteger)compareCurrentTime1:(NSString *)timeStamp;

///  判断某个时间是否为今年
- (BOOL)isThisYear;


///  判断是否为昨天
///
///  @param time yyyy-MM-dd  时间戳
///
///  @return <#return value description#>
+ (BOOL)isYesterdayWithTimeStr:(NSString *)time;


///  判断是否为今天
///
///  @param timeStr   yyyy-MM-dd  时间戳

+ (BOOL)isTodayWithTimeStr:(NSString *)timeStr;

/// 计算时间差
+(NSString *) compareCurrentTime:(NSString *)timeStamp;

///  时间戳转换成时间
///
///  @param timestamp 时间戳
///  @param timeFormat 时间格式
///
///  @return 时间
+(NSString *) timeWithTimestamp:(NSString *)timestamp withTimeFormart:(NSString *)timeFormat;

///  时间转换成时间戳
///
///  @param timeDate 时间
///
///  @return 时间戳
//+(NSString *)TimestampWithtime:(NSDate *)timeDate;
+(NSString *)TimestampWithtime:(NSString *)timeStr;

///  时间转换成时间戳
///
///  @param timeStr <#timeStr description#>
///
///  @return <#return value description#>
+(NSString *)TimestampWithtime1:(NSString *)timeStr;
/// 获取当前时间的时间戳
+(NSString *)getCurrentTimestamp;

///  获取当天时间
///
///  @param timeFormat时间类型
///
+(NSString *)getCurrentTimeswithTimeFormart:(NSString *)timeFormat;

+(NSString *)TimestampWithtime2:(NSString *)timeStr;

///  比较两个时间的大小
///
///  @param date01 时间1 -->格式yyyy-MM-dd
///  @param date02 时间1 -->格式yyyy-MM-dd
///
///  @return 1-->date01小  -1--> date01小  0-->相等
+(int)compareDate:(NSString*)date01 withDate:(NSString*)date02;

///  时间转换成时间戳
///
///  @param timeStr    时间
///  @param timeformat 时间的格式
///
///  @return 时间戳
+(NSString *)TimestampWithtime:(NSString *)timeStr WithFormat:(NSString *)timeformat;

///NSDate抓换成时间戳
+(NSString *)timestampWithDate:(NSDate *)date WithFormat:(NSString *)timeformat;

//根据日期判断星期几
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;

+ (NSDate *)dateFromString:(NSString *)timeStr
                    format:(NSString *)format;

///获取当前时间的前count月的时间
+(NSMutableArray *)getCurrentTimeBeforeTimeWithCount:(int)count;

+ (NSString *)passTime:(NSString *)time WithMonths:(NSInteger)month;
@end
