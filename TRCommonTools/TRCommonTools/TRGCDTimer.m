//
//  TRGCDTimer.m
//  TRCommonTools
//
//  Created by book on 2018/7/10.
//  Copyright © 2018年 Tracky. All rights reserved.
//

#import "TRGCDTimer.h"

@implementation TRGCDTimer


+ (dispatch_source_timer_t)tr_GCDStartTimerWithTimeInterval:(NSTimeInterval)interval repeat:(BOOL)repeat block:(void (^)(void))block{
    __block NSInteger tempCount = repeat ? NSIntegerMax : 1;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_timer_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, interval * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        if (tempCount <= 0) {
            dispatch_source_cancel(timer);
            if (block) {
                block();
            }
        }else{
            tempCount--;
        }
    });
    
    dispatch_resume(timer);
    
    return timer;
}

+ (void)tr_GCDCancelTimer:(dispatch_source_timer_t)timer{
    if (!timer) {
        return;
    }
    dispatch_source_cancel(timer);
}

@end
