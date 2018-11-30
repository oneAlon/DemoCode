//
//  ViewController.m
//  runtimeDemo
//
//  Created by xygj on 2018/7/6.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Person *p = [[Person alloc] init];
    p.tall = YES;
    p.rich = NO;
    p.handsome = YES;
    p.name = @"OneAlon";
    NSLog(@"tall : %d, rich : %d, handsome : %d", p.tall, p.rich, p.handsome);
//    objc_msgSend(p, sel_registerName("test"));
    
    
    objc_msgSend(p, sel_registerName("test"));
    
    NSLog(@"%@", class_getSuperclass([Person class]));
    NSLog(@"%@", object_getClass([Person class]));
//    object_getClass([Person class])
}


@end
