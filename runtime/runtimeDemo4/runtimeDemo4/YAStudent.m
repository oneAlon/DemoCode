//
//  YAStudent.m
//  runtimeDemo4
//
//  Created by xygj on 2018/7/17.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import "YAStudent.h"

@implementation YAStudent

//- (instancetype)init{
//    if (self = [super init]) {
//        NSLog(@"[self class] = %@", [self class]); // YAStudent
//        NSLog(@"[self superClass] = %@", [self superclass]); // YAPerson
//
//        NSLog(@"[super class] = %@", [super class]); // YAStudent
//        NSLog(@"[super superClass] = %@", [super superclass]); // YAPerson
//    }
//    return self;
//}

- (instancetype)init{
    if (self = [super init]) {
        NSLog(@"%d", [YAStudent isKindOfClass:[YAStudent class]]);
        NSLog(@"%d", [YAStudent isKindOfClass:[YAStudent class]]);
    }
    return self;
}

- (void)test{
    [super test];
    NSLog(@"%s", __func__);
}

@end
