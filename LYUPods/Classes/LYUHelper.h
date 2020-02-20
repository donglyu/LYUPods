//
//  LYUHelper.h
//  LYUPods
//
//  Created by donglyu on 2020/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYUHelper : NSObject


#pragma mark - Math

/// 指定范围内的随机数
+ (int)GetRandomNumber:(int)from to:(int)to;

#pragma mark - App about.


+ (NSString *)GetBundleIdentifier;

/** en zh-Hant zh-Hans*/
+ (NSString *)GetIOSLanguageStr;

/** the ios version of the system. like 12.2 */
+ (NSString *)GetIOSVersionStr;

/** the build version of the project */
+  (NSString *)GetAppBuildVersionStr;

/** the appVersion like: 1.0 */
+ (NSString *)GetAppVersionStr;

/** 全版本号 like v1.0.12 */
+ (NSString *)GetFullAppVersionStr;

@end

NS_ASSUME_NONNULL_END
