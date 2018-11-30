//
//  YACopyViewController.m
//  MemoryDemo
//
//  Created by xygj on 2018/8/13.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import "YACopyViewController.h"

@interface YACopyViewController ()

@end

@implementation YACopyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self stringCopyTest];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"copy";
}

- (void)stringCopyTest {
    NSString *str1 = @"123";
    NSString *str2 = [str1 copy];
    NSString *str3 = [str1 mutableCopy];
    
    NSString *str4 = [[NSMutableString alloc] initWithString:@"456"];
    NSString *str5 = [str4 copy];
    NSString *str6 = [str4 mutableCopy];
    
    // 0x104f3c318, 0x104f3c318, 0x6040002506e0
    NSLog(@"%p, %p, %p", str1, str2, str3);
    // 0x60400024f720, 0xa000000003635343, 0x604000252540
    NSLog(@"%p, %p, %p", str4, str5, str6);
}




@end
