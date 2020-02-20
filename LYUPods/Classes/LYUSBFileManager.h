//
//  LYUSBFileManager.h
//  LYUPods
//
//  Created by donglyu on 2020/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYUSBFileManager : NSObject

+ (LYUSBFileManager *)shared;

+ (NSString*)documentPath;

/** real ~/Library/Caches */
+ (NSString*)cachePath;

+ (NSString *)libraryPath;

+ (NSString*)tmpPath;


#pragma mark - file operations.

+ (BOOL)CreateFolder:(NSString *)path;
+ (BOOL)CreateFolderByURL:(NSURL *)url;

+ (BOOL)MoveFileAtPath:(NSString*)sourcePath toPath:(nonnull NSString *)dstPath;

+ (BOOL)RemoveFileForPath:(NSString *)filepath;
+ (BOOL)RemoveDirForPath:(NSString *)dirPath ;
+ (BOOL)EmptyAllFilesInDir:(NSString *)dir;
#pragma mark - calcalate size

/** size in kb. get show */
+ (long) CalcFileSizeInKBAtPath:(NSString *) filePath;
+ (long) CalcFolderSizeAtPath:(NSString *) folderPath;

/** return 3.3M like. */
+ (NSString *)CalcSizeToTextShowWithoutDecimalWithSize:(long)capacityInKB;


#pragma mark - other

+ (NSArray *)GetAllFilePathsInDir:(NSString *)dirPath;
+ (NSMutableArray *)GetAllFilesRecursivelyInDir:(NSString *) dirpath;

@end

NS_ASSUME_NONNULL_END
