//
//  UIImage+LYU.h
//  LYUPods
//
//  Created by donglyu on 2020/2/20.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (LYU)

#pragma mark - Class Method
/// 对指定的UI控件进行截图
+ (UIImage *)captureView:(UIView *)targetView;

/// 从bundle中加载2x 3x图
+ (instancetype)imageWithBundleFileName:(NSString *)imageName;

/// 从可选bundle中正确加载2x 3x图
+ (instancetype)imagwWithBundle:(NSString*)bundleName FileName:(NSString*)imageName;

/// 带边框的圆图
+ (instancetype)imageWithName:(NSString *)name border:(CGFloat)border borderColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)aColor;

+ (UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame;

/// 纯色圆图
+ (UIImage *)circleImageWithColor:(UIColor *)aColor WithBounds:(CGRect)aBounds;

/// 标准带白圈的头像 生成器. 160px * 160px lineWidth : 6     bounds: 1 scale . so need * kscreenScale
+ (UIImage *)circleAvatarImage:(UIImage *)image WithBounds:(CGRect)aBounds WhiteLineWidth:(CGFloat)lineWidth;

+ (UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset;

/// 画一条虚线，根据参数的不同来定是竖虚线，还是横虚线。
+ (UIImage *)DashedLineImageWithLineWidth:(CGFloat)lineW LineHeight:(CGFloat)lineHeight Color:(UIColor*)color IsHorizontal:(BOOL)isH;

/// 挖取图片的指定区域
- (UIImage *)imageAtRect:(CGRect)rect;

/// 保持图片纵横比缩放，最短边缩放后必须匹配targetSize的大小,长边截取
- (UIImage *)imageByScalingAspectToMinSize:(CGSize)targetSize;

/// 保持图片纵横比缩放，最短长边缩放后必须匹配targetSize的大小,短边留白
- (UIImage *)imageByScalingAspectToMaxSize:(CGSize)targetSize;

/// 不保持图片的纵横比缩放
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

/// 对图片按弧度执行旋转
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;

/// 对图片按角度执行旋转 90
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

/// 保存图片 至Document
- (void)saveToDocuments:(NSString *)fileName;

/// 从Image Sources中获取缩略图
- (UIImage *)getThumbnailImageFrom:(NSString *)imageFileURL ImageSourceWithSize:(int)imageSize;
- (UIImage *)getImageFromImageSource:(NSString *)imageFileURL;

- (BOOL)containAlphaChannel;

/// 画水印
- (UIImage *)DrawWaterMark:(UIImage *)mark inRect:(CGRect)rect;

/// 对图片尺寸进行压缩--
- (UIImage*)scaledToSize:(CGSize)targetSize;

- (UIImage*)scaledToSize:(CGSize)targetSize highQuality:(BOOL)highQuality;

/// 普通图片修正方向
- (UIImage*)FixOrientation;



@end

NS_ASSUME_NONNULL_END
