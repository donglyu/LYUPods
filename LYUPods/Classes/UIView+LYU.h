//
//  UIView+LYU.h
//  LYUPods
//
//  Created by donglyu on 2020/2/20.
//
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
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

/**
 Create a snapshot image of the complete view hierarchy.
 */
- (nullable UIImage *)snapshotImage;

/**
 Create a snapshot image of the complete view hierarchy.
 @discussion It's faster than "snapshotImage", but may cause screen updates.
 See -[UIView drawViewHierarchyInRect:afterScreenUpdates:] for more information.
 */
- (nullable UIImage *)snapshotImageAfterScreenUpdates:(BOOL)afterUpdates;

/**
 Create a snapshot PDF of the complete view hierarchy.
 */
- (nullable NSData *)snapshotPDF;

/**
 Shortcut to set the view.layer's shadow
 
 @param color  Shadow Color
 @param offset Shadow offset
 @param radius Shadow radius
 */
- (void)setLayerShadow:(nullable UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius;

/**
 Remove all subviews.
 
 @warning Never call this method inside your view's drawRect: method.
 */
- (void)removeAllSubviews;



/**
 Converts a point from the receiver's coordinate system to that of the specified view or window.
 
 @param point A point specified in the local coordinate system (bounds) of the receiver.
 @param view  The view or window into whose coordinate system point is to be converted.
    If view is nil, this method instead converts to window base coordinates.
 @return The point converted to the coordinate system of view.
 */
- (CGPoint)convertPoint:(CGPoint)point toViewOrWindow:(nullable UIView *)view;

/**
 Converts a point from the coordinate system of a given view or window to that of the receiver.
 
 @param point A point specified in the local coordinate system (bounds) of view.
 @param view  The view or window with point in its coordinate system.
    If view is nil, this method instead converts from window base coordinates.
 @return The point converted to the local coordinate system (bounds) of the receiver.
 */
- (CGPoint)convertPoint:(CGPoint)point fromViewOrWindow:(nullable UIView *)view;

/**
 Converts a rectangle from the receiver's coordinate system to that of another view or window.
 
 @param rect A rectangle specified in the local coordinate system (bounds) of the receiver.
 @param view The view or window that is the target of the conversion operation. If view is nil, this method instead converts to window base coordinates.
 @return The converted rectangle.
 */
- (CGRect)convertRect:(CGRect)rect toViewOrWindow:(nullable UIView *)view;

/**
 Converts a rectangle from the coordinate system of another view or window to that of the receiver.
 
 @param rect A rectangle specified in the local coordinate system (bounds) of view.
 @param view The view or window with rect in its coordinate system.
    If view is nil, this method instead converts from window base coordinates.
 @return The converted rectangle.
 */
- (CGRect)convertRect:(CGRect)rect fromViewOrWindow:(nullable UIView *)view;

@end

NS_ASSUME_NONNULL_END
