//
//  FirstViewController.m
//  TRCommonTools
//
//  Created by book on 2018/7/5.
//  Copyright © 2018年 Tracky. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(50, 80, 80, 60);
    [button setTitle:@"button" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonTouch:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonTouch:(UIButton *)button{
    [self configFirstPage];

    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configFirstPage{
    NSLog(@"1234567890");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
