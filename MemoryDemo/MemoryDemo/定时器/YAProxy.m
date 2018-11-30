//
//  YAProxy.m
//  MemoryDemo
//
//  Created by xygj on 2018/8/13.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import "YAProxy.h"

@interface YAProxy()

@property (nonatomic ,weak) id target;

@end

@implementation YAProxy

+ (instancetype)proxyWithTarget:(id)target {
    YAProxy *proxy = [YAProxy alloc];
    proxy.target = target;
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

@end
