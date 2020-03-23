//
//  NSTimer+LYU.h
//  LYUPods
//
//  Created by donglyu on 2020/3/20.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (LYU)

-(void)pauseTimer;
-(void)resumeTimer;
-(void)resumeTimerAfterSeconds:(NSInteger)seconds;

@end

NS_ASSUME_NONNULL_END
