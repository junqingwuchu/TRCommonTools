//
//  TRWKWeakDelegateController.h
//  YomoProject
//
//  Created by Tracky on 2018/5/2.
//  Copyright © 2018年 Yomo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

/**
 * 该类通过代理方式解决使用WKWebView时可能引起的内存循环引用问题
 */
@protocol TRWKWeakDelegate <NSObject>
@required
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;

@end

@interface TRWKWeakDelegateController : UIViewController

@property (nonatomic, weak) id<TRWKWeakDelegate>tr_delegate;

@end
