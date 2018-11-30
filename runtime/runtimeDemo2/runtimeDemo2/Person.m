//
//  Person.m
//  runtimeDemo2
//
//  Created by xygj on 2018/7/12.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
#import "Cat.h"

@implementation Person

- (void)personOtherInstanceMethod{
    NSLog(@"%s", __func__);
}

//+ (BOOL)resolveInstanceMethod:(SEL)sel{
//    if (sel == @selector(personInstanceMethod)) {
//        NSLog(@"%@", NSStringFromSelector(sel));
//        IMP otherImp = class_getMethodImplementation([self class], @selector(personOtherInstanceMethod));
//        class_addMethod([self class], sel, otherImp, "v@:");
//        return YES;
//    }else{
//        return [super resolveInstanceMethod:sel];
//    }
//}

- (id)forwardingTargetForSelector:(SEL)aSelector{
    if (aSelector == @selector(personInstanceMethod)) {
//        return [[Cat alloc] init];
        return nil;
    }else{
        return [super forwardingTargetForSelector:aSelector];
    }
}

// 方法签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if (aSelector == @selector(personInstanceMethod)) {
        return [[[Cat alloc] init] methodSignatureForSelector:@selector(catInstanceMethod)];
    }else{
        return [super forwardingTargetForSelector:aSelector];
    }
}

// NSInvocation封装了方法调用, 包括方法签名 方法调用者 方法名 方法返回值 方法参数等
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    // 在这里可以修改selector
    anInvocation.selector = @selector(catInstanceMethod);
    [anInvocation invokeWithTarget:[[Cat alloc] init]];
}

@end
