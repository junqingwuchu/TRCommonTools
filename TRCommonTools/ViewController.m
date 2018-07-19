//
//  ViewController.m
//  TRCommonTools
//
//  Created by book on 2018/6/29.
//  Copyright © 2018年 Tracky. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *racButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 80, 80, 60);
    [button setTitle:@"点我点我" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [[self.racButton rac_signalForSelector:@selector(racButtonHandle:)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"12345678900987654321234567890");
    }];
    
    [[self.racButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"2222222222222222222");

    }];
    
}

- (void)buttonTouch:(UIButton *)button{
    FirstViewController *vc = [[FirstViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
    
    
    NSMutableArray * m1 = [NSMutableArray array];
    NSMutableArray * m2 = [NSMutableArray array];
    NSMutableArray * m3 = [NSMutableArray array];
    NSMutableArray * m4 = [NSMutableArray array];
    
    for (int i = 0; i <16; i++) {
        if (i & (1 << 0)) {
            [m1 addObject:@(i)];
        }
        if (i & (1 << 1)) {
            [m2 addObject:@(i)];
        }
        if (i & (1 << 2)) {
            [m3 addObject:@(i)];
        }
        if (i & (1 << 3)) {
            [m4 addObject:@(i)];
        }
    }
    NSLog(@" %ld %ld %ld %ld ", m1.count, m2.count,m3.count,m4.count);
    
    
    
    for (int i = 0; i < m1.count; i++) {
        if (i == 0) {
            NSLog(@"m1 /n");
        }
        NSLog(@"%d ", [m1[i] intValue]);
    }
    for (int i = 0; i < m2.count; i++) {
        if (i == 0) {
            NSLog(@"m2 /n");
        }
        NSLog(@"%d ", [m2[i] intValue]);
    }
    for (int i = 0; i < m3.count; i++) {
        if (i == 0) {
            NSLog(@"m3 /n");
        }
        NSLog(@"%d ", [m3[i] intValue]);
    }
    for (int i = 0; i < m4.count; i++) {
        if (i == 0) {
            NSLog(@"m4 /n");
        }
        NSLog(@"%d ", [m4[i] intValue]);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)racButtonHandle:(id)sender {
    NSLog(@"111111111111111111");

}

@end
