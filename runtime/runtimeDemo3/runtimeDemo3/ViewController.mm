//
//  ViewController.m
//  runtimeDemo3
//
//  Created by xygj on 2018/7/13.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import "ViewController.h"
#import "YAPerson.h"
#import <objc/runtime.h>
#import "MJClassInfo.h"

@interface ViewController ()

@end

struct ya_objc_class{
    Class superclass;
};

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YAPerson *person = [[YAPerson alloc] init];
    
    mj_objc_class *cls = (__bridge mj_objc_class *)objc_getMetaClass(object_getClassName(person));
    class_rw_t *data = cls->data();
    
    NSLog(@"%p", object_getClass(person));
    NSLog(@"%p", objc_getMetaClass(object_getClassName(person)));
}


@end
