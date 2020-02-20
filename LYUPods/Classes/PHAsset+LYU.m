//
//  PHAsset+LYU.m
//  LYUPods
//
//  Created by donglyu on 2020/2/20.
//

#import "PHAsset+LYU.h"


@implementation PHAsset (LYU)

- (long long)lyu_fileSize{
    PHAssetResource *resource = [[PHAssetResource assetResourcesForAsset:self] firstObject];
    long long size = [[resource valueForKey:@"fileSize"] longLongValue];
    return size;
}

- (NSString *)lyu_fileName{
    NSString *filename = [self valueForKey:@"filename"];
    return filename;
}


@end
