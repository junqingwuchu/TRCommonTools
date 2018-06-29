//
//  TRScheduledTask.m
//  TRTestDemo
//
//  Created by Tracky on 2018/6/28.
//  Copyright © 2018年 Tracky. All rights reserved.
//

#import "TRScheduledTask.h"
#import "TRMacroDefine.h"

@interface TRScheduledTask()
{
    UInt64  _exculteCount;
}
@end

@implementation TRScheduledTask

- (void)dealloc {
    TRLog(@"任务名字：%@ - dealloc",self.name);
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

-(void) start {
    [self performSelector:@selector(run) withObject:nil afterDelay:self.delay];
}

- (void)run {
    //放前面延时定义会更准确
    if (self.repeat) {
        [self start];
    }
    if (self.taskBlock) {
        TRLog(@"【任务开始执行】任务名字:%@",self.name);
        double current = CFAbsoluteTimeGetCurrent();
        self.taskBlock(self.obj);
        TRLog(@"【任务执行完毕】任务名字:%@-执行时间:%lf s",self.name,CFAbsoluteTimeGetCurrent()-current);
        _exculteCount ++;
    }
}

- (BOOL)invadil {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    TRLog(@"任务名字：%@被取消，执行次数：%llu",self.name,_exculteCount);
    _exculteCount = 0;
    return YES;
}

@end
