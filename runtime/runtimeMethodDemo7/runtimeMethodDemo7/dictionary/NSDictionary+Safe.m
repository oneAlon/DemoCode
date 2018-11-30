//
//  NSDictionary+Safe.m
//  runtimeMethodDemo7
//
//  Created by xygj on 2018/7/19.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import "NSDictionary+Safe.h"
#import <objc/runtime.h>

@implementation NSDictionary (Safe)

+ (void)load{
    Class cls = NSClassFromString(@"__NSPlaceholderDictionary");
    Method originSetMethod = class_getInstanceMethod(cls, @selector(initWithObjects:forKeys:count:));
    Method exchangeSetMethod = class_getInstanceMethod(cls, @selector(ya_initWithObjects:forKeys:count:));
    method_exchangeImplementations(originSetMethod, exchangeSetMethod);
}


- (instancetype)ya_initWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt{
    
    id safeObjects[cnt];
    id safeKeys[cnt];
    NSUInteger safeCnt = 0;
    
    for (NSUInteger i = 0; i < cnt; i ++) {
        id obj = objects[i];
        id key = keys[i];
        if (!obj || !key) {
            NSLog(@"error: 字典中的value或key不能为nil");
            continue;
        }
        safeObjects[safeCnt] = obj;
        safeKeys[safeCnt] = key;
        safeCnt++;
    }
    return [self ya_initWithObjects:safeObjects forKeys:safeKeys count:safeCnt];
}



@end
