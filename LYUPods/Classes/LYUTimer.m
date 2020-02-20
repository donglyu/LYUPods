//
//  LYUTimer.m
//  LYUPods
//
//  Created by donglyu on 2020/2/20.
//

#import "LYUTimer.h"

@interface LYUTimer ()

@property (nonatomic, weak) id      target;
@property (nonatomic, assign) SEL   selector;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation LYUTimer

- (void)timeAction:(NSTimer *)timer {
    if (self.target) {
        [self.target performSelector:self.selector withObject:timer.userInfo afterDelay:0.0f];
    }else {
        [self.timer invalidate];
    }
}


+ (NSTimer *)ScheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval target:(id)target selector:(SEL)selector userInfo:(id)userInfo repeats:(BOOL)repeats {
    LYUTimer *timerTarget = [[LYUTimer alloc] init];
    timerTarget.target   = target;
    timerTarget.selector = selector;
    timerTarget.timer    = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:timerTarget selector:@selector(timeAction:) userInfo:userInfo repeats:repeats];
    return timerTarget.timer;
}

+ (NSTimer *)ScheduledTimerWithTimeInterval:(NSTimeInterval)timeInterval block:(LDTimerBlock)block userInfo:(id)userInfo repeats:(BOOL)repeats {
    NSMutableArray *userInfoArr = [NSMutableArray arrayWithObject:[block copy]];
    if (userInfo != nil) {
        [userInfoArr addObject:userInfo];
    }
    return [self ScheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(timerBlock:) userInfo:[userInfoArr copy] repeats:repeats];
}

+ (void)timerBlock:(NSArray *)userInfo {
    LDTimerBlock block = userInfo.firstObject;
    id info = nil;
    if (userInfo.count == 2) {
        info = userInfo[1];
    }
    
    !block ? : block(info);
}


@end
