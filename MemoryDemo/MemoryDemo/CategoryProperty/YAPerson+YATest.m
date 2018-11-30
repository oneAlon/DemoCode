//
//  YAPerson+YATest.m
//  MemoryDemo
//
//  Created by xygj on 2018/8/14.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import "YAPerson+YATest.h"
#import <objc/runtime.h>

const void * key = "123";

@implementation YAPerson (YATest)

- (void)setTestBlockName:(void (^)(void))testBlockName {
    objc_setAssociatedObject(self, key, testBlockName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(void))testBlockName {
    return objc_getAssociatedObject(self, key);
}

@end
