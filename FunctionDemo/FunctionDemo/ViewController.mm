//
//  ViewController.m
//  FunctionDemo
//
//  Created by xygj on 2018/8/21.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

void *testFunction(){
    printf("这是测试代码");
    return nil;
}

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%p", testFunction());
    NSLog(@"%p", &testFunction());
}


@end
