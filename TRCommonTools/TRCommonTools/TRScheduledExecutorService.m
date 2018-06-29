//
//  TRScheduledExecutorService.m
//  TRTestDemo
//
//  Created by Tracky on 2018/6/28.
//  Copyright © 2018年 Tracky. All rights reserved.
//

#import "TRScheduledExecutorService.h"

@implementation TRScheduledExecutorService

+ (TRScheduledTask *)executeTaskWithName:(NSString *)name
                                 withObj:(id)obj
                              afterDelay:(NSTimeInterval)scheduledTime
                                isRepeat:(BOOL)repeat
                               taskBlock:(void (^)(id obj))taskBlock {
    TRScheduledTask *task = [[TRScheduledTask alloc]init];
    task.name = name;
    task.taskBlock = [taskBlock copy];
    task.obj = obj;
    task.scheduledTime = scheduledTime;
    task.repeat = repeat;
    task.delay = scheduledTime;
    [task start];
    return task;
}

+ (BOOL)invalidTask:(TRScheduledTask *)task {
    task.repeat = NO;
    return [task invadil];
}
@end
