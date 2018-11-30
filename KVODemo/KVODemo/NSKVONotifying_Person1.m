//
//  NSKVONotifying_Person.m
//  KVODemo
//
//  Created by OneAlon on 2018/4/13.
//  Copyright © 2018年 OneAlon. All rights reserved.
//

#import "NSKVONotifying_Person1.h"

@implementation NSKVONotifying_Person1

-(void)setAge:(int)age{
    _NSSetIntValueAndNotify();
}
void _NSSetIntValueAndNotify(){
//    [self willChangeValueForKey:age];
//    [super setAge:age];
//    [self didChangeValueForKey:age];
}

//-(void)didChangeValueForKey:(NSString *)key{
//    [observer observeValueForKeyPath:@"age" ofObject:self change:@{} context:nil];
//}
//
//- (Class)class
//{
//    // 返回self的父类, self的父类是Person, 为了隐藏NSKVONotifying_Person1中间类的信息
//    return class_getSuperclass(object_getClass(self));
//}

@end
