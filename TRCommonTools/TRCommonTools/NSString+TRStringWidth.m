//
//  NSString+TRStringWidth.m
//  YomoProject
//
//  Created by Tracky on 2018/4/26.
//  Copyright © 2018年 Tracky. All rights reserved.
//

#import "NSString+TRStringWidth.h"

@implementation NSString (TRStringWidth)

/*!
 *  @author Tracky,
 *
 *  @brief 宽度固定，计算字符串高度
 *
 *  @param width 固定的宽度
 *  @param font  字体
 *  @param text  字符串
 *
 *  @return 返回的大小
 */
+ (CGSize)stringSizeWithFixedWidth:(CGFloat)width
                              font:(UIFont *)font
                              text:(NSString *)text {
    return [NSString stringSizeWithFixedValue:width isWidthFix:YES font:font text:text];
}

/*!
 *  @author Tracky,
 *
 *  @brief 高度固定，计算字符串宽度
 *
 *  @param height 固定的高度
 *  @param font   字体
 *  @param text   字符串
 *
 *  @return 返回的大小
 */
+ (CGSize)stringSizeWithFixedHeight:(CGFloat)height
                               font:(UIFont *)font
                               text:(NSString *)text {
    return [NSString stringSizeWithFixedValue:height isWidthFix:NO font:font text:text];
}

/*!
 *  @author Tracky, 
 *
 *  @brief 根据某个固定值，计算字符串的特定长度
 *
 *  @param fixValue   固定值
 *  @param isWidthFix 固定值是否是宽度
 *  @param font       自体
 *  @param text       字符串
 *
 *  @return 返回大小
 */
+ (CGSize)stringSizeWithFixedValue:(CGFloat)fixValue
                        isWidthFix:(BOOL)isWidthFix
                              font:(UIFont *)font
                              text:(NSString *)text {
    
    CGFloat width = isWidthFix ? fixValue : 0;
    CGFloat height = isWidthFix ? 0 : fixValue;
    CGSize textSize;
    
    textSize = [text boundingRectWithSize:CGSizeMake(width, height)
                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                               attributes:@{NSFontAttributeName:font}
                                  context:nil].size;
    return textSize;
}

@end
