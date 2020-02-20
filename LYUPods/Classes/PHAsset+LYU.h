//
//  PHAsset+LYU.h
//  LYUPods
//
//  Created by donglyu on 2020/2/20.
//
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface PHAsset (LYU)

- (long long)lyu_fileSize;

- (NSString *)lyu_fileName;
@end

NS_ASSUME_NONNULL_END
