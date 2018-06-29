//
//  TRAlertController.h
//  TRTestDemo
//
//  Created by Tracky on 2016/6/28.
//  Copyright © 2018年 Tracky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRAlertController : UIAlertController

+ (instancetype _Nonnull)initWithTitle:(NSString * __nullable)title
                               message:(NSString * __nullable)message
                             btn1Title:(NSString * __nullable)btn1Title
                            btn1Handle:(void (^ __nullable)(UIAlertAction * __nullable action))btn1Handle
                             btn2Title:(NSString * __nullable)btn2Title
                            btn2Handle:(void (^ __nullable)(UIAlertAction * __nullable action))btn2Handle;

- (void)showAlertVC;

// AlertVC是否正在显示
+ (BOOL)showing;
@end
