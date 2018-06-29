//
//  UIView+TRGradient.h
//  TRTestDemo
//
//  Created by Tracky on 2017/6/14.
//  Copyright © 2018年 Tracky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TRGradient)

/*!
 *  @author Tracky
 *
 *  @brief 视图添加水平渐变色,从左到右渐变
 *  @param startColor   左侧开始颜色
 *  @param endColor     右侧结束颜色
 */
- (void)addGradientColorWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor;

/*!
 *  @author Tracky
 *
 *  @brief 视图添加斜渐变色,从左上角到右下角渐变
 *  @param startColor   左下角开始颜色
 *  @param endColor     右上角结束颜色
 */
- (void)addObliqueGradientColorWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor;
@end
