//
//  UIView+LYU.h
//  LYUPods
//
//  Created by donglyu on 2020/2/20.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LYU)


@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;


- (UIView *)FindFirstResponder;

/** 找到view对应的viewController. */
- (UIViewController *)FindBelongViewController;

@end

NS_ASSUME_NONNULL_END
