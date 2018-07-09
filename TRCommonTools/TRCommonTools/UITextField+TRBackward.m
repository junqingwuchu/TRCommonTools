//
//  UITextField+TRBackward.m
//  TRCommonTools
//
//  Created by Tracky on 2016/7/5.
//  Copyright © 2016年 Tracky. All rights reserved.
//

#import "UITextField+TRBackward.h"
#import <objc/runtime.h>

@implementation UITextField (TRBackward)

+ (void)load{
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"deleteBackward"));
    Method method2 = class_getInstanceMethod([self class], @selector(tr_backwardkeyTouch));
    method_exchangeImplementations(method1, method2);
}

- (void)tr_backwardkeyTouch{
    [self tr_backwardkeyTouch];
    
    if ([self.delegate respondsToSelector:@selector(textFieldDidBackwardKeyTouch:)]) {
        id<TRBackwardDelegate>delegate = (id<TRBackwardDelegate>)self.delegate;
        [delegate textFieldDidBackwardKeyTouch:self];
    }
}

@end
