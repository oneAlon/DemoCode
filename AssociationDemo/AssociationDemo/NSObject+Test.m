//
//  NSObject+Test.m
//  AssociationDemo
//
//  Created by xygj on 2018/11/30.
//  Copyright © 2018 xygj. All rights reserved.
//

#import "NSObject+Test.h"
#import <objc/runtime.h>

static void *nameKey = &nameKey;

@implementation NSObject (Test)

- (NSString *)name {
    return objc_getAssociatedObject(self, &nameKey);
}

- (void)setName:(NSString *)name {
    objc_setAssociatedObject(self, &nameKey, name, OBJC_ASSOCIATION_COPY);
}

@end
