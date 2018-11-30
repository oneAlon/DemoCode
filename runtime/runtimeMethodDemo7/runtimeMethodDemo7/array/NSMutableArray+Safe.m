//
//  NSMutableArray+Safe.m
//  runtimeMethodDemo7
//
//  Created by xygj on 2018/7/19.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import "NSMutableArray+Safe.h"
#import <objc/runtime.h>

@implementation NSMutableArray (Safe)

+ (void)load{
    Class cls = NSClassFromString(@"__NSArrayM");
    Method originMethod = class_getInstanceMethod(cls, @selector(insertObject:atIndex:));
    Method exchangeMethod = class_getInstanceMethod(cls, @selector(ya_insertObject:atIndex:));
    method_exchangeImplementations(originMethod, exchangeMethod);
    
    Method originGetMethod = class_getInstanceMethod(cls, @selector(objectAtIndex:));
    Method exchangeGetMethod = class_getInstanceMethod(cls, @selector(ya_objectAtIndex:));
    method_exchangeImplementations(originGetMethod, exchangeGetMethod);
    
}

- (void)ya_insertObject:(id)anObject atIndex:(NSUInteger)index{
    
    if (!anObject) return;
    
    [self ya_insertObject:anObject atIndex:index];
}

- (id)ya_objectAtIndex:(NSUInteger)index{
    
    if (index > self.count) return nil;
    
    return [self ya_objectAtIndex:index];
}

@end
