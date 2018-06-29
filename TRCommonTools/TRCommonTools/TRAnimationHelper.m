//
//  TRAnimationHelper.m
//  TRTestDemo
//
//  Created by Tracky on 2017/6/14.
//  Copyright © 2018年 Tracky. All rights reserved.
//

#import "TRAnimationHelper.h"
#import "TRMacroDefine.h"

CGFloat const kAnimationDuration = 1.8;

@interface TRAnimationHelper()<CAAnimationDelegate>

@property (nonatomic,   copy)TRAnimationCompleteBlock completeBlock;

@property (nonatomic, strong)NSMutableArray *animationViewArray;

@end

@implementation TRAnimationHelper

+ (instancetype)shareHelper{
    static TRAnimationHelper *animationHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        animationHelper = [[TRAnimationHelper alloc] init];
    });
    return animationHelper;
}

- (void)arcAnimationFromPoint:(CGPoint)fromPoint
                  targetPoint:(CGPoint)targetPoint
                completeBlock:(TRAnimationCompleteBlock)completeBlock{
    
    self.completeBlock = completeBlock;
    
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.delegate = self;
    pathAnimation.calculationMode = kCAAnimationPaced;
    
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = kAnimationDuration;
    pathAnimation.repeatCount = 1;
    
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, fromPoint.x , fromPoint.y);
    
    CGPathAddLineToPoint(curvedPath, NULL, targetPoint.x, targetPoint.y);
    CGPathAddLineToPoint(curvedPath, NULL, (fromPoint.x + targetPoint.x) * 0.25, (fromPoint.y + targetPoint.y) *0.25);
    CGPathAddLineToPoint(curvedPath, NULL, targetPoint.x, targetPoint.y);
    CGPathAddLineToPoint(curvedPath, NULL, (fromPoint.x + targetPoint.x) * 0.15, (fromPoint.y + targetPoint.y) *0.15);
    CGPathAddLineToPoint(curvedPath, NULL, targetPoint.x, targetPoint.y);
    CGPathAddLineToPoint(curvedPath, NULL, (fromPoint.x + targetPoint.x) * 0.1, (fromPoint.y + targetPoint.y) *0.1);
    CGPathAddLineToPoint(curvedPath, NULL, targetPoint.x, targetPoint.y);
    
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    
    UIImageView *goldImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, 13.5)];
    goldImageView.image = [UIImage imageNamed:@"gold"];
    [self.animationViewArray addObject:goldImageView];
    [[[UIApplication sharedApplication].delegate window] addSubview:goldImageView];
    [goldImageView.layer addAnimation:pathAnimation forKey:@"moveTheSquare"];
    
}

- (void)arcAnimationFromView:(UIView *)fromView targeView:(UIView *)targeView completeBlock:(TRAnimationCompleteBlock)completeBlock{
    
    self.completeBlock = completeBlock;
    
    UIImage * image = [UIImage imageNamed:@"shortVideo_gold"];
    UIWindow * rootWindow = [UIApplication sharedApplication].delegate.window;
    
    CGPoint startPoint = [fromView convertPoint:fromView.center toView:rootWindow];
    CGPoint endPoint = [targeView convertPoint:targeView.center toView:rootWindow];
    endPoint.x = 30 ;
    endPoint.y = kSafeAreaTopHeight + 15;
    
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.delegate = self;
    pathAnimation.calculationMode = kCAAnimationCubic;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = kAnimationDuration;
    pathAnimation.repeatCount = 1;
    
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, startPoint.x , startPoint.y);
    CGPathAddLineToPoint(curvedPath, NULL, endPoint.x, endPoint.y);
    CGPathAddLineToPoint(curvedPath, NULL, (startPoint.x + endPoint.x) * 0.25, (startPoint.y + endPoint.y) *0.25);
    CGPathAddLineToPoint(curvedPath, NULL, endPoint.x, endPoint.y);
    CGPathAddLineToPoint(curvedPath, NULL, (startPoint.x + endPoint.x) * 0.15, (startPoint.y + endPoint.y) *0.15);
    CGPathAddLineToPoint(curvedPath, NULL, endPoint.x, endPoint.y);
    CGPathAddLineToPoint(curvedPath, NULL, (startPoint.x + endPoint.x) * 0.1, (startPoint.y + endPoint.y) *0.1);
    CGPathAddLineToPoint(curvedPath, NULL, endPoint.x, endPoint.y);
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    
    UIImageView *goldImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 21, 21)];
    goldImageView.image = image;
    [self.animationViewArray addObject:goldImageView];
    [[[UIApplication sharedApplication].delegate window] addSubview:goldImageView];
    [[[UIApplication sharedApplication].delegate window] bringSubviewToFront:goldImageView];
    [goldImageView.layer addAnimation:pathAnimation forKey:@"moveTheSquare"];
    
}

- (void)arcAnimationFromView:(UIView *)fromView targeView:(UIView *)targeView inView:(UIView *)inView completeBlock:(TRAnimationCompleteBlock)completeBlock{
    
    self.completeBlock = completeBlock;
    
    UIImage * image = [UIImage imageNamed:@"shortVideo_gold"];
    //UIWindow * rootWindow = [UIApplication sharedApplication].delegate.window;
    
    CGPoint startPoint = [fromView convertPoint:fromView.center toView:inView];
    CGPoint endPoint = [targeView convertPoint:targeView.center toView:inView];
    endPoint.x = 30 ;
    endPoint.y = kSafeAreaTopHeight + 15;
    
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.delegate = self;
    pathAnimation.calculationMode = kCAAnimationCubic;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.duration = kAnimationDuration;
    pathAnimation.repeatCount = 1;
    
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, startPoint.x , startPoint.y);
    CGPathAddLineToPoint(curvedPath, NULL, endPoint.x, endPoint.y);
    CGPathAddLineToPoint(curvedPath, NULL, (startPoint.x + endPoint.x) * 0.25, (startPoint.y + endPoint.y) *0.25);
    CGPathAddLineToPoint(curvedPath, NULL, endPoint.x, endPoint.y);
    CGPathAddLineToPoint(curvedPath, NULL, (startPoint.x + endPoint.x) * 0.15, (startPoint.y + endPoint.y) *0.15);
    CGPathAddLineToPoint(curvedPath, NULL, endPoint.x, endPoint.y);
    CGPathAddLineToPoint(curvedPath, NULL, (startPoint.x + endPoint.x) * 0.1, (startPoint.y + endPoint.y) *0.1);
    CGPathAddLineToPoint(curvedPath, NULL, endPoint.x, endPoint.y);
    pathAnimation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    
    UIImageView *goldImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 21, 21)];
    goldImageView.image = image;
    [self.animationViewArray addObject:goldImageView];
    [inView addSubview:goldImageView];
    [inView bringSubviewToFront:goldImageView];
    [goldImageView.layer addAnimation:pathAnimation forKey:@"moveTheSquare"];
    
}

- (void)showZanAnimationWithTouch:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSSet * allTouches = [event allTouches];
    UITouch * touch = [allTouches anyObject];
    
    CGPoint point = [touch locationInView:[touch view]];
    UIImage * image = [UIImage imageNamed:@"shortVideo_zan_redZan"];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    imageView.image = image;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.center = point;
    
    int angle = arc4random() % 2;
    angle = angle ? angle : -1;
    imageView.transform = CGAffineTransformRotate(imageView.transform,M_PI / 9 * angle);
    [[touch view] addSubview:imageView];
    
    __block UIImageView * backgroundImageView = imageView;
    [UIView animateWithDuration:0.1 animations:^{
        backgroundImageView.transform = CGAffineTransformScale(backgroundImageView.transform, 1.4, 1.4);
    } completion:^(BOOL finished) {
        backgroundImageView.transform = CGAffineTransformScale(backgroundImageView.transform, 0.8, 0.8);
        [self performSelector:@selector(animationFlyToTop:) withObject:backgroundImageView afterDelay:0.3];
    }];
}

- (void)animationFlyToTop:(UIImageView *)backgroundImageView {
    [UIView animateWithDuration:1.0 animations:^{
        backgroundImageView.frame = CGRectMake(backgroundImageView.frame.origin.x, backgroundImageView.frame.origin.y - 100, backgroundImageView.frame.size.width, backgroundImageView.frame.size.height);
        backgroundImageView.transform = CGAffineTransformScale(backgroundImageView.transform, 1.8, 1.8);
        backgroundImageView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [backgroundImageView removeFromSuperview];
    }];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    UIView * view = self.animationViewArray.firstObject;
    if (self.animationViewArray.count) {
        [self.animationViewArray removeObjectAtIndex:0];
        [view removeFromSuperview];
    }
    
    if (self.completeBlock) {
        self.completeBlock();
    }
}


/**
 展示关注按钮点击动画
 
 @param animationBtn 专注按钮
 @param imageName 关注后的图片
 */
- (void)showAttentionSelectedAnimationBtn:(UIButton *)animationBtn imageName:(NSString *)imageName{
    
    [UIView animateWithDuration:0.3 animations:^{
        animationBtn.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.6 animations:^{
            [animationBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            animationBtn.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                animationBtn.transform = CGAffineTransformIdentity;
                animationBtn.alpha = 0;
            }];
        }];
    }];
    
}


/**
 点击赞小红心动画
 
 @param animationBtn 动画按钮
 @param imageName 点赞选中图片
 */
- (void)showZanSelectedAnimationBtn:(UIButton *)animationBtn imageName:(NSString *)imageName{
    
    [UIView animateWithDuration:0.3 animations:^{
        [animationBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        animationBtn.transform = CGAffineTransformMakeScale(1.4, 1.4);
        animationBtn.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            animationBtn.transform = CGAffineTransformIdentity;
            animationBtn.alpha = 1;
        }];
    }];
    
}

- (NSMutableArray *)animationViewArray {
    if (!_animationViewArray) {
        _animationViewArray = [NSMutableArray array];
    }
    return _animationViewArray;
}
@end
