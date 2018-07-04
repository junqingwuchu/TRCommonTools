//
//  UIView+TRCorner.m
//  YomoProject
//
//  Created by Tracky on 2016/4/25.
//  Copyright © 2018年 Tracky. All rights reserved.
//

#import "UIView+TRCorner.h"
#import <objc/runtime.h>

@implementation UIView (TRCorner)

- (CGFloat)tr_cornerRadius{
    NSNumber *number = objc_getAssociatedObject(self, @selector(tr_cornerRadius));
    return [number floatValue];
}

- (void)setTr_cornerRadius:(CGFloat)tr_cornerRadius{
    objc_setAssociatedObject(self, @selector(tr_cornerRadius), @(tr_cornerRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)tr_addCornerAtPostion:(UIRectCorner)postion{
    [self layoutIfNeeded];
    CGFloat radius = (self.tr_cornerRadius > 0) ? self.tr_cornerRadius : 6.f;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:postion cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    [self.layer setMasksToBounds:YES];
}
@end
