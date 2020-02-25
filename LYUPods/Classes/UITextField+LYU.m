//
//  UITextField+LYU.m
//  LYUPods
//
//  Created by donglyu on 2020/2/25.
//

#import "UITextField+LYU.h"
#import "LYUCommonMacro.h"

YYSYNTH_DUMMY_CLASS(UITextField_LYU)

@implementation UITextField (LYU)


- (void)selectAllText {
    UITextRange *range = [self textRangeFromPosition:self.beginningOfDocument toPosition:self.endOfDocument];
    [self setSelectedTextRange:range];
}

- (void)setSelectedRange:(NSRange)range {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:NSMaxRange(range)];
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}

@end
