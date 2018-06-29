//
//  TRScheduledTask.h
//  TRTestDemo
//
//  Created by Tracky on 2018/6/28.
//  Copyright © 2018年 Tracky. All rights reserved.
//

/**
 * 这个不是线程安全的，使用的时候开启定时任务和关闭定时任务，请在同一个线程中进行
 */

#import <Foundation/Foundation.h>

@interface TRScheduledTask : NSObject

/**
 * 任务名字
 */
@property (nonatomic,copy) NSString *name;

/**
 * 任务执行 obj:执行任务传递的参数
 */
@property (nonatomic,copy) void (^taskBlock)(id obj);

/**
 * 执行传递的参数
 */
@property (nonatomic) id obj;

/**
 * 任务定时执行时间
 */
@property (nonatomic,assign)NSTimeInterval scheduledTime;
@property (nonatomic,assign)NSTimeInterval delay;

/**
 * 任务是否重复执行
 */
@property (nonatomic,assign) BOOL repeat;

/**
 * 开始任务
 */
- (void)start;
/**
 * 取消任务
 */
- (BOOL)invadil;

@end
