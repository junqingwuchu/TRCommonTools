//
//  TRScheduledExecutorService.h
//  TRTestDemo
//
//  Created by Tracky on 2018/6/28.
//  Copyright © 2018年 Tracky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRScheduledTask.h"

/**
 * 1、开启一个定时任务，不再需要管理NSTimer
 * 2、这个不是线程安全的，使用的时候开启定时任务和关闭定时任务，请在同一个线程中进行
 * 3、在主线程中执行不会卡界面
 */

@interface TRScheduledExecutorService : NSObject

/**
* 开启一个定时任务
*/
+ (TRScheduledTask *)executeTaskWithName:(NSString *)name
                                 withObj:(id)obj
                              afterDelay:(NSTimeInterval)scheduledTime
                                isRepeat:(BOOL)repeat
                               taskBlock:(void (^)(id obj))task;

/**
 * 关闭一个定时任务
 */
+ (BOOL)invalidTask:(TRScheduledTask *)task;
@end
