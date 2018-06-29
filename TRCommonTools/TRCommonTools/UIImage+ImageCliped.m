//
//  UIImage+ImageCliped.m
//  CHDSeatModule
//
//  Created by Tracky on 16/8/9.
//  Copyright © 2016年 Tracky. All rights reserved.
//

#import "UIImage+ImageCliped.h"

@implementation UIImage (ImageCliped)

+ (UIImage *)imageWithColor:(UIColor *)color toSize:(CGSize)targetSize {
    return [self imageWithColor:color toSize:targetSize cornerRadius:0];
}

+ (UIImage *)imageWithColor:(UIColor *)color toSize:(CGSize)targetSize cornerRadius:(CGFloat)cornerRadius {
    return [self imageWithColor:color
                        toSize:targetSize
                  cornerRadius:cornerRadius
               backgroundColor:[UIColor whiteColor]];
}

+ (UIImage *)imageWithColor:(UIColor *)color
                     toSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius
            backgroundColor:(UIColor *)backgroundColor {
    return [self imageWithColor:color
                         toSize:targetSize
                   cornerRadius:cornerRadius
                backgroundColor:backgroundColor
                    borderColor:nil
                    borderWidth:0];
}

+ (UIImage *)imageWithColor:(UIColor *)color
                     toSize:(CGSize)targetSize
               cornerRadius:(CGFloat)cornerRadius
            backgroundColor:(UIColor *)backgroundColor
                borderColor:(UIColor *)borderColor
                borderWidth:(CGFloat)borderWidth
{
    UIGraphicsBeginImageContextWithOptions(targetSize, cornerRadius == 0, [UIScreen mainScreen].scale);
    
    CGRect targetRect = (CGRect){0, 0, targetSize.width, targetSize.height};
    UIImage *finalImage = nil;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    if (cornerRadius == 0) {
        if (borderWidth > 0) {
            CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
            CGContextSetLineWidth(context, borderWidth);
            CGContextFillRect(context, targetRect);
            
            targetRect = CGRectMake(borderWidth / 2, borderWidth / 2, targetSize.width - borderWidth, targetSize.height - borderWidth);
            CGContextStrokeRect(context, targetRect);
        } else {
            CGContextFillRect(context, targetRect);
        }
    } else {
        targetRect = CGRectMake(borderWidth / 2, borderWidth / 2, targetSize.width - borderWidth, targetSize.height - borderWidth);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:targetRect
                                                   byRoundingCorners:UIRectCornerAllCorners
                                                         cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        CGContextAddPath(UIGraphicsGetCurrentContext(), path.CGPath);
        
        if (borderWidth > 0) {
            CGContextSetStrokeColorWithColor(context, borderColor.CGColor);
            CGContextSetLineWidth(context, borderWidth);
            CGContextDrawPath(context, kCGPathFillStroke);
        } else {
            CGContextDrawPath(context, kCGPathFill);
        }
    }
    
    finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return finalImage;
}


// 剪切圆角的方法
+ (UIImage *)imageWithRoundCorner:(UIImage *)sourceImage cornerRadius:(CGFloat)cornerRadius size:(CGSize)size{
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    CGRect bounds = CGRectMake(0, 0, size.width, size.height);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:cornerRadius];
    [path addClip];
    [sourceImage drawInRect:bounds];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)generateRoundedCornersWithImage:(UIImage *)image size:(CGSize)size radius:(CGFloat)radius
{
    if (!image)return nil;
    
    const CGFloat width = size.width;
    const CGFloat height = size.height;
    
    //    radius = MAX(5.f, radius);
    //    radius = MIN(10.f, radius);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 4 * width, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, width, height);
    CGContextBeginPath(context);
    addRoundRectToPath(context, rect, radius, image.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    UIImage * img = [UIImage imageWithCGImage: imageMasked];
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageMasked);
    
    return img;
}

/**
 *  给上下文添加圆角蒙版
 */
void addRoundRectToPath(CGContextRef context, CGRect rect, float radius, CGImageRef image)
{
    float width, height;
    if (radius == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    width = CGRectGetWidth(rect);
    height = CGRectGetHeight(rect);
    
    //裁剪路径
    CGContextMoveToPoint(context, width, height / 2);
    CGContextAddArcToPoint(context, width, height, width / 2, height, radius);
    CGContextAddArcToPoint(context, 0, height, 0, height / 2, radius);
    CGContextAddArcToPoint(context, 0, 0, width / 2, 0, radius);
    CGContextAddArcToPoint(context, width, 0, width, height / 2, radius);
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), image);
    CGContextRestoreGState(context);
}

@end
