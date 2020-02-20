//
//  LYUExecuteControl.m
//  LYUPods
//
//  Created by donglyu on 2020/2/20.
//

#import "LYUExecuteControl.h"
#import "LYUDateKit.h"

@implementation LYUExecuteControl

+ (BOOL)executeOnlyOnce:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL flag = [userDefaults boolForKey:key];
    if(flag == NO){
        [userDefaults setBool:YES forKey:key];
        [userDefaults synchronize];
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)executeOnlyInCount:(NSInteger)count withKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if([self executeOnlyOnce:[NSString stringWithFormat:@"%@%zd", key, count]]) {
        [userDefaults setInteger:count forKey:key]; // 首次存入
    }
    
    // 1.获取当前次数
    NSInteger currentCount = [userDefaults integerForKey:key];
    if(currentCount > 0) { // 还可以执行
        currentCount -= 1; // 自减1
        [userDefaults setInteger:currentCount forKey:key];
        [userDefaults synchronize];
        return YES;
    }else { // 不能执行
        return NO;
    }
}

+ (BOOL)executeOnlyInTimes:(NSInteger)times withKey:(NSString *)key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if([self executeOnlyOnce:[NSString stringWithFormat:@"%@_%zd", key, times]]) {
        [userDefaults setInteger:1 forKey:key]; // 首次存入
    }
    
    // 1.获取当前次数
    NSInteger currentCount = [userDefaults integerForKey:key];
    if(currentCount == times) { // 还可以执行
        currentCount += 1; // 自加1
        [userDefaults setInteger:currentCount forKey:key];
        [userDefaults synchronize];
        return YES;
    }else { // 不能执行
        currentCount += 1; // 自加1
        [userDefaults setInteger:currentCount forKey:key];
        [userDefaults synchronize];
        return NO;
    }
}
+ (BOOL)everyDayFirstExecute:(NSString *)key{
    NSDate *date = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if(date){
        NSString *oldDay = [LYUDateKit DateTimeGetDateStrWith:date Format:nil];//[ timeFormat:date];
        NSString *nowDay = [LYUDateKit DateTimeGetDateStrWith:date Format:nil];//[ timeFormat:[NSDate date]];
        if([oldDay isEqualToString:nowDay]){
            return NO;
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return YES;
}

@end
