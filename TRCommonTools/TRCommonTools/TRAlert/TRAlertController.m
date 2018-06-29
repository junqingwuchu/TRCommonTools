//
//  TRAlertController.m
//  TRTestDemo
//
//  Created by Tracky on 2016/6/28.
//  Copyright © 2018年 Tracky. All rights reserved.
//

#import "TRAlertController.h"
#import "TRAlertWindow.h"


static BOOL kTRAlertShowing;

@interface TRAlertController ()

@property (nonatomic, strong) TRAlertWindow *window;

@end

@implementation TRAlertController


+ (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                    btn1Title:(NSString *)btn1Title
                   btn1Handle:(void (^ __nullable)(UIAlertAction *action))btn1Handle
                    btn2Title:(NSString *)btn2Title
                   btn2Handle:(void (^ __nullable)(UIAlertAction *action))btn2Handle {
    TRAlertController *alertVC = [TRAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (btn1Title) {
        UIAlertAction *btnAction = [UIAlertAction actionWithTitle:btn1Title style:UIAlertActionStyleDestructive handler:[self addAlertHandler:btn1Handle]];
        [alertVC addAction:btnAction];
    }
    
    if (btn2Title) {
        UIAlertAction *btnAction = [UIAlertAction actionWithTitle:btn2Title style:UIAlertActionStyleCancel handler:[self addAlertHandler:btn2Handle]];
        [alertVC addAction:btnAction];
    }
    
    return alertVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    kTRAlertShowing = NO;
    self.window.rootViewController = nil;
    self.window.hidden = YES;
    self.window = nil;
}

- (void)showAlertVC {
    kTRAlertShowing = YES;
    self.window = [TRAlertWindow createWindow];
    self.window.hidden = NO;
    self.window.rootViewController = [[UIViewController alloc] init];
    
    [self.window.rootViewController presentViewController:self animated:YES completion:nil];
}

+ (void(^)(id p))addAlertHandler:(void (^ __nullable)(UIAlertAction *action))handler {
    return (^(id p) {
        if (handler) {
            handler(nil);
        }
    });
}

+ (BOOL)showing {
    return kTRAlertShowing;
}

@end
