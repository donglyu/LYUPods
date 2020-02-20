//
//  UIColor+LYU.m
//  LYUPods
//
//  Created by donglyu on 2020/2/20.
//

#import "UIColor+LYU.h"


@implementation UIColor (LYU)

+ (UIColor *)themePlaceholderColor{
    return [UIColor colorWithHex:@"c7c7cc"];
}

+ (UIColor *)colorWithHex:(NSString *)color alpha:(CGFloat)alpha{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"])  {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) {
        return [UIColor clearColor];
    }
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)colorWithHex:(NSString *)color{
    return [self colorWithHex:color alpha:1.0f];
}

+ (UIColor *)randomColor{
    NSInteger aRedValue = arc4random() % 255;
    NSInteger aGreenValue = arc4random() % 255;
    NSInteger aBlueValue = arc4random() % 255;
    UIColor *randColor = [UIColor colorWithRed:aRedValue / 255.0f green:aGreenValue / 255.0f blue:aBlueValue / 255.0f alpha:1.0f];
    return randColor;

}

+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue{
    return [UIColor colorWithRed:(red)/255.0f green:(green)/255.0f blue:(blue)/255.0f alpha:1];
}

+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue Alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:(red)/255.0f green:(green)/255.0f blue:(blue)/255.0f alpha:alpha];
}

#pragma mark Commonly used colors

+ (UIColor *)colorWith333333Color{
    return [UIColor colorWithHex:@"#333333"];
}

+ (UIColor *)colorWithf4f4f4Color{
    return [UIColor colorWithHex:@"f4f4f4"];
}

+ (UIColor *)colorWithBgf8f8f8Color{
    return [UIColor colorWithHex:@"f8f8f8"];
}


+ (UIColor *)colorTextFieldBorderColor{
    return [UIColor colorWithHex:@"cccccc"];
}


#pragma mark - gradient color

+ (UIColor*)lyu_gradientFromColor:(UIColor*)c1 toColor:(UIColor*)c2 direction:(LYUGradientDirection)direction withRange:(int)range {
    
    if (direction == LYUGradientDirectionHorizontal) {
        CGSize size = CGSizeMake(range, 1);
        UIGraphicsBeginImageContextWithOptions(size, NO, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
        
        NSArray* colors = [NSArray arrayWithObjects:(id)c1.CGColor, (id)c2.CGColor, nil];
        CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (__bridge CFArrayRef)colors, NULL);
        CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(size.width, 0), 0);
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        
        CGGradientRelease(gradient);
        CGColorSpaceRelease(colorspace);
        UIGraphicsEndImageContext();
        return [UIColor colorWithPatternImage:image];
    }else if (direction == LYUGradientDirectionVertical){
        CGSize size = CGSizeMake(1, range);
        UIGraphicsBeginImageContextWithOptions(size, NO, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
        
        NSArray* colors = [NSArray arrayWithObjects:(id)c1.CGColor, (id)c2.CGColor, nil];
        CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (__bridge CFArrayRef)colors, NULL);
        CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, size.height), 0);
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        
        CGGradientRelease(gradient);
        CGColorSpaceRelease(colorspace);
        UIGraphicsEndImageContext();
        return [UIColor colorWithPatternImage:image];
    }else {
        return [UIColor blackColor];
    }
    
    
    
    
}

@end
