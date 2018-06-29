//
//  NSString+TRStringWidth.h
//  YomoProject
//
//  Created by Tracky on 2018/4/26.
//  Copyright © 2018年 Tracky. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSString (TRStringWidth)

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
                              text:(NSString *)text;

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
                               text:(NSString *)text;
@end
