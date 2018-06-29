//
//  TRWKWeakDelegateController.m
//  YomoProject
//
//  Created by Tracky on 2018/5/2.
//  Copyright © 2018年 Yomo. All rights reserved.
//

#import "TRWKWeakDelegateController.h"

@interface TRWKWeakDelegateController ()

@end

@implementation TRWKWeakDelegateController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([_tr_delegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [_tr_delegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}

/**
 * 用法示例
 * webViewController
 */
//- (void)viewDidLoad {
//    [super viewDidLoad];
//
//    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
//    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
//
//    configuration.userContentController = userContentController;
//
//    TRWKWeakDelegateController *weakController =[[TRWKWeakDelegateController alloc] init];
//    weakController.tr_delegate = self;
//    [userContentController addScriptMessageHandler:(id)weakController name:kJavascriptReportOpenOrderPayment];
//
//
//    WKWebView *paymentWebView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
//    paymentWebView.UIDelegate = self;
//    paymentWebView.navigationDelegate = self;
//    paymentWebView.scrollView.bounces = NO;
//    [self.view addSubview:paymentWebView];
//    self.paymentWebView = paymentWebView;
//
//    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@""]];
//    urlRequest.timeoutInterval = 30;
//    [self.paymentWebView loadRequest:urlRequest];
//    ......
//}
@end
