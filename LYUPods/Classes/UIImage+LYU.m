//
//  UIImage+LYU.m
//  LYUPods
//
//  Created by donglyu on 2020/2/20.
//

#import "UIImage+LYU.h"

#import <ImageIO/ImageIO.h>
#import <Accelerate/Accelerate.h>
#import "LYUCommonMacro.h"

YYSYNTH_DUMMY_CLASS(UIImage_LYU)

@implementation UIImage (LYU)

+ (UIImage *)captureView:(UIView *)targetView {

    //获取目标UIView所在的区域
    CGRect rect = targetView.frame;
    //开始绘图
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //调用CALayer的方法将当前控件绘制到绘图ctx中
    [targetView.layer renderInContext:ctx];
    //获取该绘图ctx中的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();\
    UIGraphicsEndImageContext();
    return newImage;

}

+ (instancetype)imageWithBundleFileName:(NSString*)imageName{
    if (!imageName) {
        return nil;
    }
    NSString *realFileName = imageName;
    if (![imageName containsString:@".png"] && ![imageName containsString:@".jpg"]) {
        realFileName = [imageName stringByAppendingString:@".png"];
    }
    return [UIImage imageWithContentsOfFile: [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:realFileName]];
}

+ (instancetype)imageWithName:(NSString *)name border:(CGFloat)border borderColor:(UIColor *)color{
    // 圆环的宽度
    CGFloat borderW = border;
    // 加载旧的图片
    UIImage *oldImage =  [UIImage imageNamed:name];
    // 新的图片尺寸
    CGFloat imageW = oldImage.size.width + 2 * borderW;
    CGFloat imageH = oldImage.size.height + 2 * borderW;
    // 设置新的图片尺寸
    CGFloat circirW = imageW > imageH ? imageH : imageW;
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(circirW, circirW), NO, 0.0);
    // 画大圆
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, circirW, circirW)];
    // 获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    // 设置颜色
    [color set];
    // 渲染
    CGContextFillPath(ctx);
    CGRect clipR = CGRectMake(borderW, borderW, oldImage.size.width, oldImage.size.height);
    // 画圆：正切于旧图片的圆
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:clipR];
    // 设置裁剪区域
    [clipPath addClip];
    // 画图片
    [oldImage drawAtPoint:CGPointMake(borderW, borderW)];
    // 获取新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)imageWithColor:(UIColor *)aColor{
    return [UIImage imageWithColor:aColor withFrame:CGRectMake(0, 0, 2, 0.5f)];
}

+ (UIImage *)imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame{
//    UIGraphicsBeginImageContext(aFrame.size);
    UIGraphicsBeginImageContextWithOptions(aFrame.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [aColor CGColor]);
    CGContextFillRect(context, aFrame);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

/** 指定大小画圆*/
+ (UIImage *)circleImageWithColor:(UIColor *)aColor WithBounds:(CGRect)aBounds{
//    UIGraphicsBeginImageContext(aBounds.size);
    UIGraphicsBeginImageContextWithOptions(aBounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextAddEllipseInRect(context, aBounds);
    CGContextClip(context);
    CGContextSetFillColorWithColor(context, [aColor CGColor]);
    CGContextFillRect(context, aBounds);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;

}

/// 标准带白圈的头像 生成器. 160px * 160px lineWidth : 6     bounds: 1 scale . so need * kscreenScale
+ (UIImage *)circleAvatarImage:(UIImage *)image WithBounds:(CGRect)aBounds WhiteLineWidth:(CGFloat)lineWidth{
//    UIGraphicsBeginImageContext(aBounds.size);
    UIGraphicsBeginImageContextWithOptions(aBounds.size, NO, [UIScreen mainScreen].scale);// ld fix with this.
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context,lineWidth); // 2
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextAddEllipseInRect(context, aBounds);
    CGContextClip(context);
//    CGContextSetFillColorWithColor(context, [aColor CGColor]);
    [image drawInRect:aBounds];
//    CGContextFillRect(context, aBounds);
    CGContextAddEllipseInRect(context, aBounds);
    CGContextStrokePath(context);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
    
}

+ (UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset {
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    //圆的边框宽度为2，颜色为白色
    CGContextSetLineWidth(context,4); // 2
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset *2.0f, image.size.height - inset *2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    //在圆区域内画出image原图
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    //生成新的image
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

/// 画一条虚线，根据参数的不同来定是竖虚线，还是横虚线。
+ (UIImage *)DashedLineImageWithLineWidth:(CGFloat)lineW LineHeight:(CGFloat)lineHeight Color:(UIColor*)color IsHorizontal:(BOOL)isH{
    if (isH) {
        CGSize lineSize =  CGSizeMake(lineW? lineW *2:10, lineHeight?lineHeight:2);
        UIGraphicsBeginImageContext(lineSize); //开始画线 划线的frame
        //设置线条终点形状
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        // 5是每个虚线的长度 1是高度.{5,1}
        CGFloat lengths[] = {lineW ? lineW:5,lineHeight? lineHeight:1};
        CGContextRef line = UIGraphicsGetCurrentContext();
        // 设置颜色
        CGContextSetStrokeColorWithColor(line, color.CGColor);
        CGContextSetLineDash(line, 0, lengths, lineHeight ? lineHeight:2); //画虚线
        CGContextMoveToPoint(line, 0.0, 0); //开始画线 2.0
        CGContextAddLineToPoint(line, lineW ? lineW: 5, 0);// 2. 10
        CGContextStrokePath(line);
        return UIGraphicsGetImageFromCurrentImageContext();
    }else{
        CGSize lineSize =  CGSizeMake( lineHeight?lineHeight:2, lineW? lineW *2:10);
        UIGraphicsBeginImageContext(lineSize); //开始画线 划线的frame
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGFloat lengths[] = {lineW ? lineW:5,lineHeight? lineHeight:2};
        CGContextRef line = UIGraphicsGetCurrentContext();
        // 设置颜色
        CGContextSetStrokeColorWithColor(line, color.CGColor);
        CGContextSetLineDash(line, 0, lengths, lineHeight ? lineHeight:2); //画虚线
        CGContextMoveToPoint(line, 0.0, 0);
        CGContextAddLineToPoint(line, 0, lineW ? lineW:5);
        CGContextStrokePath(line);
        return UIGraphicsGetImageFromCurrentImageContext(); // return image.
    }
}


#pragma mark - Property method


- (UIImage *)imageAtRect:(CGRect)rect {

    //获取UIImage图片对应的CGImageRef对象
    CGImageRef srcImage = [self CGImage];
    //从srcImage中挖取rect区域
    CGImageRef imageRef = CGImageCreateWithImageInRect(srcImage, rect);
    //将挖取到的CGImageRef转化为UIImage对象
    UIImage *subImage = [UIImage imageWithCGImage:imageRef];
    return subImage;

}

- (UIImage *)imageByScalingAspectToMinSize:(CGSize)targetSize {

    //获取源图片的宽和高
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    //获取图片缩放目标大小的宽和高
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    //定义图片缩放后的宽度
    CGFloat scaledWidth = targetWidth;
    //定义图片缩放后的高度
    CGFloat scaledHeight = targetHeight;
    CGPoint anchorPoint = CGPointZero;
    //如果源图片的大小于缩放的目标大小不相等
    if (!CGSizeEqualToSize(imageSize, targetSize)) {

        //计算水平方向上的缩放因子
        CGFloat xFactor = targetHeight/width;
        //计算垂直方向上的缩放因子
        CGFloat yFactor = targetHeight/height;
        //定义缩放因子scaleFactor为两个缩放因子中较大的一个
        CGFloat scaleFactor = xFactor>yFactor?xFactor:yFactor;
        //根据缩放因子计算图片缩放后的高度和宽度
        scaledWidth = width* scaleFactor;
        scaledHeight = height *scaleFactor;
        //如果横向上的缩放因子大于纵向上的缩放因子，那么图片在纵向上需要裁剪
        if (xFactor>yFactor) {
            anchorPoint.y = (targetHeight - scaledHeight)/2.0;
        }else if (xFactor < yFactor) {

            anchorPoint.x = (targetWidth - scaledWidth)/2.0;


        }

    }
    //开始绘图
    UIGraphicsBeginImageContext(targetSize);
    //定义图片缩放后的区域
    CGRect anchorRect = CGRectZero;
    anchorRect.origin = anchorPoint;
    anchorRect.size.width = scaledWidth;
    anchorRect.size.height = scaledHeight;
    //将图片本身绘制到anchorRect区域中
    [self drawInRect:anchorRect];

    //获取绘制后生成的新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (UIImage *)imageByScalingAspectToMaxSize:(CGSize)targetSize {

    //获取源图片的宽和高
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    //获取图片缩放目标大小的宽和高
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    //定义图片缩放后的宽度
    CGFloat scaledWidth = targetWidth;
    //定义图片缩放后的高度
    CGFloat scaledHeight = targetHeight;
    CGPoint anchorPoint = CGPointZero;
    //如果源图片的大小于缩放的目标大小不相等
    if (!CGSizeEqualToSize(imageSize, targetSize)) {

        //计算水平方向上的缩放因子
        CGFloat xFactor = targetHeight/width;
        //计算垂直方向上的缩放因子
        CGFloat yFactor = targetHeight/height;
        //定义缩放因子scaleFactor为两个缩放因子中较小的一个
        CGFloat scaleFactor = xFactor<yFactor?xFactor:yFactor;
        //根据缩放因子计算图片缩放后的高度和宽度
        scaledWidth = width* scaleFactor;
        scaledHeight = height *scaleFactor;
        //如果横向上的缩放因子小于纵向上的缩放因子，那么图片上下留空白
        if (xFactor<yFactor) {
            anchorPoint.y = (targetHeight - scaledHeight)/2.0;
        }else if (xFactor > yFactor) {

            anchorPoint.x = (targetWidth - scaledWidth)/2.0;


        }

    }
    //开始绘图
    UIGraphicsBeginImageContext(targetSize);
    //定义图片缩放后的区域
    CGRect anchorRect = CGRectZero;
    anchorRect.origin = anchorPoint;
    anchorRect.size.width = scaledWidth;
    anchorRect.size.height = scaledHeight;
    //将图片本身绘制到anchorRect区域中
    [self drawInRect:anchorRect];

    //获取绘制后生成的新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;

}
//不保持图片缩放比
- (UIImage *)imageByScalingToSize:(CGSize)targetSize {

    //开始绘图
    UIGraphicsBeginImageContext(targetSize);
    //定义图片缩放后的区域，无需保持纵横比，所以直接缩放
    CGRect anchorRect = CGRectZero;
    anchorRect.origin = CGPointZero;
    anchorRect.size = targetSize;
    [self drawInRect:anchorRect];
    //获取绘制后生成的新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;

}
//图片旋转角度
- (UIImage *)imageRotatedByRadians:(CGFloat)radians {

    //定义一个执行旋转的CGAffineTransform结构体
    CGAffineTransform t = CGAffineTransformMakeRotation(radians);
    //对图片的原始区域执行旋转，获取旋转后的区域
    CGRect rotateRect = CGRectApplyAffineTransform(CGRectMake(0, 0, self.size.width, self.size.height), t);
    //获取图片旋转后的大小
    CGSize rotatedSize = rotateRect.size;
    //创建绘制位图的上下文
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //指定坐标变换，将坐标中心平移到图片中心
    CGContextTranslateCTM(ctx, rotatedSize.width/2.0, rotatedSize.height/2.0);
    //执行坐标变换，旋转过radians弧度
    CGContextRotateCTM(ctx, radians);
    //执行坐标变换，执行缩放
    CGContextScaleCTM(ctx, 1.0, -1.0);
    //绘制图片
    CGContextDrawImage(ctx, CGRectMake(-self.size.width/2.0, -self.size.height/2.0, self.size.width, self.size.height), self.CGImage);
    //获取绘制后生成的新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;

}
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees {

    return [self imageRotatedByRadians:degrees*M_PI/180.0];
}
- (void)saveToDocuments:(NSString *)fileName {

    //获取当前应用路径中Documents目录下的指定文件名对应的文件路径

    NSString*path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:fileName];
    //保存PNG图片
    [UIImagePNGRepresentation(self) writeToFile:path atomically:YES];

}


/**
 从Image Sources中获取缩略图

 @param imageSize 缩略图的大小
 */
- (UIImage *)getThumbnailImageFrom:(NSString *)imageFileURL ImageSourceWithSize:(int)imageSize {
    
    CGImageRef thumbImage;
    CGImageSourceRef imageSource;
    CFDictionaryRef imageOption;
    
    
    CFStringRef imageKeys[3];
    CFTypeRef imageValues[3];
    
    
    //缩略图尺寸
    CFNumberRef thumbSize;
    
    
    imageSource = CGImageSourceCreateWithURL((CFURLRef)imageFileURL, NULL);
    if (imageSource == nil) {
        return nil;
    }
    
    
    //创建缩略图等比缩放大小，会根据长宽值比较大的作为imageSize进行缩放
    thumbSize = CFNumberCreate(NULL, kCFNumberIntType, &imageSize);
    
    
    imageKeys[0] = kCGImageSourceCreateThumbnailWithTransform;
    imageValues[0] = (CFTypeRef)kCFBooleanTrue;
    
    imageKeys[1] = kCGImageSourceCreateThumbnailFromImageIfAbsent;
    imageValues[1] = (CFTypeRef)kCFBooleanTrue;
  
    //缩放键值对
    imageKeys[2] = kCGImageSourceThumbnailMaxPixelSize;
    imageValues[2] = (CFTypeRef)thumbSize;
    
    
    imageOption = CFDictionaryCreate(NULL, (const void **) imageKeys,
                                      (const void **) imageValues, 3,
                                      &kCFTypeDictionaryKeyCallBacks,
                                      &kCFTypeDictionaryValueCallBacks);
    
    //获取缩略图
    thumbImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, imageOption);
    
    
    CFRelease(imageOption);
    CFRelease(imageSource);
    CFRelease(thumbSize);
    
    UIImage *imageResult = [UIImage imageWithCGImage:thumbImage];
    return imageResult;
    //显示缩略图
//    UIImage *imageResult = [UIImage imageWithCGImage:thumbImage];
//    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 300, 320, 200)];
//    [self.view addSubview:imageView];
//    imageView.image = imageResult;
    
    
    //将缩略图保存到本地，查看大小，目的查看缩略图的大小
//    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *imagePath=[[paths lastObject] stringByAppendingFormat:@"/test_thumb.jpg"];
//
//    [UIImageJPEGRepresentation(imageResult, 1) writeToFile:imagePath atomically:YES];
//
//    NSLog(@"imagePath  %@",imagePath);
    
    
}



/**
 从Image Sources中创建一个图像
 @param imageFileURL 图片的本地路径
 */
- (UIImage *)getImageFromImageSource:(NSString *)imageFileURL {
    
    CGImageRef cgimage;
    CGImageSourceRef imageSource;
    CFDictionaryRef imageOptions;
    
    
    
    //键值对，为创建 CFDictionaryRef 做准备
    CFStringRef imageKeys[2];
    CFTypeRef imageValues[2];
    
    //缓存
    imageKeys[0] = kCGImageSourceShouldCache;
    imageValues[0] = (CFTypeRef)kCFBooleanTrue;
    
    //float-point
    imageKeys[1] = kCGImageSourceShouldAllowFloat;
    imageValues[1] = (CFTypeRef)kCFBooleanTrue;
    
    
    //设置参数，为创建 CGImageSourceRef 对象做准备
    imageOptions = CFDictionaryCreate(NULL, (const void **)imageKeys, (const void **)imageValues, 2, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    
    
    //创建 CGImageSourceRef 对象，URL为图片的本地路径，imageOptions 为参数的设置
    imageSource = CGImageSourceCreateWithURL((CFURLRef)imageFileURL, (CFDictionaryRef)imageOptions);
    
    if (imageSource == nil) {
        return nil;
    }
    
    //从 CGImageSourceRef 中获取 CGImageRef 对象
    cgimage = CGImageSourceCreateImageAtIndex(imageSource, 0, NULL);
    
    
    CFRelease(imageOptions);
    CFRelease(imageSource);
    
    
    //从 CGImageRef 中获取 UIImage 对象
    UIImage *imageResult= [UIImage imageWithCGImage:cgimage];
    return imageResult;
    
//    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 320, 200)];
//    [self.view addSubview:imageView];
//    imageView.image = imageResult;

}

- (BOOL)containAlphaChannel{
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(self.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}

// --- 画水印
- (UIImage *) DrawWaterMark:(UIImage *)mark inRect:(CGRect)rect{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0)
    {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);//0.0
    }
    //原图
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    //水印图
    [mark drawInRect:rect];
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newPic;
}

/// 对图片尺寸进行压缩--
- (UIImage*)scaledToSize:(CGSize)targetSize{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat scaleFactor = 0.0;
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetSize.width / imageSize.width;
        CGFloat heightFactor = targetSize.height / imageSize.height;
        if (widthFactor < heightFactor)
            scaleFactor = heightFactor; // scale to fit height
        else
            scaleFactor = widthFactor; // scale to fit width
    }
    scaleFactor = MIN(scaleFactor, 1.0);
    CGFloat targetWidth = imageSize.width* scaleFactor;
    CGFloat targetHeight = imageSize.height* scaleFactor;
    
    targetSize = CGSizeMake(floorf(targetWidth), floorf(targetHeight));
    UIGraphicsBeginImageContext(targetSize); // this will crop
    [sourceImage drawInRect:CGRectMake(0, 0, ceilf(targetWidth), ceilf(targetHeight))];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        newImage = sourceImage;
    }
    UIGraphicsEndImageContext();
    return newImage;
}


- (UIImage*)scaledToSize:(CGSize)targetSize highQuality:(BOOL)highQuality{
    if (highQuality) {
        targetSize = CGSizeMake(2*targetSize.width, 2*targetSize.height);
    }
    return [self scaledToSize:targetSize];
}


- (UIImage*)FixOrientation{
    return [UIImage imageWithCGImage:self.CGImage scale:self.scale orientation:UIImageOrientationUp];
}



/*
 // 修正方向的另外一种方式。
 - (UIImage *)fixOrientationImage {
     
     // No-op if the orientation is already correct
     if (self.imageOrientation == UIImageOrientationUp) return self;
     
     // We need to calculate the proper transformation to make the image upright.
     // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
     CGAffineTransform transform = CGAffineTransformIdentity;
     
     switch (self.imageOrientation) {
         case UIImageOrientationDown:
         case UIImageOrientationDownMirrored:
             transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
             transform = CGAffineTransformRotate(transform, M_PI);
             break;
             
         case UIImageOrientationLeft:
         case UIImageOrientationLeftMirrored:
             transform = CGAffineTransformTranslate(transform, self.size.width, 0);
             transform = CGAffineTransformRotate(transform, M_PI_2);
             break;
             
         case UIImageOrientationRight:
         case UIImageOrientationRightMirrored:
             transform = CGAffineTransformTranslate(transform, 0, self.size.height);
             transform = CGAffineTransformRotate(transform, -M_PI_2);
             break;
         case UIImageOrientationUp:
         case UIImageOrientationUpMirrored:
             break;
     }
     
     switch (self.imageOrientation) {
         case UIImageOrientationUpMirrored:
         case UIImageOrientationDownMirrored:
             transform = CGAffineTransformTranslate(transform, self.size.width, 0);
             transform = CGAffineTransformScale(transform, -1, 1);
             break;
             
         case UIImageOrientationLeftMirrored:
         case UIImageOrientationRightMirrored:
             transform = CGAffineTransformTranslate(transform, self.size.height, 0);
             transform = CGAffineTransformScale(transform, -1, 1);
             break;
         case UIImageOrientationUp:
         case UIImageOrientationDown:
         case UIImageOrientationLeft:
         case UIImageOrientationRight:
             break;
     }
     
     // Now we draw the underlying CGImage into a new context, applying the transform
     // calculated above.
     CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                              CGImageGetBitsPerComponent(self.CGImage), 0,
                                              CGImageGetColorSpace(self.CGImage),
                                              CGImageGetBitmapInfo(self.CGImage));
     CGContextConcatCTM(ctx, transform);
     switch (self.imageOrientation) {
         case UIImageOrientationLeft:
         case UIImageOrientationLeftMirrored:
         case UIImageOrientationRight:
         case UIImageOrientationRightMirrored:
             // Grr...
             CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
             break;
             
         default:
             CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
             break;
     }
     
     // And now we just create a new UIImage from the drawing context
     CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
     UIImage *img = [UIImage imageWithCGImage:cgimg];
     CGContextRelease(ctx);
     CGImageRelease(cgimg);
     return img;
 }
 
 */


#pragma mark - Image Effect

// Helper function to add tint and mask.
- (UIImage *)_yy_mergeImageRef:(CGImageRef)effectCGImage
                     tintColor:(UIColor *)tintColor
                 tintBlendMode:(CGBlendMode)tintBlendMode
                     maskImage:(UIImage *)maskImage
                        opaque:(BOOL)opaque {
    BOOL hasTint = tintColor != nil && CGColorGetAlpha(tintColor.CGColor) > __FLT_EPSILON__;
    BOOL hasMask = maskImage != nil;
    CGSize size = self.size;
    CGRect rect = { CGPointZero, size };
    CGFloat scale = self.scale;
    
    if (!hasTint && !hasMask) {
        return [UIImage imageWithCGImage:effectCGImage];
    }
    
    UIGraphicsBeginImageContextWithOptions(size, opaque, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0, -size.height);
    if (hasMask) {
        CGContextDrawImage(context, rect, self.CGImage);
        CGContextSaveGState(context);
        CGContextClipToMask(context, rect, maskImage.CGImage);
    }
    CGContextDrawImage(context, rect, effectCGImage);
    if (hasTint) {
        CGContextSaveGState(context);
        CGContextSetBlendMode(context, tintBlendMode);
        CGContextSetFillColorWithColor(context, tintColor.CGColor);
        CGContextFillRect(context, rect);
        CGContextRestoreGState(context);
    }
    if (hasMask) {
        CGContextRestoreGState(context);
    }
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}

- (UIImage *)imageByTintColor:(UIColor *)color {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    [color set];
    UIRectFill(rect);
    [self drawAtPoint:CGPointMake(0, 0) blendMode:kCGBlendModeDestinationIn alpha:1];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)imageByGrayscale {
    return [self imageByBlurRadius:0 tintColor:nil tintMode:0 saturation:0 maskImage:nil];
}

- (UIImage *)imageByBlurSoft {
    return [self imageByBlurRadius:60 tintColor:[UIColor colorWithWhite:0.84 alpha:0.36] tintMode:kCGBlendModeNormal saturation:1.8 maskImage:nil];
}

- (UIImage *)imageByBlurLight {
    return [self imageByBlurRadius:60 tintColor:[UIColor colorWithWhite:1.0 alpha:0.3] tintMode:kCGBlendModeNormal saturation:1.8 maskImage:nil];
}

- (UIImage *)imageByBlurExtraLight {
    return [self imageByBlurRadius:40 tintColor:[UIColor colorWithWhite:0.97 alpha:0.82] tintMode:kCGBlendModeNormal saturation:1.8 maskImage:nil];
}

- (UIImage *)imageByBlurDark {
    return [self imageByBlurRadius:40 tintColor:[UIColor colorWithWhite:0.11 alpha:0.73] tintMode:kCGBlendModeNormal saturation:1.8 maskImage:nil];
}

- (UIImage *)imageByBlurWithTint:(UIColor *)tintColor {
    const CGFloat EffectColorAlpha = 0.6;
    UIColor *effectColor = tintColor;
    size_t componentCount = CGColorGetNumberOfComponents(tintColor.CGColor);
    if (componentCount == 2) {
        CGFloat b;
        if ([tintColor getWhite:&b alpha:NULL]) {
            effectColor = [UIColor colorWithWhite:b alpha:EffectColorAlpha];
        }
    } else {
        CGFloat r, g, b;
        if ([tintColor getRed:&r green:&g blue:&b alpha:NULL]) {
            effectColor = [UIColor colorWithRed:r green:g blue:b alpha:EffectColorAlpha];
        }
    }
    return [self imageByBlurRadius:20 tintColor:effectColor tintMode:kCGBlendModeNormal saturation:-1.0 maskImage:nil];
}

- (UIImage *)imageByBlurRadius:(CGFloat)blurRadius
                     tintColor:(UIColor *)tintColor
                      tintMode:(CGBlendMode)tintBlendMode
                    saturation:(CGFloat)saturation
                     maskImage:(UIImage *)maskImage {
    if (self.size.width < 1 || self.size.height < 1) {
        NSLog(@"UIImage+YYAdd error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", self.size.width, self.size.height, self);
        return nil;
    }
    if (!self.CGImage) {
        NSLog(@"UIImage+YYAdd error: inputImage must be backed by a CGImage: %@", self);
        return nil;
    }
    if (maskImage && !maskImage.CGImage) {
        NSLog(@"UIImage+YYAdd error: effectMaskImage must be backed by a CGImage: %@", maskImage);
        return nil;
    }
    
    // iOS7 and above can use new func.
    BOOL hasNewFunc = (long)vImageBuffer_InitWithCGImage != 0 && (long)vImageCreateCGImageFromBuffer != 0;
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturation = fabs(saturation - 1.0) > __FLT_EPSILON__;
    
    CGSize size = self.size;
    CGRect rect = { CGPointZero, size };
    CGFloat scale = self.scale;
    CGImageRef imageRef = self.CGImage;
    BOOL opaque = NO;
    
    if (!hasBlur && !hasSaturation) {
        return [self _yy_mergeImageRef:imageRef tintColor:tintColor tintBlendMode:tintBlendMode maskImage:maskImage opaque:opaque];
    }
    
    vImage_Buffer effect = { 0 }, scratch = { 0 };
    vImage_Buffer *input = NULL, *output = NULL;
    
    vImage_CGImageFormat format = {
        .bitsPerComponent = 8,
        .bitsPerPixel = 32,
        .colorSpace = NULL,
        .bitmapInfo = kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little, //requests a BGRA buffer.
        .version = 0,
        .decode = NULL,
        .renderingIntent = kCGRenderingIntentDefault
    };
    
    if (hasNewFunc) {
        vImage_Error err;
        err = vImageBuffer_InitWithCGImage(&effect, &format, NULL, imageRef, kvImagePrintDiagnosticsToConsole);
        if (err != kvImageNoError) {
            NSLog(@"UIImage+YYAdd error: vImageBuffer_InitWithCGImage returned error code %zi for inputImage: %@", err, self);
            return nil;
        }
        err = vImageBuffer_Init(&scratch, effect.height, effect.width, format.bitsPerPixel, kvImageNoFlags);
        if (err != kvImageNoError) {
            NSLog(@"UIImage+YYAdd error: vImageBuffer_Init returned error code %zi for inputImage: %@", err, self);
            return nil;
        }
    } else {
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale);
        CGContextRef effectCtx = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectCtx, 1.0, -1.0);
        CGContextTranslateCTM(effectCtx, 0, -size.height);
        CGContextDrawImage(effectCtx, rect, imageRef);
        effect.data     = CGBitmapContextGetData(effectCtx);
        effect.width    = CGBitmapContextGetWidth(effectCtx);
        effect.height   = CGBitmapContextGetHeight(effectCtx);
        effect.rowBytes = CGBitmapContextGetBytesPerRow(effectCtx);
        
        UIGraphicsBeginImageContextWithOptions(size, opaque, scale);
        CGContextRef scratchCtx = UIGraphicsGetCurrentContext();
        scratch.data     = CGBitmapContextGetData(scratchCtx);
        scratch.width    = CGBitmapContextGetWidth(scratchCtx);
        scratch.height   = CGBitmapContextGetHeight(scratchCtx);
        scratch.rowBytes = CGBitmapContextGetBytesPerRow(scratchCtx);
    }
    
    input = &effect;
    output = &scratch;
    
    if (hasBlur) {
        // A description of how to compute the box kernel width from the Gaussian
        // radius (aka standard deviation) appears in the SVG spec:
        // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
        //
        // For larger values of 's' (s >= 2.0), an approximation can be used: Three
        // successive box-blurs build a piece-wise quadratic convolution kernel, which
        // approximates the Gaussian kernel to within roughly 3%.
        //
        // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
        //
        // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
        //
        CGFloat inputRadius = blurRadius * scale;
        if (inputRadius - 2.0 < __FLT_EPSILON__) inputRadius = 2.0;
        uint32_t radius = floor((inputRadius * 3.0 * sqrt(2 * M_PI) / 4 + 0.5) / 2);
        radius |= 1; // force radius to be odd so that the three box-blur methodology works.
        int iterations;
        if (blurRadius * scale < 0.5) iterations = 1;
        else if (blurRadius * scale < 1.5) iterations = 2;
        else iterations = 3;
        NSInteger tempSize = vImageBoxConvolve_ARGB8888(input, output, NULL, 0, 0, radius, radius, NULL, kvImageGetTempBufferSize | kvImageEdgeExtend);
        void *temp = malloc(tempSize);
        for (int i = 0; i < iterations; i++) {
            vImageBoxConvolve_ARGB8888(input, output, temp, 0, 0, radius, radius, NULL, kvImageEdgeExtend);
            YY_SWAP(input, output);
        }
        free(temp);
    }
    
    
    if (hasSaturation) {
        // These values appear in the W3C Filter Effects spec:
        // https://dvcs.w3.org/hg/FXTF/raw-file/default/filters/Publish.html#grayscaleEquivalent
        CGFloat s = saturation;
        CGFloat matrixFloat[] = {
            0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
            0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
            0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
            0,                    0,                    0,                    1,
        };
        const int32_t divisor = 256;
        NSUInteger matrixSize = sizeof(matrixFloat) / sizeof(matrixFloat[0]);
        int16_t matrix[matrixSize];
        for (NSUInteger i = 0; i < matrixSize; ++i) {
            matrix[i] = (int16_t)roundf(matrixFloat[i] * divisor);
        }
        vImageMatrixMultiply_ARGB8888(input, output, matrix, divisor, NULL, NULL, kvImageNoFlags);
        YY_SWAP(input, output);
    }
    
    UIImage *outputImage = nil;
    if (hasNewFunc) {
        CGImageRef effectCGImage = NULL;
        effectCGImage = vImageCreateCGImageFromBuffer(input, &format, &_yy_cleanupBuffer, NULL, kvImageNoAllocate, NULL);
        if (effectCGImage == NULL) {
            effectCGImage = vImageCreateCGImageFromBuffer(input, &format, NULL, NULL, kvImageNoFlags, NULL);
            free(input->data);
        }
        free(output->data);
        outputImage = [self _yy_mergeImageRef:effectCGImage tintColor:tintColor tintBlendMode:tintBlendMode maskImage:maskImage opaque:opaque];
        CGImageRelease(effectCGImage);
    } else {
        CGImageRef effectCGImage;
        UIImage *effectImage;
        if (input != &effect) effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        if (input == &effect) effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        effectCGImage = effectImage.CGImage;
        outputImage = [self _yy_mergeImageRef:effectCGImage tintColor:tintColor tintBlendMode:tintBlendMode maskImage:maskImage opaque:opaque];
    }
    return outputImage;
}

// Helper function to handle deferred cleanup of a buffer.
static void _yy_cleanupBuffer(void *userData, void *buf_data) {
    free(buf_data);
}

@end
