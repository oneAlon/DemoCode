//
//  ViewController.m
//  BlockDemo
//
//  Created by xygj on 2018/8/20.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import "ViewController.h"
#import "YAPerson.h"

@interface ViewController ()

@property (nonatomic ,strong) YAPerson *person;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _person = [[YAPerson alloc] init];
    __weak typeof(self) weakSelf = self;
    _person.printPersonName = ^(NSString *name) {
        __strong typeof(self) strongSelf = weakSelf;
        NSLog(@"%@", strongSelf);
    };
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
    _person.printPersonName(@"123");
}


@end
