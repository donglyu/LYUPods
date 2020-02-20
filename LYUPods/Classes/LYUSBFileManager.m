//
//  LYUSBFileManager.m
//  LYUPods
//
//  Created by donglyu on 2020/2/20.
//

#import "LYUSBFileManager.h"
#import "LYUCommonMacro.h"

@interface LYUSBFileManager()


@end

@implementation LYUSBFileManager

+ (LYUSBFileManager *)shared {
    static LYUSBFileManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[LYUSBFileManager alloc] init];
    });
    return _sharedManager;
}

+ (NSString*)documentPath{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

+ (NSString*)cachePath{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}

+ (NSString *)libraryPath{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
}

+ (NSString *)tmpPath{
    return NSTemporaryDirectory();
}

+ (BOOL)CreateFolder:(NSString *)path{
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    BOOL isCreated = NO;
    if (!(isDir == YES && existed == YES)){
        NSError *error;
        isCreated = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"create dir error:%@", error.localizedDescription);
            // [Hud ShowPureTip:error.localizedDescription];
        }
    }else{
        isCreated = YES;
    }
    // create successfully
    return isCreated;
}

+ (BOOL)CreateFolderByURL:(NSURL *)url{
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:url.path isDirectory:&isDir];
    
    BOOL isCreated = NO;
    if (!(isDir == YES && existed == YES)){
        NSError *error;
        isCreated = [fileManager createDirectoryAtURL:url withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"create dir error:%@", error.localizedDescription);
            //[Hud ShowPureTip:error.localizedDescription];
        }
    }else{
        if (existed) {
            //[Hud ShowPureTip:@"文件夹已存在"];
            NSLog(@"文件夹已存在");
            isCreated = NO;
        }else{
            isCreated = YES;
        }
        
    }
    return isCreated;
}


+ (BOOL)MoveFileAtPath:(NSString*)sourcePath toPath:(nonnull NSString *)dstPath{
    if ([[NSFileManager defaultManager] fileExistsAtPath:sourcePath]) {
        NSError *error;
        [[NSFileManager defaultManager] moveItemAtPath:sourcePath toPath:dstPath error:&error];
        if (error) {
            DLog(@"move item atpath%@ to %@ failed%@", sourcePath, dstPath, error.localizedDescription);
            return NO;
        }
        return YES;
    }
    DLog(@"file not exist");
    return NO;
}

+ (BOOL)RemoveFileForPath:(NSString *)filepath{
    BOOL isDir = NO;
    if ([[NSFileManager defaultManager] fileExistsAtPath:filepath isDirectory:&isDir]) {
        NSAssert(!isDir, @"remove should be file instead of dir!");
        if (!isDir) {
            NSError *error;
            BOOL result = [[NSFileManager defaultManager] removeItemAtPath:filepath error:&error];
            if (error) {
                NSLog(@"remove file error:%@", error);
            }
            return result;
        }
    }
    return NO;
}

+ (BOOL)RemoveDirForPath:(NSString *)dirPath {
    BOOL isDir = NO;
    if ([[NSFileManager defaultManager] fileExistsAtPath:dirPath isDirectory:&isDir]) {
        NSAssert(isDir, @"remove should be dir instead of file!");
        if (isDir) {
            NSError *error;
            BOOL result = [[NSFileManager defaultManager] removeItemAtPath:dirPath error:&error];
            if (error) {
                NSLog(@"remove dir error:%@", error);
            }
            return result;
        }
    }
    return NO;
}


+ (BOOL)EmptyAllFilesInDir:(NSString *)dir{
    
    NSString *dirPath = dir;
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:dirPath];
    NSString *fileName;
    NSError *error;
    while (fileName = [dirEnum nextObject]) {
        
        [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@", dirPath, fileName] error:&error];
        if (error) {
            NSLog(@"remove file error: %@", error.localizedDescription);
            //[Hud ShowPureTip:error.localizedDescription];
            error = nil;
        }
    }
    return YES;
}


#pragma mark - Text Calculate

+ (NSString*)CalcSizeToTextShowWithoutDecimalWithSize:(long)capacityInKB{
    int mb = 1024;// kb
    int gb = mb*1024;
    if (capacityInKB == 0) {
        return @"0KB";
    }
    if (capacityInKB >= gb) {
        NSString *show = [NSString stringWithFormat:@"%.1lfG", (double)capacityInKB /gb];
        return  [show containsString:@".0"] ? [show stringByReplacingOccurrencesOfString:@".0" withString:@""]:show;
    } else if (capacityInKB >= mb) {
        double f = (double) capacityInKB / mb;
        return [NSString stringWithFormat:f>100?@"%.0lfM":@"%.1lfM", f];
    } else {
        return [NSString stringWithFormat:@"%.0ldKB", capacityInKB];
    }
}

+ (long)CalcFolderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long folderSize = 0;// long long.
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self CalcFileSizeInKBAtPath:fileAbsolutePath];
    }
    return folderSize;
}


+ (long) CalcFileSizeInKBAtPath:(NSString*) filePath{
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        long size = [[manager attributesOfItemAtPath:filePath error:nil] fileSize]/1024.0;
        //        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize]/1024.0;
        return size;
    }
    return 0;
}


#pragma mark - action

/** 指定文件夹下的所有文件  */
+ (NSArray *)GetAllFilePathsInDir:(NSString *)dirPath{
    NSArray *files = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:dirPath error:nil];
    return files;
}


#pragma mark - private

/** 递归获取目标文件夹下定所有文件 recursively */
+ (NSMutableArray *)GetAllFilesRecursivelyInDir:(NSString *) dirpath {
    
    NSMutableArray *FilesArrayM = [NSMutableArray array];
    
    NSFileManager * fileManger = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isExist = [fileManger fileExistsAtPath:dirpath isDirectory:&isDir];
    if (isExist) {
        
        // way 1:
        if (isDir) {
            
            NSArray * dirArray = [fileManger contentsOfDirectoryAtPath:dirpath error:nil];
            NSString * subPath = nil;
            for (NSString * str in dirArray) {
                subPath  = [dirpath stringByAppendingPathComponent:str];
                BOOL issubDir = NO;
                [fileManger fileExistsAtPath:subPath isDirectory:&issubDir];
                
                if (issubDir) {//是子文件夹就递归添加
                    //                    [self GetAllFileWithPath:subPath];
                }else{
                    NSString *fileName = [[str componentsSeparatedByString:@"/"] lastObject];
                    DLog(@"%@", fileName);
                    [FilesArrayM addObject:fileName];
                }
            }
        }else{
            NSString *fileName = [[dirpath componentsSeparatedByString:@"/"] lastObject];
            DLog(@"%@", fileName);
            [FilesArrayM addObject:fileName];
        }
        
        // way 2:
        //        NSDirectoryEnumerator *enumerator;
        //        enumerator = [fileManger enumeratorAtPath:path];
        //
        //        while((path = [enumerator nextObject]) != nil) {
        //
        //            BOOL isDir = NO;
        //            [fileManger fileExistsAtPath:path isDirectory:&isDir];
        //            if (!isDir) { // 非文件夹才加.
        //                [self.lessons addObject:path];
        //
        //            }
        //        }
        
        // 进行名字的排序.
        FilesArrayM = [[NSMutableArray alloc]initWithArray:[FilesArrayM sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2 options:NSNumericSearch] == NSOrderedDescending;
        }]];
        
        return FilesArrayM;
    }else{
        NSLog(@"this path is not exist!");
        return nil;
    }
}


/*
其他记录
YYImageCache & SDImageCache clear cache.
+ (long)CSGetDiskTotalSize{
NSUInteger size1 = [SDImageCache sharedImageCache].totalDiskSize/1024.0;
NSUInteger size2 = [YYImageCache sharedCache].diskCache.totalCost/1024.0;

return size1 + size2;
}

+ (BOOL)CSDiskClearAllSize{
[[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
[[YYImageCache sharedCache].diskCache removeAllObjects];
return YES;
}

*/

@end
