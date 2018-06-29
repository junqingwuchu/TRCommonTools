//
//  TRAnimationHelper.h
//  TRTestDemo
//
//  Created by Tracky on 2017/6/14.
//  Copyright © 2018年 Tracky. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void(^TRAnimationCompleteBlock)(void);

@interface TRAnimationHelper : NSObject

/**
 * @brief 获得动画实例
 * @return 返回动画实例
 */
+ (instancetype)shareHelper;

/**
 * @brief 获得金币时动画,动画在当前window
 * @param fromPoint 动画开始坐标点
 * @param targetPoint 动画结束坐标点
 * @param completeBlock 动画完成回调
 */
- (void)arcAnimationFromPoint:(CGPoint)fromPoint
                      targetPoint:(CGPoint)targetPoint
                completeBlock:(TRAnimationCompleteBlock)completeBlock;

/**
 * @brief 获得金币时动画,动画在当前window
 * @param fromView 动画开始的视图,从该视图中心点
 * @param targeView 动画结束的视图,从该视图中心点
 * @param completeBlock 动画完成回调
 */
- (void)arcAnimationFromView:(UIView *)fromView
                   targeView:(UIView *)targeView
               completeBlock:(TRAnimationCompleteBlock)completeBlock;

/**
 * @brief 获得金币时动画
 * @param fromView 动画开始的视图,从该视图中心点
 * @param targeView 动画结束的视图,从该视图中心点
 * @param inView 动画所在的视图
 * @param completeBlock 动画完成回调
 */
- (void)arcAnimationFromView:(UIView *)fromView
                   targeView:(UIView *)targeView
                      inView:(UIView *)inView
               completeBlock:(TRAnimationCompleteBlock)completeBlock;

/**
 * @brief 快速点击播放器点赞动画
 */
- (void)showZanAnimationWithTouch:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

/**
 展示关注按钮点击动画
 
 @param animationBtn 专注按钮
 @param imageName 关注后的图片
 */
- (void)showAttentionSelectedAnimationBtn:(UIButton *)animationBtn imageName:(NSString *)imageName;

/**
 点击赞小红心动画
 
 @param animationBtn 动画按钮
 @param imageName 点赞选中图片
 */
- (void)showZanSelectedAnimationBtn:(UIButton *)animationBtn imageName:(NSString *)imageName;

@end
