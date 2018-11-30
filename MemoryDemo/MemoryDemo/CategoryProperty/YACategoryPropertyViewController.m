//
//  YACategoryPropertyViewController.m
//  MemoryDemo
//
//  Created by xygj on 2018/8/14.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import "YACategoryPropertyViewController.h"
#import "YAPerson.h"
#import "YAPerson+YATest.h"

@interface YACategoryPropertyViewController ()

@property (nonatomic ,strong) YAPerson *person;

@property (nonatomic ,copy) NSString *name;

@end

@implementation YACategoryPropertyViewController

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.person = [[YAPerson alloc] init];
    
    __weak typeof(self) weakSelf = self;
    self.person.testBlockName = ^{
        __strong typeof(self) strongSelf = weakSelf;
        NSLog(@"%@", weakSelf.name);
        NSLog(@"%@", strongSelf.name);
    };
//    self.person.testBlockName();
    
    
}


@end
