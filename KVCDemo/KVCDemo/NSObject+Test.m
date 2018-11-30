//
//  NSObject+Test.m
//  KVCDemo
//
//  Created by xygj on 2018/8/20.
//  Copyright © 2018年 OneAlon. All rights reserved.
//

#import "NSObject+Test.h"

@implementation NSObject (Test)

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"%@--%@", value, key);
}

- (id)valueForKeyPath:(NSString *)keyPath {
}

@end
