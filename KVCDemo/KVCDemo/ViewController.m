//
//  ViewController.m
//  KVCDemo
//
//  Created by OneAlon on 2018/5/8.
//  Copyright © 2018年 OneAlon. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "NSObject+Test.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // forKey forKeyPath
    
    Person *p = [Person new];
    [p setValue:@"123" forKey:@"name"];
    
    [p valueForKey:@"name"];
}


@end
