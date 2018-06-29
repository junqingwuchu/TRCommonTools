//
//  UIImage+ImageCliped.h
//  CHDSeatModule
//
//  Created by Tracky on 16/8/9.
//  Copyright © 2016年 Tracky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageCliped)

/**
 * 生成圆角图片
 *
 * @param sourceImage 图片
 * @param cornerRadius 圆角
 * @param size 尺寸
 * @return 图片
 */
+ (UIImage *)imageWithRoundCorner:(UIImage *)sourceImage cornerRadius:(CGFloat)cornerRadius size:(CGSize)size;

/**
 * 生成圆角图片
 *
 * @param image  图片
 * @param size   尺寸
 * @param radius 角度
 * @return 图片
 */
+ (UIImage *)generateRoundedCornersWithImage:(UIImage *)image size:(CGSize)size radius:(CGFloat)radius;



/**
 *	根据颜色生成矩形图片
 *	@param color		待生成的图片颜色
 *	@param targetSize	生成的图片大小
 *	@return 图片对象
 */
+ (UIImage *)imageWithColor:(UIColor *)color toSize:(CGSize)targetSize;

/**
 *	根据颜色生成带圆角的图片。当有圆角时，默认被裁剪的圆角部分的颜色为白色。
 *	@param color		待生成的图片颜色
 *	@param targetSize	生成的图片大小
 *	@param cornerRadius	圆角大小
 *	@return 图片对象
 */
+ (UIImage *)imageWithColor:(UIColor *)color toSize:(CGSize)targetSize cornerRadius:(CGFloat)cornerRadius;

/**
 *	根据颜色生成带圆角的图片
 *	@param color			待生成的图片颜色
 *	@param targetSize		生成的大小
 *	@param cornerRadius		圆角大小
 *	@param backgroundColor 当有圆角大小时，才需要到此参数。用于设置被裁剪的圆角部分的颜色。
 *	@return 带圆角的图片对象
 */
+ (UIImage *)imageWithColor:(UIColor *)color
                         toSize:(CGSize)targetSize
                   cornerRadius:(CGFloat)cornerRadius
                backgroundColor:(UIColor *)backgroundColor;

/**
 *	根据颜色生成带圆角带边框的图片
 *	@param color			待生成的图片颜色
 *	@param targetSize		生成的大小
 *	@param cornerRadius		圆角大小
 *	@param backgroundColor 当有圆角大小时，才需要到此参数。用于设置被裁剪的圆角部分的颜色。
 *	@return 带圆角的图片对象
 */
+ (UIImage *)imageWithColor:(UIColor *)color
                         toSize:(CGSize)targetSize
                   cornerRadius:(CGFloat)cornerRadius
                backgroundColor:(UIColor *)backgroundColor
                    borderColor:(UIColor *)borderColor
                    borderWidth:(CGFloat)borderWidth;

@end
