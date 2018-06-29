//
//  TRCommonFunction.h
//  TRTestDemo
//
//  Created by Tracky on 2016/6/13.
//  Copyright © 2016年 Tracky. All rights reserved.
//

#import <Foundation/Foundation.h>


FOUNDATION_EXTERN dispatch_time_t ExecuteQueu(void);

FOUNDATION_EXTERN dispatch_semaphore_t createSemaphore(long value);

FOUNDATION_EXTERN void signalSemaphore(long value);

FOUNDATION_EXTERN long waitSemaphore(long value, dispatch_time_t timeout);


@interface TRCommonFunction : NSObject

/**
 * 协同信号量控制（并发代码需要访问同一块代码控制时使用）
 */

/**
 * 锁定的代码块
 *
 * @param codeLockName 该代码控制片段名称（需严格遵照各模块自己的命名方式）
 * @param codeFragment 控制的代码片段
*/
+ (void)codeLockName:(NSString *)codeLockName codeFragment:(void(^)(void))codeFragment;


/**
 * 查询方法的顶层调用者
 *
 * @return 顶层调用方法
 */
+ (NSString *)sourceCallMethod;
@end
