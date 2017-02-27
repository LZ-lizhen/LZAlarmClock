
//
//  NSDate+LZ.m
//  分类
//
//  Created by administrator on 16/1/24.
//  Copyright © 2016年 lizhen. All rights reserved.
//

#import "NSDate+LZ.h"

@implementation NSDate (LZ)


/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 获得某个时间的年月日时分秒
    NSDateComponents *dateCmps = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return dateCmps.year == nowCmps.year;
}

/**
 *  判断某个时间是否为昨天
 */
+ (BOOL)isYesterdayWithTimeStr:(NSString *)time
{
    NSDate *now = [NSDate date];
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowStr = [fmt stringFromDate:now];
    
    NSDate *date = [fmt dateFromString:time];
    now = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

+ (BOOL)isTodayWithTimeStr:(NSString *)timeStr
{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowStr = [fmt stringFromDate:now];
    
    return [timeStr isEqualToString:nowStr];
}

/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    
    return [dateStr isEqualToString:nowStr];
}

///  计算时间差
///
///  @param compareDate 某一指定时间
///
///  @return 多少(秒or分or天or月or年)+前 (比如，3天前、10分钟前)
+(NSString *) compareCurrentTime:(NSString *)timeStamp{

    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeStamp doubleValue]*0.001];

    NSTimeInterval  timeInterval = [date timeIntervalSinceNow];
    timeInterval = -timeInterval;
    
    int temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%d分钟前",temp];
    }
    else if((temp = temp/60) <24){
        
        result = [NSString stringWithFormat:@"%d小时前",temp];
    }else if((temp = temp/24) <= 7){
        
        result = [NSString stringWithFormat:@"%d天前",temp];
    }else{

        return [NSDate timeWithTimestamp:timeStamp withTimeFormart:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    return  result;
}

#pragma mark 返回相隔天数
+(NSInteger)compareCurrentTime1:(NSString *)timeStamp
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setFirstWeekday:2];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *fromDate;
    NSDate *toDate;
    [gregorian rangeOfUnit:NSDayCalendarUnit startDate:&fromDate interval:NULL forDate:[dateFormatter dateFromString:timeStamp]];
    [gregorian rangeOfUnit:NSDayCalendarUnit startDate:&toDate interval:NULL forDate:[NSDate date]];
    NSDateComponents *dayComponents = [gregorian components:NSDayCalendarUnit fromDate:toDate toDate:fromDate options:0];
    
    return  dayComponents.day;  //即为间隔的天数
}


#pragma mark 比较两个yyyy-MM-dd的时间戳, 相差多少天
+(NSInteger )compareTimeStr1:(NSString *)timeStr1 timeStr2:(NSString *)timeStr2{
    
    //时间戳转换成时间
    NSString *timeStr11 = [self timeWithTimestamp:timeStr1 withTimeFormart:@"yyyy-MM-dd"]; //HH:mm:ss
    
    NSString *timeStr22 = [self timeWithTimestamp:timeStr2 withTimeFormart:@"yyyy-MM-dd"];//HH:mm:ss
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd"; //HH:mm:ss
    
    NSDate *date1 = [fmt dateFromString:timeStr11];
    NSDate *date2 = [fmt dateFromString:timeStr22];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitSecond;
    NSDateComponents *cmps = [calendar components:unit fromDate:date1 toDate:date2 options:0];
    
    return  cmps.second;
}

#pragma mark 时间戳转换成时间
+(NSString *) timeWithTimestamp:(NSString *)timestamp withTimeFormart:(NSString *)timeFormat{
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]*0.001]; //1451544854449
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = timeFormat;
    
    NSString *time = [formatter stringFromDate:date];
    
    return time;
}

#pragma mark 时间转换成时间戳
+(NSString *)TimestampWithtime:(NSString *)timeStr{
    
    // 日期格式转换
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // 指定区域
    formatter.locale = [NSLocale systemLocale];

    // 指定日期格式
    formatter.dateFormat =  @"yyyy-MM-dd"; //@"yyyy-MM-dd HH:mm:ss"; //
    
    NSDate* date = [formatter dateFromString:timeStr]; //将字符串按formatter转成nsdate
    
    NSTimeInterval a=[date timeIntervalSince1970]*1000;
    //转为字符型
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *b =  [numberFormatter numberFromString:timeString];
    
    NSString *str = [NSString stringWithFormat:@"%@", b];
    
    return str;
}

#pragma mark 时间转换成时间戳
+(NSString *)TimestampWithtime1:(NSString *)timeStr{
    
    // 日期格式转换
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // 指定区域
    formatter.locale = [NSLocale systemLocale];
    
    // 指定日期格式
    formatter.dateFormat = @"yyyy-MM-dd";   //yyyy-MM-dd HH:mm:ss
    
    NSDate* date = [formatter dateFromString:timeStr]; //将字符串按formatter转成nsdate
    
    NSTimeInterval a=[date timeIntervalSince1970]*1000;
    //转为字符型
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *b =  [numberFormatter numberFromString:timeString];
    
    NSString *str = [NSString stringWithFormat:@"%@", b];
    
    return str;
}

+(NSString *)TimestampWithtime:(NSString *)timeStr WithFormat:(NSString *)timeformat{
    
    // 日期格式转换
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // 指定区域
    formatter.locale = [NSLocale systemLocale];
    
    // 指定日期格式
    formatter.dateFormat = timeformat;
    
    NSDate* date = [formatter dateFromString:timeStr]; //将字符串按formatter转成nsdate
    
    NSTimeInterval a=[date timeIntervalSince1970]*1000;
    //转为字符型
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *b =  [numberFormatter numberFromString:timeString];
    
    NSString *str = [NSString stringWithFormat:@"%@", b];
    
    return str;
}

+(NSString *)TimestampWithtime2:(NSString *)timeStr{
    
    // 日期格式转换
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // 指定区域
    formatter.locale = [NSLocale systemLocale];
    
    // 指定日期格式
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate* date = [formatter dateFromString:timeStr]; //将字符串按formatter转成nsdate
    
    NSTimeInterval a=[date timeIntervalSince1970]*1000;
    //转为字符型
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    
    
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *b =  [numberFormatter numberFromString:timeString];
    
    NSString *str = [NSString stringWithFormat:@"%@", b];
    
    return str;
}

#pragma mark 获取当前时间的时间戳
+(NSString *)getCurrentTimestamp{

    // 系统当前时间
    NSDate * date = [NSDate dateWithTimeIntervalSinceNow:0];
    
    // 日期格式转换
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // 指定区域
    formatter.locale = [NSLocale systemLocale];
    
    // 指定日期格式
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 获取时间结果
    NSString *dateStr = [formatter stringFromDate:date];
    
    return [NSDate TimestampWithtime2:dateStr];
}

#pragma mark 获取当天时间
+(NSString *)getCurrentTimeswithTimeFormart:(NSString *)timeFormat{
    
    NSString *str = [self getCurrentTimestamp];
    
    return   [self timeWithTimestamp:str withTimeFormart:timeFormat];
}

///NSDate抓换成时间戳
+(NSString *)timestampWithDate:(NSDate *)date WithFormat:(NSString *)timeformat{
    
    NSTimeInterval a=[date timeIntervalSince1970]*1000;
    //转为字符型
    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *b =  [numberFormatter numberFromString:timeString];
    
    NSString *str = [NSString stringWithFormat:@"%@", b];
    
    return str;
}


#pragma mark 比较两个时间的大小
+(int)compareDate:(NSString*)date01 withDate:(NSString*)date02{
    int ci;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *dt1 = [df dateFromString:date01];
    NSDate *dt2 = [df dateFromString:date02];
    NSComparisonResult result = [dt1 compare:dt2];
    switch (result)
    {
            //date02比date01大
        case NSOrderedAscending: ci=1; break;
            //date02比date01小
        case NSOrderedDescending: ci=-1; break;
            //date02=date01
        case NSOrderedSame: ci=0; break;
        default: NSLog(@"erorr dates %@, %@", dt2, dt1); break;
    }
    return ci;
}


//根据日期判断星期几
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:1];
    
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
//    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    
    return firstWeekday -1;
}

+ (NSDate *)dateFromString:(NSString *)timeStr
                    format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [NSDate defaultFormatter];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:timeStr];
    return date;
}

+(NSDateFormatter *)defaultFormatter
{
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc]init];
    });
    return dateFormatter;
}

+(NSMutableArray *)getCurrentTimeBeforeTimeWithCount:(int)count
{
    NSMutableArray *timeArray = [NSMutableArray array];
    
    //当前时间
    NSDate *currentDate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    
    for (int i = 0; i <count; i++)
    {
        [lastMonthComps setMonth:-i];
        NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:currentDate options:0];
        NSString *dateStr = [formatter stringFromDate:newdate];
        
        [timeArray addObject:dateStr];
    }
    
    return timeArray;
}


+ (NSString *)passTime:(NSString *)time WithMonths:(NSInteger)month{
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormatter setDateFormat:@"yyyy/MM"];
    NSDate* begainDate = [inputFormatter dateFromString:time];
    
    // 在当前日期时间加上时间：格里高利历
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *offsetComponent = [[NSDateComponents alloc]init];
    
    [offsetComponent setMonth:month];
    
    NSDate *monthsDate = [gregorian dateByAddingComponents:offsetComponent toDate:begainDate options:0];
    
    NSTimeInterval a=[monthsDate timeIntervalSince1970]*1000;
    //转为字符型
    NSString *timeStr = [NSString stringWithFormat:@"%f", a];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *b =  [numberFormatter numberFromString:timeStr];
    
    NSString *str = [NSString stringWithFormat:@"%@", b];
    
    return str;
}

@end
