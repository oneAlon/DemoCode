//
//  YATaggedPointerViewController.m
//  MemoryDemo
//
//  Created by xygj on 2018/8/13.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import "YATaggedPointerViewController.h"

@interface YATaggedPointerViewController ()

@property (nonatomic ,copy) NSString *name;

@end

@implementation YATaggedPointerViewController

//- (void)setName:(NSString *)name {
//    if (_name != name) {
//        [_name release];
//        _name = [name copy];
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"tagged Pointer";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *str1 = [NSString stringWithFormat:@"abc"];
    NSString *str2 = [NSString stringWithFormat:@"abcdefghijkl"];
    
    NSLog(@"%p, %p", str1, str2);
    NSLog(@"%@, %@", [str1 class], [str2 class]);
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for (int i = 0; i < 10000; i++) {
        dispatch_async(queue, ^{
            // 指针的赋值, 不存在release操作
//            self.name = [NSString stringWithFormat:@"abc"];

            // 对同一个对象重复release
            @synchronized(self){            
                self.name = [NSString stringWithFormat:@"abcdefghijkldsfsdfdf"];
            }
        });
    }
    

    
//    self.name = [NSString stringWithFormat:@"abcdefghijkldsfsdfdf"];
//    NSLog(@"%lu", _name.retainCount);
//    [_name release];
//    NSLog(@"%lu", _name.retainCount);
//    [_name release];
//    NSLog(@"%lu", _name.retainCount);
//    NSLog(@"end-----");
}


@end
