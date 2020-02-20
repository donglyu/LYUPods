//
//  LYUCommonMacro.h
//  LYUPods
//
//  Created by donglyu on 2020/2/20.
//

#ifndef LYUCommonMacro_h
#define LYUCommonMacro_h


#define LYUWeakself(type) __weak __typeof__(type) weakself = type;
#define LYUtrongSelf(type) __strong __typeof__(type) strongself = type;

#define LYUScreenW [UIScreen mainScreen].bounds.size.width
#define LYUScreenH [UIScreen mainScreen].bounds.size.height
#define LYUScreenScale [UIScreen mainScreen].scale

#define kDeviceIsFaceIDIPhone (ScreenH == 812 || ScreenH == 896 || ScreenW == 812 || ScreenW == 896)
#define kDeviceIs5Series (ScreenH == 568)
#define kDeviceIs6Series (ScreenH == 667)
#define kDeviceIsiPad ([[UIDevice currentDevice].model hasSuffix:@"iPad"])

#define kLYUiOS11Later ([UIDevice currentDevice].systemVersion.floatValue >= 11.0f)

#define kLYUPATH_OF_DOCUMENT [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define kLYUPATH_OF_TEMP NSTemporaryDirectory()
#define kLYUPATH_OF_HOME NSHomeDirectory()

// --- status & navibar & tabbar height,bottom,padding ---
#define kStatusBarHeightFromGet ([[UIApplication sharedApplication] statusBarFrame].size.height)
// 高度可能因为有通话,或者wifi热点而导致高度获取不正确的问题.要求较高的应用另需要监听高度变化
#define kStatusBarHeight (kDeviceIsFaceIDIPhone ? (kStatusBarHeightFromGet ? kStatusBarHeightFromGet: 44):(kStatusBarHeightFromGet ? kStatusBarHeightFromGet: 20))
#define kNaviStatusBarTotalHeight (kStatusBarHeight + 44)
#define kBottomSafePadding (kDeviceIsFaceIDIPhone? 34:0)
#define kTabBarHeight (kDeviceIsFaceIDIPhone ? 83:49)

#define LYUDeprecated(instead) NS_DEPRECATED(8_0, 8_0, 8_0, 8_0, instead)

// --- 打印 ---
#ifndef __OPTIMIZE__        // debug.//NSLog(__VA_ARGS__) [iConsole info:__VA_ARGS__] RLog : ReleaseLog . debug. 和 release 都打印, 一般是重要信息.
#define DLog(...) NSLog(__VA_ARGS__)
#define RLog(...) NSLog(__VA_ARGS__)
#else
#define DLog(...)
#define RLog(...) NSLog(__VA_ARGS__)
#endif

/**
 白绿 小麦色#df9464 菫色#6f60aa
 */
#define LYU_TestColor1 [UIColor colorWithRed:205/255.0 green:230/255.0 blue:199/255.0 alpha:1]
#define LYU_TestColor2 [UIColor colorWithRed:223/255.0 green:148/255.0 blue:100/255.0 alpha:1]
#define LYU_TestColor3 [UIColor colorWithRed:111/255.0 green:96/255.0 blue:170/255.0 alpha:0.5]
#define LYU_RandomColor [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1]

// Null转nil
#define LYU_NULL_TO_NIL(obj) ({ __typeof__ (obj) __obj = (obj); __obj == [NSNull null] ? nil : obj; })

// 适配宽度，已经取整适配宽度
#define LYU_FitW(value)          ((value)/750.0f*[UIScreen mainScreen].bounds.size.width)
#define LYU_FitCeilW(value)      ceil(((value)/750.0f*[UIScreen mainScreen].bounds.size.width))


// --- 开发扩展 减少部分代码 ---

#define LYU_X(v)                    (v).frame.origin.x
#define LYU_Y(v)                    (v).frame.origin.y
#define LYU_WIDTH(v)                (v).frame.size.width
#define LYU_HEIGHT(v)               (v).frame.size.height

#define LYU_MinX(v)                 CGRectGetMinX((v).frame)
#define LYU_MinY(v)                 CGRectGetMinY((v).frame)
#define LYU_MidX(v)                 CGRectGetMidX((v).frame)
#define LYU_MidY(v)                 CGRectGetMidY((v).frame)
#define LYU_MaxX(v)                 CGRectGetMaxX((v).frame)
#define LYU_MaxY(v)                 CGRectGetMaxY((v).frame)
#define LYU_S_FONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]
#define LYU_S_BOLD_FONT(FONTSIZE)   [UIFont boldSystemFontOfSize:FONTSIZE]

#define LYU_ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

#define kLYUAppDelegate     (AppDelegate *)[[UIApplication sharedApplication] delegate]
#define kLYUFileManager [NSFileManager defaultManager]
#define kLYUUserDefaults   [NSUserDefaults standardUserDefaults]
#define kLYUUserDefaultsGET(KEY)     [[NSUserDefaults standardUserDefaults]objectForKey:KEY]
#define kLYUUserDefaultsSET(VALUE,KEY)  [[NSUserDefaults standardUserDefaults] setObject:VALUE forKey:KEY]
#define kLYUUserDefaultsSYN [[NSUserDefaults standardUserDefaults] synchronize]
#define LYU_NOTIF_CENTER [NSNotificationCenter defaultCenter]


#endif /* LYUCommonMacro_h */
