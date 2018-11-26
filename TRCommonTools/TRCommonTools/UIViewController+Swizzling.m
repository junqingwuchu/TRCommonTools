//
//  UIViewController+Swizzling.m
//  MajorProject
//
//  Created by Tracky on 2018/11/26.
//  Copyright © 2018年 HangZhou Major. All rights reserved.
//

#import "UIViewController+Swizzling.h"

@implementation UIViewController (Swizzling)

+ (void)load{
    
#ifdef DEBUG
    
    Method viewWillAppear = class_getInstanceMethod(self, @selector(viewWillAppear:));
    
    Method logViewWillAppear = class_getInstanceMethod(self, @selector(logViewWillAppear:));
    
    method_exchangeImplementations(viewWillAppear, logViewWillAppear);
    
#endif
    
}

- (void)logViewWillAppear:(BOOL)animated{
    
    NSString *className = NSStringFromClass([self class]);
    NSLog(@"控制器 %@ will appear", className);
    
    // 调用原来方法
    [self logViewWillAppear:animated];
}
@end
