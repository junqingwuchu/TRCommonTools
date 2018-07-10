//
//  TRGCDTimer.h
//  TRCommonTools
//
//  Created by book on 2018/7/10.
//  Copyright © 2018年 Tracky. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef dispatch_source_t dispatch_source_timer_t;

@interface TRGCDTimer : NSObject

/**
 *  @author Tracky
 *
 *  @brief 创建并启动一个定时器 并返回该定时器实例
 */
+ (dispatch_source_timer_t)tr_GCDStartTimerWithTimeInterval:(NSTimeInterval)interval repeat:(BOOL)repeat block:(void (^)(void))block;

/**
 *  @author Tracky
 *
 *  @brief 停用并销毁定时器
 */
+ (void)tr_GCDCancelTimer:(dispatch_source_timer_t)timer;
@end
