//
//  UITextField+TRBackward.h
//  TRCommonTools
//
//  Created by Tracky on 2016/7/5.
//  Copyright © 2016年 Tracky. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TRBackwardDelegate <UITextFieldDelegate>
@optional
/**
 * 监听删除按钮
 * object:UITextField
 */
- (void)textFieldDidBackwardKeyTouch:(UITextField *)textField;
@end

@interface UITextField (TRBackward)
@property (nonatomic, weak) id<TRBackwardDelegate>delegate;
@end
