//
//  NSMutableDictionary+Safe.m
//  runtimeMethodDemo7
//
//  Created by xygj on 2018/7/19.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import "NSMutableDictionary+Safe.h"
#import <objc/runtime.h>

@implementation NSMutableDictionary (Safe)

+ (void)load{
    Class cls = NSClassFromString(@"__NSDictionaryM");
    Method originSetMethod = class_getInstanceMethod(cls, @selector(setObject:forKeyedSubscript:));
    Method exchangeSetMethod = class_getInstanceMethod(cls, @selector(ya_setObject:forKeyedSubscript:));
    method_exchangeImplementations(originSetMethod, exchangeSetMethod);
}

- (void)ya_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key{
    
    if (!key) return;
    
    [self ya_setObject:obj forKeyedSubscript:key];
}

@end
