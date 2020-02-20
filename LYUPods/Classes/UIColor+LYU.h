//
//  UIColor+LYU.h
//  LYUPods
//
//  Created by donglyu on 2020/2/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LYUGradientDirection) {
    LYUGradientDirectionVertical,
    LYUGradientDirectionHorizontal,
};

@interface UIColor (LYU)

+ (UIColor *)themePlaceholderColor;

+ (UIColor *)colorWithHex:(NSString *)color alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHex:(NSString *)color;
+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue;
+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue Alpha:(CGFloat)alpha;

+ (UIColor *)randomColor;

#pragma mark - Commonly used colors
+ (UIColor *)colorWith333333Color;
+ (UIColor *)colorWithf4f4f4Color;
+ (UIColor *)colorWithBgf8f8f8Color;
+ (UIColor *)colorTextFieldBorderColor;

#pragma mark - Gradient
/**
 *  @brief  渐变颜色
 *
 *  @param c1           开始颜色
 *  @param c2           结束颜色
 *  @param direction    渐变方向
 *  @param range        渐变距离（竖向为高度，横向为宽度）
 *
 *  @return 渐变颜色
 */
+ (UIColor*)bm_gradientFromColor:(UIColor*)c1 toColor:(UIColor*)c2 direction:(LYUGradientDirection)direction withRange:(int)range;

@end

NS_ASSUME_NONNULL_END
