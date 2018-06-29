//
//  TRAlertWindow.m
//  TRTestDemo
//
//  Created by Tracky on 2016/6/28.
//  Copyright © 2018年 Tracky. All rights reserved.
//

#import "TRAlertWindow.h"

@implementation TRAlertWindow

+ (instancetype)window {
    static TRAlertWindow *singletonAlertWindow = nil;
    static dispatch_once_t singletonAlertWindowToken;
    dispatch_once(&singletonAlertWindowToken, ^{
        singletonAlertWindow = [[TRAlertWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        singletonAlertWindow.windowLevel = CGFLOAT_MAX;
        
        UIViewController *rootVC = [[UIViewController alloc] init];
        singletonAlertWindow.rootViewController = rootVC;
    });
    return singletonAlertWindow;
}

+ (TRAlertWindow *)createWindow {
    TRAlertWindow *window = [[TRAlertWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.windowLevel = CGFLOAT_MAX;
    return window;
}
@end
