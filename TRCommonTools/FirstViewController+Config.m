//
//  FirstViewController+Config.m
//  TRCommonTools
//
//  Created by book on 2018/7/16.
//  Copyright © 2018年 Tracky. All rights reserved.
//

#import "FirstViewController+Config.h"
#import <objc/runtime.h>

@implementation FirstViewController (Config)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzMethod];
        
        [self otherswizzMethod];
    });
}

+ (void)swizzMethod{
    
    SEL originSel = @selector(configFirstPage);
    SEL swizzSel = @selector(swizzConfigFirstPage1);
    
    Method originMethod = class_getInstanceMethod([self class], originSel);
    Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
    
    BOOL didAddMethod = class_addMethod([self class], originSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    
    if (didAddMethod) {
        class_replaceMethod([self class], swizzSel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
    }else{
        method_exchangeImplementations(originMethod, swizzMethod);
    }
    
}

- (void)swizzConfigFirstPage1{
    NSLog(@"swizzConfigFirstPage1 876543");

}

+ (void)otherswizzMethod{
    
    SEL originSel = @selector(configFirstPage);
    SEL swizzSel = @selector(swizzConfigFirstPage2);
    
    Method originMethod = class_getInstanceMethod([self class], originSel);
    Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
    
    BOOL didAddMethod = class_addMethod([self class], originSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    
    if (didAddMethod) {
        class_replaceMethod([self class], swizzSel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
    }else{
        method_exchangeImplementations(originMethod, swizzMethod);
    }
    
}

- (void)swizzConfigFirstPage2{
    NSLog(@"swizzConfigFirstPage2 23456789");
}

@end
