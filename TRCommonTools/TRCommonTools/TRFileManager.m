//
//  TRFileManager.m
//  TRTestDemo
//
//  Created by Tracky on 2018/6/28.
//  Copyright © 2018年 Tracky. All rights reserved.
//

#import "TRFileManager.h"
#import "TRMacroDefine.h"

@implementation TRFileManager

//返回根目录路径 "document"
+ (NSString *)getDocumentPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

//返回 "document/dir/" 文件夹路径,没有则创建
+ (NSString *)getDirectoryForDocuments:(NSString*) dir{
    NSString* dirPath = [[self getDocumentPath] stringByAppendingPathComponent:dir];
    [self createDir:dirPath];
    return dirPath;
}

//返回 "document/filename" 路径
+ (NSString*)getFilePathForDocuments:(NSString*)filename{
    return [[self getDocumentPath] stringByAppendingPathComponent:filename];
}

//返回 "document/dir/filename" 路径
+ (NSString*)getFilePathForDocuments:(NSString *)filename inDir:(NSString*)dir{
    return [[self getDirectoryForDocuments:dir] stringByAppendingPathComponent:filename];
}

//返回根目录路径 "Library"
+ (NSString *)getLibraryPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryDirectory = [paths objectAtIndex:0];
    return libraryDirectory;
}

//返回路径 "Library/Cache"
+ (NSString *)getLibraryCachePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDirectory = [paths objectAtIndex:0];
    return cachesDirectory;
}

//返回 "Library/dir/"文件夹路径,没有则创建
+ (NSString *)getDirectoryForLibrary:(NSString *)dir{
    NSString* dirPath = [[self getLibraryPath] stringByAppendingPathComponent:dir];
    [self createDir:dirPath];
    return dirPath;
}

//返回 "Library/fileName"路径
+ (NSString *)getFilePathForLibrary:(NSString *)filename{
    return [[self getLibraryPath] stringByAppendingPathComponent:filename];
}

//返回 "Library/dir/filename" 路径
+ (NSString *)getFilePathForLibrary:(NSString *)filename inDir:(NSString *)dir{
    return [[self getDirectoryForLibrary:dir] stringByAppendingPathComponent:filename];
}

//返回 "Library/Cache/dir"路径,没有则创建
+ (NSString *)getDirectoryForLibraryCache:(NSString *)dir{
    NSString* dirPath = [[self getLibraryCachePath] stringByAppendingPathComponent:dir];
    [self createDir:dirPath];
    return dirPath;
}

//返回 "Library/Cache/filename"路径
+ (NSString *)getFilePathForLibraryCache:(NSString *)filename{
    return [[self getLibraryCachePath] stringByAppendingPathComponent:filename];
}

//返回 "Library/Cache/dir/filename"
+ (NSString *)getFilePathForLibraryCache:(NSString *)filename inDir:(NSString *)dir{
    return  [[self getDirectoryForLibraryCache:dir] stringByAppendingPathComponent:filename];
}


//文件是否存在
+ (BOOL)isFileExists:(NSString*)filepath{
    return [[NSFileManager defaultManager] fileExistsAtPath:filepath];
}

//删除文件
+ (BOOL)deleteWithFilepath:(NSString*)filepath
{
    return [[NSFileManager defaultManager] removeItemAtPath:filepath error:nil];
}

//移动文件
+ (BOOL)moveWithFilePath:(NSString *)filePath toPath:(NSString *)dstPath{
    return [[NSFileManager defaultManager] moveItemAtPath:filePath toPath:dstPath error:nil];
}

//拷贝文件
+ (BOOL)copyWithFilePath:(NSString *)filePath toPath:(NSString *)dstPath{
    return [[NSFileManager defaultManager] copyItemAtPath:filePath toPath:dstPath error:nil];
}

//返回该文件目录下 所有文件名
+ (NSArray*)getFilenamesWithDir:(NSString*)dir{
    return [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dir error:nil];
}

+(BOOL)checkStringIsEmpty:(NSString *)string{
    if(string == nil)
    {
        return YES;
    }
    if([string isKindOfClass:[NSString class]] == NO)
    {
        return YES;
    }
    
    return [[self getTrimStringWithString:string] isEqualToString:@""];
}

+ (NSString *)getTrimStringWithString:(NSString *)string{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark --method
+ (BOOL)createDir:(NSString *)dirPath{
    BOOL creatingSuccess = NO;
    
    BOOL isDir = NO;
    BOOL isCreated = [[NSFileManager defaultManager] fileExistsAtPath:dirPath isDirectory:&isDir];
    if ( isCreated == NO || isDir == NO )
    {
        NSError* error = nil;
        BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error];
        if(success == NO) {
            TRLog(@"create dir error: %@",error.debugDescription);
        } else {
            creatingSuccess = YES;
        }
    }
    return creatingSuccess;
}

+ (BOOL)createFile:(NSString *)filePath {
    BOOL creatingSuccess = NO;
    
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if ( exists == NO)
    {
        NSError* error = nil;
        BOOL success = [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
        if(success == NO) {
            TRLog(@"create dir error: %@",error.debugDescription);
        } else {
            creatingSuccess = YES;
        }
    }
    return creatingSuccess;
}

+ (void)asyncBlock:(void(^)(void))block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),block);
}

+ (float)fileSizeAtPath:(NSString*)filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    long long folderSize = 0;
    if ([manager fileExistsAtPath:filePath]){
        folderSize = [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return folderSize/(1024.0*1024.0);
}

+ (float)fileSizeForDir:(NSString*)path
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    float size = 0;
    NSArray* array = [fileManager contentsOfDirectoryAtPath:path error:nil];
    for(int i = 0; i<[array count]; i++)
    {
        NSString *fullPath = [path stringByAppendingPathComponent:[array objectAtIndex:i]];
        
        BOOL isDir;
        if (!([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && isDir) )
        {
            NSDictionary *fileAttributeDic=[fileManager attributesOfItemAtPath:fullPath error:nil];
            size += fileAttributeDic.fileSize/ 1024.0/1024.0;
        }
        else
        {
            size +=  [self fileSizeForDir:fullPath];
        }
    }
    return size;
}

+ (NSString *)pathForLogWithFileName:(NSString *)fileName
{
    NSString *path = [TRFileManager getFilePathForDocuments:fileName];
    return path;
}
@end
