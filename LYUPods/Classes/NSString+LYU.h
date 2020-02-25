//
//  NSString+LYU.h
//  LYUPods
//
//  Created by donglyu on 2020/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LYU)



/// 编码
- (NSString*)encodeString;
/// 解码
- (NSString *)decodedString;

- (BOOL)isURL;

- (NSString *)md5String;

+ (NSString *)stringWithUUID;

- (NSString *)stringByTrim;

@end

NS_ASSUME_NONNULL_END
