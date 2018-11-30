//
//  NSArray+Safe.m
//  runtimeMethodDemo7
//
//  Created by xygj on 2018/7/19.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import "NSArray+Safe.h"
#import <objc/runtime.h>

@implementation NSArray (Safe)

+ (void)load{
    Class cls = NSClassFromString(@"__NSArrayI");
    
    Method originGetMethod = class_getInstanceMethod(cls, @selector(objectAtIndex:));
    Method exchangeGetMethod = class_getInstanceMethod(cls, @selector(ya_objectAtIndex:));
    method_exchangeImplementations(originGetMethod, exchangeGetMethod);
    
}

- (id)ya_objectAtIndex:(NSUInteger)index{
    
    if (index > self.count) return nil;
    
    return [self ya_objectAtIndex:index];
}

@end
