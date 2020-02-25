//
//  UITextField+LYU.h
//  LYUPods
//
//  Created by donglyu on 2020/2/25.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (LYU)

/**
 Set all text selected.
 */
- (void)selectAllText;

/**
 Set text in range selected.
 
 @param range  The range of selected text in a document.
 */
- (void)setSelectedRange:(NSRange)range;

@end

NS_ASSUME_NONNULL_END
