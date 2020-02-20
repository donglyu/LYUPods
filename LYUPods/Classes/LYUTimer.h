//
//  LYUTimer.h
//  LYUPods
//
//  Created by donglyu on 2020/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^LDTimerBlock)(id userInfo);
@interface LYUTimer : NSObject
+ (NSTimer *)ScheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval
                                     target:(id)target
                                   selector:(SEL)selector
                                   userInfo:(nullable id)userInfo
                                    repeats:(BOOL)repeats;

+ (NSTimer *)ScheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval
                                      block:(LDTimerBlock)block
                                   userInfo:(nullable id)userInfo
                                    repeats:(BOOL)repeats;
@end

NS_ASSUME_NONNULL_END
