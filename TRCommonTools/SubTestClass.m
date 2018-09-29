//
//  SubTestClass.m
//  TRCommonTools
//
//  Created by Tracky on 2018/8/3.
//  Copyright © 2018年 Tracky. All rights reserved.
//

#import "SubTestClass.h"

@implementation SubTestClass


+ (void)initialize{
    if (self == [SubTestClass class]) {
        NSLog(@"SubTestClass---- %@", [self class]);

    }else{
        NSLog(@"我的分类被调用...");

    }
}

@end
