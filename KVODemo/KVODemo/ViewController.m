//
//  ViewController.m
//  KVODemo
//
//  Created by OneAlon on 2018/4/12.
//  Copyright © 2018年 OneAlon. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Student.h"
#import <objc/runtime.h>

#import "NSObject+Block_KVO.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)dealloc {
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self test1];
    
}

- (void)test3{
    Student *s = [[Student alloc] init];
    
    [s addObserver:self forKey:@"name" withBlock:^(id observedObject, NSString *observedKey, id oldValue, id newValue) {
        NSLog(@"observedObject=%@, observedKey=%@, oldValue=%@, newValue=%@", observedObject, observedKey, oldValue, newValue);
    }];
    
    s.name = @"haha";
    s.name = @"heihei";
    
    NSLog(@"%@", [s class]);
}

-(void)test2{
    Person *p1 = [[Person alloc] init];
    Person *p2 = [[Person alloc] init];

    
    NSLog(@"%@---%@", [p1 class], object_getClass(p1));
}

-(void)test1{
    
    Person *p1 = [[Person alloc] init];
    Person *p2 = [[Person alloc] init];
    
    NSLog(@"p1添加KVO监听之前 - %p %p",
          [p1 methodForSelector:@selector(setAge:)],
          [p2 methodForSelector:@selector(setAge:)]);
    
    [p1 addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    
    NSLog(@"p1添加KVO监听之后 - %p %p",
          [p1 methodForSelector:@selector(setAge:)],
          [p2 methodForSelector:@selector(setAge:)]);
    
    // 查看p1的父类
    // po class_getSuperclass([NSKVONotifying_Person class]) ---> 打印出 Person
    
    // 查看
    [self printMethods:object_getClass(p1)];
    
    // 添加过监听以后, 查看p1的class类型--->Person---Person
    NSLog(@"%@---%@", [p1 class], [p2 class]);
    
    p1.age = 10;
    
    p2.age = 10;
    
    NSLog(@"%@--%@", p1, p2);
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSLog(@"监听到%@的%@属性改变:%@", object, keyPath, change);
}


- (void)printMethods:(Class)cls
{
    unsigned int count;
    Method *methods = class_copyMethodList(cls, &count);
    
    NSMutableString *methodNames = [NSMutableString string];
    [methodNames appendFormat:@"%@ - ", cls];
    
    for (int i = 0; i < count; i++) {
        Method method = methods[i];
        
        NSString *methodName = NSStringFromSelector(method_getName(method));
        [methodNames appendString:methodName];
        [methodNames appendString:@" "];
    }
    
    NSLog(@"%@", methodNames);
    
    free(methods);
}


@end
