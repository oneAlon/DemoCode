//
//  ViewController.m
//  runtimeDemo4
//
//  Created by xygj on 2018/7/17.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import "ViewController.h"
#import "YAPerson.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YAPerson *person = [[YAPerson alloc] init];
    
    NSLog(@"%d", [person isMemberOfClass:[NSObject class]]); // 0
    NSLog(@"%d", [person isKindOfClass:[NSObject class]]); // 1
    NSLog(@"%d", [person isMemberOfClass:[YAPerson class]]); // 1
    NSLog(@"%d", [person isKindOfClass:[YAPerson class]]); // 1
    
    NSLog(@"%d", [NSObject isKindOfClass:[NSObject class]]); // 1
    NSLog(@"%d", [NSObject isMemberOfClass:[NSObject class]]); // 0
    NSLog(@"%d", [YAPerson isKindOfClass:[YAPerson class]]); // 0
    NSLog(@"%d", [YAPerson isMemberOfClass:[YAPerson class]]); // 0
}


@end
