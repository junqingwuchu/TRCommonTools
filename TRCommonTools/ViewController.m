//
//  ViewController.m
//  TRCommonTools
//
//  Created by book on 2018/6/29.
//  Copyright © 2018年 Tracky. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SubTestClass.h"
#import "TestClass.h"
#import "TestClass+TRHeader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat s = 1.4;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 80, 80, 60);
    [button setTitle:[NSString stringWithFormat:@"%.f", s] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchUpInside];
    
//    SubTestClass * sub = [[SubTestClass alloc] init];
//
//    TestClass * cla = [[TestClass alloc] init];

    [SubTestClass lll];
}

- (void)buttonTouch:(UIButton *)button{
    FirstViewController *vc = [[FirstViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
