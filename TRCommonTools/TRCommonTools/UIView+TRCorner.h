//
//  UIView+TRCorner.h
//  YomoProject
//
//  Created by Tracky on 2016/4/25.
//  Copyright © 2018年 Tracky. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  @author Tracky
 *
 *  @brief 这个分类用来为各种UIView及其子类添加圆角,圆角的位置可以自由设置
 *  @since v0.1.0
 */
@interface UIView (TRCorner)

/*! 圆角半径 默认为 6*/
@property (nonatomic,assign)CGFloat tr_cornerRadius;

/**
 *  @author Tracky
 *
 *  @brief 为视图添加圆角
 *  @param postion 要添加的圆角位置，可通过位或运算自定义圆角
 *  @since v0.1.0
 */
- (void)tr_addCornerAtPostion:(UIRectCorner)postion;
@end
