//
//  LYUDateUtil.h
//  LYUPods
//
//  Created by donglyu on 2020/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYUDateKit : NSObject

@property (nonatomic, strong) NSDateFormatter *formatter;

/// 获取当前时间的时间戳
+ (NSString *)DateTimeGetNowTimestamp;

/// covert timestamp(unit:second) to NSDate.
+ (NSDate *)DateTimeGetByTimestamp:(NSString *)timestamp;

+ (NSString *)DateTimeGetDateStrWith:(NSDate *)date Format:(nullable NSString*)format;

+ (NSDate *)DateFromString:(NSString *)dateStr Format:(NSString*)format;

/// 格式化显示1：n秒前）
+ (NSString *)DateIntelligentFormatBy:(NSDate*)date;

/// 格式化显示2：input: yyyy-MM-dd HH:mm:ss output: 昨天 12:02
+ (NSString *)DateGetSuitableTimeShow:(NSString *)str;

/// eg: 70s convert to 00:01:10
+ (NSString *)DateFormatShowWithSeconds:(int)totalSeconds;

+ (NSDate *)GetNDaysAfter:(NSInteger)n;

/// 比较时间先后  return 1 means oneDay is in the future. (oneDay > anotherDay)
+ (int)CompareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

@end

NS_ASSUME_NONNULL_END
