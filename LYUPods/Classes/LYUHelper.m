//
//  LYUHelper.m
//  LYUPods
//
//  Created by donglyu on 2020/2/20.
//

#import "LYUHelper.h"

@implementation LYUHelper


#pragma mark - Math
+ (int)GetRandomNumber:(int)from to:(int)to{
    return (int)(from + (arc4random()%(to-from + 1)));
}

#pragma mark - App about

+ (NSString *)GetBundleIdentifier{
    return [[NSBundle mainBundle] bundleIdentifier];
}

/** en zh-Hant zh-Hans*/
+ (NSString *)GetIOSLanguageStr {
    NSString *language =  [[NSBundle mainBundle] preferredLocalizations][0];
    return language;
}


/** the ios version of the system. like 12.2 */
+ (NSString *)GetIOSVersionStr {
    return [[UIDevice currentDevice] systemVersion];
}

/** the build version of the project */
+ (NSString *)GetAppBuildVersionStr {
    NSString *buildVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)@"CFBundleVersion"];
    return buildVersion;
}

/** the appVersion like: 1.0 */
+ (NSString *)GetAppVersionStr {
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)@"CFBundleShortVersionString"];
    return version;
}

+ (NSString *)GetFullAppVersionStr{
    return [NSString stringWithFormat:@"v%@.%@", [self GetAppVersionStr],[self GetAppBuildVersionStr]];
}

@end
