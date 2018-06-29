//
//  TRAttributeDictionary.m
//  TRTestDemo
//
//  Created by Tracky on 2018/6/28.
//  Copyright © 2018年 Tracky. All rights reserved.
//

#import "TRAttributeDictionary.h"

@implementation TRAttributeDictionary

NSDictionary *xParagraphLineSpacingAttribute(CGFloat spacing){
    NSMutableParagraphStyle *paragraphStyle = [TRAttributeDictionary paragraphStyleWithlineSpacing:spacing];
    return @{NSParagraphStyleAttributeName:paragraphStyle};
}

NSDictionary *XFontAttribute(CGFloat font){
    return @{NSFontAttributeName:[UIFont systemFontOfSize:font]};
}

NSDictionary *xBoldFontAttribute(CGFloat font){
    return @{NSFontAttributeName:[UIFont boldSystemFontOfSize:font]};
}

NSDictionary *xColorAttribute(UIColor *color) {
    return @{NSForegroundColorAttributeName:color};
}

NSDictionary *xAttributeAdd(NSDictionary *att1,NSDictionary *att2,...){
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic addEntriesFromDictionary:att1];
    [dic addEntriesFromDictionary:att2];
    va_list args;
    va_start(args, att2);
    if (att2) {
        NSDictionary *otherAtt;
        while((otherAtt = va_arg(args, NSDictionary *))){
            [dic addEntriesFromDictionary:otherAtt];
        }
        va_end(args);
    }
    return dic;
}

+ (NSMutableParagraphStyle *)paragraphStyleWithlineSpacing:(CGFloat)lineSpacing {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    return paragraphStyle;
}
@end
