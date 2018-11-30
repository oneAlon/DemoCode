//
//  ViewController.m
//  CategoryDemo
//
//  Created by OneAlon on 2018/5/23.
//  Copyright © 2018年 OneAlon. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

struct WYL_Student{
    Class isa;
};

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Person *p = [[Person alloc] init];
    [p run];
//    NSLog(@"%@", p);
//    NSLog(@"%@", *p);
    
//    Student *s = [[Student alloc] init];
//    Class c1 = [s class];
//    Class c2 = object_getClass(s);
//    Class c3 = object_getClass([s class]);
//    Class c4 = [[s class] class];
//    Class c5 = objc_getMetaClass("Student");

    
//    struct WYL_Student *pStruct = (__bridge struct WYL_Student *)(s);
//    NSLog(@"%@", pStruct->isa);
//    NSLog(@"%@--%@--%@--%@--%@", c1, c2, c3, c4, c5);
//    NSLog(@"%p--%p--%p--%p--%p", c1, c2, c3, c4, c5);
}


@end
