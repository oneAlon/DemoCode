//
//  ViewController.m
//  MemoryDemo
//
//  Created by xygj on 2018/8/9.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import "ViewController.h"
#import "YATimerViewController.h"
#import "YAGCDTimerViewController.h"
#import "YATaggedPointerViewController.h"
#import "YACopyViewController.h"
#import "YACategoryPropertyViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)timerButtonClick:(id)sender {
    [self pushToNextViewController:[YATimerViewController class]];
}
- (IBAction)GCDTimerButtonClick:(id)sender {
    [self pushToNextViewController:[YAGCDTimerViewController class]];
}
- (IBAction)taggedPointerButtonClick:(id)sender {
    [self pushToNextViewController:[YATaggedPointerViewController class]];
}
- (IBAction)copyButtonClick:(id)sender {
    [self pushToNextViewController:[YACopyViewController class]];
}
- (IBAction)categoryPropertyButtonClick:(id)sender {
    [self pushToNextViewController:[YACategoryPropertyViewController class]];
}

- (void)pushToNextViewController:(Class)viewControllerClass {
    if (!viewControllerClass) return;
    id nextVC = [[viewControllerClass alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

@end
