//
//  TRFileManager.h
//  TRTestDemo
//
//  Created by Tracky on 2018/6/28.
//  Copyright © 2018年 Tracky. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TRFileManager : NSObject

/**
 * 返回根目录路径 "document"
 */
+ (NSString *)getDocumentPath;
/**
 * 返回 "document/dir/" 文件夹路径,没有则创建
 */
+ (NSString*)getDirectoryForDocuments:(NSString*) dir;
/**
 * 返回 "document/filename" 路径,没有则创建
 */
+ (NSString*)getFilePathForDocuments:(NSString*)filename;
/**
 * 返回 "document/dir/filename" 路径,没有则创建
 */
+ (NSString*)getFilePathForDocuments:(NSString *)filename inDir:(NSString*)dir;


/**
 * 返回根目录路径 "Library"
 */
+ (NSString *)getLibraryPath;
/**
 * 返回路径 "Library/Cache"
 */
+ (NSString *)getLibraryCachePath;
/**
 * 返回 "Library/dir"文件夹路径,没有则创建
 */
+ (NSString *)getDirectoryForLibrary:(NSString *)dir;
/**
 * 返回 "Library/fileName"路径,没有则创建
 */
+ (NSString *)getFilePathForLibrary:(NSString *)filename;
/**
 * 返回 "Library/dir/filename" 路径,没有则创建
 */
+ (NSString *)getFilePathForLibrary:(NSString *)filename inDir:(NSString *)dir;

/**
 * 返回 "Library/Cache/dir"路径,没有则创建
 */
+ (NSString *)getDirectoryForLibraryCache:(NSString *)dir;
/**
 * 返回 "Library/Cache/filename"路径,没有则创建
 */
+ (NSString *)getFilePathForLibraryCache:(NSString *)filename;
/**
 * 返回 "Library/Cache/dir/filename",没有则创建
 */
+ (NSString *)getFilePathForLibraryCache:(NSString *)filename inDir:(NSString *)dir;

/**
 * 文件是否存在
 */
+ (BOOL)isFileExists:(NSString*)filepath;
/**
 * 删除文件
 */
+ (BOOL)deleteWithFilepath:(NSString*)filepath;
/**
 * 移动文件
 */
+ (BOOL)moveWithFilePath:(NSString *)filePath toPath:(NSString *)dstPath;
/**
 * 拷贝文件
 */
+ (BOOL)copyWithFilePath:(NSString *)filePath toPath:(NSString *)dstPath;
/**
 * 返回该文件目录下 所有文件名
 */
+ (NSArray*)getFilenamesWithDir:(NSString*)dir;

/**
 * 检查字符串是否为空
 */
+(BOOL)checkStringIsEmpty:(NSString *)string;
/**
 * 创建目录dirPath
 */
+ (BOOL)createDir:(NSString *)dirPath;
/**
 * 创建文件
 */
+ (BOOL)createFile:(NSString *)filePath;

/**
 * 异步操作
 */
+ (void)asyncBlock:(void(^)(void))block;

/**
 * 计算单个文件的大小
 */
+ (float)fileSizeAtPath:(NSString*)filePath;

/**
 * 计算文件夹下文件的总大小
 */
+ (float)fileSizeForDir:(NSString*)path;
@end
