//
//  UIView+TRGradient.m
//  TRTestDemo
//
//  Created by Tracky on 2017/6/14.
//  Copyright © 2018年 Tracky. All rights reserved.
//

#import "UIView+TRGradient.h"

@implementation UIView (TRGradient)

- (void)addGradientColorWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = self.bounds;
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

- (void)addObliqueGradientColorWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)startColor.CGColor, (__bridge id)endColor.CGColor];
    gradientLayer.startPoint = CGPointMake(0, 1.0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = self.bounds;
    [self.layer insertSublayer:gradientLayer atIndex:0];
}
@end
