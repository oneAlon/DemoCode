//
//  ViewController.m
//  AssociationDemo
//
//  Created by xygj on 2018/11/30.
//  Copyright © 2018 xygj. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Test.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSObject *obj = [[NSObject alloc] init];
    obj.name = @"OneAlon";
    NSLog(@"%@", obj.name);
    
}


@end
