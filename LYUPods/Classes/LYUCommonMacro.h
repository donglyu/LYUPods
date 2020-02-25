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

#pragma mark - from yycategorieds


#ifndef YY_SWAP // swap two value
#define YY_SWAP(_a_, _b_)  do { __typeof__(_a_) _tmp_ = (_a_); (_a_) = (_b_); (_b_) = _tmp_; } while (0)
#endif

// --- contents below is from yycategories ---
#define LYUAssertNil(condition, description, ...) NSAssert(!(condition), (description), ##__VA_ARGS__)
#define LYUCAssertNil(condition, description, ...) NSCAssert(!(condition), (description), ##__VA_ARGS__)

#define LYUAssertNotNil(condition, description, ...) NSAssert((condition), (description), ##__VA_ARGS__)
#define LYUCAssertNotNil(condition, description, ...) NSCAssert((condition), (description), ##__VA_ARGS__)

#define LYUAssertMainThread() NSAssert([NSThread isMainThread], @"This method must be called on the main thread")
#define LYUCAssertMainThread() NSCAssert([NSThread isMainThread], @"This method must be called on the main thread")

/**
 Add this macro before each category implementation, so we don't have to use
 -all_load or -force_load to load object files from static libraries that only
 contain categories and no classes.
 More info: http://developer.apple.com/library/mac/#qa/qa2006/qa1490.html .
 *******************************************************************************
 Example:
     YYSYNTH_DUMMY_CLASS(NSString_YYAdd)
 */
#ifndef YYSYNTH_DUMMY_CLASS
#define YYSYNTH_DUMMY_CLASS(_name_) \
@interface YYSYNTH_DUMMY_CLASS_ ## _name_ : NSObject @end \
@implementation YYSYNTH_DUMMY_CLASS_ ## _name_ @end
#endif

/**
 Synthsize a dynamic object property in @implementation scope.
 It allows us to add custom properties to existing classes in categories.
 
 @param association  ASSIGN / RETAIN / COPY / RETAIN_NONATOMIC / COPY_NONATOMIC
 @warning #import <objc/runtime.h>
 *******************************************************************************
 Example:
     @interface NSObject (MyAdd)
     @property (nonatomic, retain) UIColor *myColor;
     @end
     
     #import <objc/runtime.h>
     @implementation NSObject (MyAdd)
     LYUSYNTH_DYNAMIC_PROPERTY_OBJECT(myColor, setMyColor, RETAIN, UIColor *)
     @end
 */
#ifndef LYUSYNTH_DYNAMIC_PROPERTY_OBJECT
#define LYUSYNTH_DYNAMIC_PROPERTY_OBJECT(_getter_, _setter_, _association_, _type_) \
- (void)_setter_ : (_type_)object { \
    [self willChangeValueForKey:@#_getter_]; \
    objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_ ## _association_); \
    [self didChangeValueForKey:@#_getter_]; \
} \
- (_type_)_getter_ { \
    return objc_getAssociatedObject(self, @selector(_setter_:)); \
}
#endif


/**
 Synthsize a dynamic c type property in @implementation scope.
 It allows us to add custom properties to existing classes in categories.
 
 @warning #import <objc/runtime.h>
 *******************************************************************************
 Example:
     @interface NSObject (MyAdd)
     @property (nonatomic, retain) CGPoint myPoint;
     @end
     
     #import <objc/runtime.h>
     @implementation NSObject (MyAdd)
     LYUSYNTH_DYNAMIC_PROPERTY_CTYPE(myPoint, setMyPoint, CGPoint)
     @end
 */
#ifndef LYUSYNTH_DYNAMIC_PROPERTY_CTYPE
#define LYUSYNTH_DYNAMIC_PROPERTY_CTYPE(_getter_, _setter_, _type_) \
- (void)_setter_ : (_type_)object { \
    [self willChangeValueForKey:@#_getter_]; \
    NSValue *value = [NSValue value:&object withObjCType:@encode(_type_)]; \
    objc_setAssociatedObject(self, _cmd, value, OBJC_ASSOCIATION_RETAIN); \
    [self didChangeValueForKey:@#_getter_]; \
} \
- (type)_getter_ { \
    _type_ cValue = { 0 }; \
    NSValue *value = objc_getAssociatedObject(self, @selector(_setter_:)); \
    [value getValue:&cValue]; \
    return cValue; \
}
#endif


#import <pthread.h>

/**
 Submits a block for asynchronous execution on a main queue and returns immediately.
 */
static inline void dispatch_async_on_main_queue(void (^block)(void)) {
    if (pthread_main_np()) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}


#endif /* LYUCommonMacro_h */
