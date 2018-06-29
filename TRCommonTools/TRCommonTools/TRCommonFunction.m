//
//  TRCommonFunction.m
//  TRTestDemo
//
//  Created by Tracky on 2016/6/13.
//  Copyright © 2016年 Tracky. All rights reserved.
//

#import "TRCommonFunction.h"


dispatch_queue_t ExecuteQueue(void) {
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("com.ExecuteQueue.TR", DISPATCH_QUEUE_SERIAL);
    });
    return queue;
}


dispatch_semaphore_t createSemaphore(long value) {
    static dispatch_semaphore_t semaphore;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        semaphore = dispatch_semaphore_create(value);
    });
    return semaphore;
}

void signalSemaphore(long value) {
    dispatch_semaphore_signal(createSemaphore(value));
}

long waitSemaphore(long value, dispatch_time_t timeOut) {
    return dispatch_semaphore_wait(createSemaphore(value), timeOut);
}


@implementation TRCommonFunction


+ (NSMutableDictionary<NSString *,dispatch_semaphore_t> *)semaphoreDictionary {
    static NSMutableDictionary<NSString *,dispatch_semaphore_t>  *instanceSemaphore;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instanceSemaphore = [[NSMutableDictionary<NSString *,dispatch_semaphore_t> alloc] init];
    });
    
    return instanceSemaphore;
}

+ (void)codeLockName:(NSString *)codeLockName codeFragment:(void(^)(void))codeFragment {
    if (codeLockName.length <= 0) {
        return;
    }
    
    NSString *lockNameKey = [NSString stringWithFormat:@"%zi",codeLockName.hash];
    
    NSMutableDictionary *semaphoreDict = [self semaphoreDictionary];
    dispatch_semaphore_t semaphore_t = semaphoreDict[lockNameKey];
    if (semaphore_t == nil) {
        semaphore_t = dispatch_semaphore_create(1);
        semaphoreDict[lockNameKey] = semaphore_t;
    }
    
    dispatch_semaphore_wait(semaphore_t, DISPATCH_TIME_FOREVER);
    
    if (codeFragment) {
        codeFragment();
    }
    
    dispatch_semaphore_signal(semaphore_t);
}



// 查询方法的顶层调用者
+ (NSString *)sourceCallMethod {
    NSArray *symbols = [NSThread callStackSymbols];
    NSInteger maxCount = symbols.count;
    NSString *secondSymbol;
    if (maxCount > 2) {
        secondSymbol = symbols[2];
    } else if (maxCount > 1) {
        secondSymbol = symbols[1];
    } else if ([[symbols firstObject] length]) {
        secondSymbol = [symbols firstObject];
    } else {
        return @"";
    }
    NSString *pattern = @"[+-]\\[.{0,}\\]";
    NSError *error;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:pattern options:kNilOptions error:&error];
    if (error) {
        NSLog(@"Error: %@", error);
        return @"";
    }
    NSTextCheckingResult *checkResult = [[regular matchesInString:secondSymbol options:NSMatchingReportCompletion range:NSMakeRange(0, secondSymbol.length)] lastObject];
    NSString *sourceString = [secondSymbol substringWithRange:checkResult.range];
    return sourceString ?: @"";
}
@end
