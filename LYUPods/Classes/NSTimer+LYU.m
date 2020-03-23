//
//  NSTimer+LYU.m
//  LYUPods
//
//  Created by donglyu on 2020/3/20.
//

#import "NSTimer+LYU.h"
@implementation NSTimer (LYU)

- (void)pauseTimer{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]]; //如果给我一个期限，我希望是4001-01-01 00:00:00 +0000
}


-(void)resumeTimer{
    
    if (![self isValid]) {
        return ;
    }
    
    //[self setFireDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    [self setFireDate:[NSDate date]];
}

-(void)resumeTimerAfterSeconds:(NSInteger)seconds{
    if (![self isValid]) {
        return ;
    }
    
    if (!seconds) {
        [self resumeTimer];
    }else{
        [self setFireDate:[[NSDate date] dateByAddingTimeInterval:seconds]];
    }
}
@end
