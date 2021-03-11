//
//  TRExceptionHandle.m
//  Runner
//
//  Created by 控客 on 2021/3/11.
//

#import "TRExceptionHandle.h"



@implementation TRExceptionHandle
static NSUncaughtExceptionHandler *tr_previousUncaughtExceptionHandle;


+ (void)openExceptionLog{
    
    installUncaughtExceptionHandle();
    
}

void installUncaughtExceptionHandle(void){
    tr_previousUncaughtExceptionHandle = NSGetUncaughtExceptionHandler();
    NSSetUncaughtExceptionHandler(&uncaughtHandleException);
}


void uncaughtHandleException(NSException *exception){
    
    //
    NSArray *stackArray = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSString *exceptionInfo = [NSString stringWithFormat:@"Exception reason:%@ \n name:%@ \n stackArray:%@", reason, name, stackArray];
    NSLog(@"%@", exceptionInfo);
    
    [[TRLogManager sharedInstance] logInfo:@"Runner" logStr:exceptionInfo];
    
    if (tr_previousUncaughtExceptionHandle) {
        tr_previousUncaughtExceptionHandle(exception);
    }
}



// Sign 信号捕捉
static struct signaction * g_previousSignalHandles = NULL;
static int g_fatalSignals[] = {
    SIGHUP,
    SIGINT,
    SIGQUIT,
    SIGABRT,
    SIGILL,
    SIGSEGV,
    SIGFPE,
    SIGBUS,
    SIGPIPE
};


static int g_fatalSignalsCount = (sizeof(g_fatalSignals) / sizeof(g_fatalSignals[0]));


const int * kssignal_fatalSignals(void){
    return g_fatalSignals;
}


int kssignal_numFatalSignals(void){
    return g_fatalSignalsCount;
}


void signalExceptionHandle(int signo, siginfo_t *info, void *uapVoid){
    
// void *frames[128];
// int i, len = backtrace(frames, 128);
    
// 堆栈信息
    
}

@end
