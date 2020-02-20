//
//  LYUDateUtil.m
//  LYUPods
//
//  Created by donglyu on 2020/2/20.
//

#import "LYUDateKit.h"


#define kDefatulTimeFromat @"yyyy-MM-dd HH:mm:ss"

@interface LYUDateKit()

@property (nonatomic, strong) NSDateFormatter *formatter;

@end

@implementation LYUDateKit

+ (instancetype)shared {
    static LYUDateKit *shared = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        shared = [[self alloc] init];
    });
    return shared;
}


- (instancetype)init{
    self = [super init];
    if (self) {
        _formatter = [[NSDateFormatter alloc] init];
    }
    return self;
}

/// 获取当前时间的时间戳
+ (NSString *)DateTimeGetNowTimestamp{
    NSDateFormatter *formatter = [LYUDateKit shared].formatter ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    // hh与HH的区别:分别表示12小时制,24小时制
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"];
    // 设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    return timeSp;
}

/// 时间戳转Date
+ (NSDate *)DateTimeGetByTimestamp:(NSString *)timestamp{
    double time = [timestamp doubleValue] / 1000;
    NSDate *myDate = [NSDate dateWithTimeIntervalSince1970:time];
    return myDate;
}

/// NSDate to NSString
+ (NSString *)DateTimeGetDateStrWith:(NSDate *)date Format:(nullable NSString*)format{
    NSDateFormatter *formatter = [LYUDateKit shared].formatter;
    if (!format.length) {
        format = kDefatulTimeFromat;
    }
    [formatter setDateFormat:format];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

/// NSString to NSDate
+ (NSDate *)DateFromString:(NSString *)dateStr Format:(NSString*)format{
    NSDateFormatter *formatter = [LYUDateKit shared].formatter;
    if (format.length) {
    }else{
        format = kDefatulTimeFromat;
    }
    return [formatter dateFromString:dateStr];
}

+ (NSString *)DateIntelligentFormatBy:(NSDate*)date{
    if (date == nil) {
        return nil;
    }
    NSInteger interval = fabs([date timeIntervalSinceNow]);
    if(interval < 60){
        return [NSString stringWithFormat:@"%ld秒前", (long)interval];
    }else if(interval < 60*60){
        NSInteger time = interval/60;
        return [NSString stringWithFormat:@"%ld分钟前",(long)time];
    }else if(interval < 24*60*60){
        NSInteger time = interval/60/60;
        return [NSString stringWithFormat:@"%ld小时前",(long)time];
    }else if(interval < 30*24*60*60){
        NSInteger time = interval/24/60/60;
        return [NSString stringWithFormat:@"%ld天前",(long)time];
    }else if(interval < 12*30*24*60*60){
        NSInteger time = interval/30/24/60/60;
        return [NSString stringWithFormat:@"%ld月前",(long)time];
    }else{
        NSInteger time = interval/12/30/24/60/60;
        return [NSString stringWithFormat:@"%ld年前",(long)time];
    }
}

+ (NSString *)DateGetSuitableTimeShow:(NSString *)str{
    NSDateFormatter *dateFormatter = [LYUDateKit shared].formatter;
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    NSDate *nowDate = [NSDate date];
    NSDate *yesterday = [nowDate dateByAddingTimeInterval:-24 * 60 * 60];
    
    NSString *todayStr = [[nowDate description] substringToIndex:10];
    NSString *yesterdayStr = [[yesterday description] substringToIndex:10];
    NSString *impressTimeStr = [str substringToIndex:10];
    
    NSString *currentYearStr = [[nowDate description] substringToIndex:4];
    NSString *impressYearStr = [str substringToIndex:4];
    
    NSString *result;
    if ([impressTimeStr isEqualToString:todayStr]){  // 当天消息
        result = [str substringWithRange:NSMakeRange(11, 5)];
    }
    else if ([impressTimeStr isEqualToString:yesterdayStr]){  // 昨天消息
        NSString *time = [str substringWithRange:NSMakeRange(11, 5)];
        result = [NSString stringWithFormat:@"昨天 %@",time];
    }
    else if ([impressYearStr isEqualToString:currentYearStr]){  // 超过一天 且是 同年消息
        result = [self DateTimeGetDateStrWith:timeDate Format:@"MM-dd HH:mm"];
    }
    else if (![impressYearStr isEqualToString:currentYearStr]){  // 去年或更早消息
        result = [self DateTimeGetDateStrWith:timeDate Format:@"yyyy-MM-dd HH:mm"];
    }
    return  result;
}

+ (NSString *)DateFormatShowWithSeconds:(int)totalSeconds{
    int seconds = totalSeconds % 60;int minutes = (totalSeconds / 60) % 60;int hours = totalSeconds / 3600;
    if (hours) {
        return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
    }
    return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
}

+ (NSDate *)GetNDaysAfter:(NSInteger)n{
    NSDate*nowDate = [NSDate date];
    NSDate* theDate;
    if(n!=0){
        NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
        theDate = [nowDate initWithTimeIntervalSinceNow: oneDay*n ];//initWithTimeIntervalSinceNow是从现在往前后推的秒数
    }else{
        theDate = nowDate;
    }
    return theDate;
}

+ (int)CompareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay{
    NSDateFormatter *dateFormatter = [LYUDateKit shared].formatter;
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    // NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    
    if (result == NSOrderedDescending) {
        //NSLog(@"oneDay  is in the future");
        return 1;
    }
    else if (result ==NSOrderedAscending){
        //NSLog(@"oneDay is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
}

@end
