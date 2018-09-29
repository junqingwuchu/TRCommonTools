//
//  TestClass.m
//  TRCommonTools
//
//  Created by Tracky on 2018/8/1.
//  Copyright © 2018年 Tracky. All rights reserved.
//

#import "TestClass.h"

@interface TestClass ()

@property (nonatomic, copy)NSString *str;

@property (nonatomic, class)NSString * strstr;

@end

@implementation TestClass

+ (void)initialize{

    if (self == [TestClass class]) {
        NSLog(@"TestClass---- %@", [self class]);
    }else{
        NSLog(@"我的subClass被调用...");
    }
}


+ (void)ertyu{
    
    self.strstr = @"gfdk";
}

+ (NSString *)strstr{
    static NSString *strstr = @"tyuy";

    return strstr;
}

+ (void)setStrstr:(NSString *)strstr{
    strstr = strstr;
}
@end
