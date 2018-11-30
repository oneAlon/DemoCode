//
//  main.m
//  runtimeDemo6
//
//  Created by xygj on 2018/7/18.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "YAPerson.h"

void test(){
    YAPerson *person = [[YAPerson alloc] init];
    
    // 获取isa指向的Class
    Class cls = object_getClass(person);
    NSLog(@"%@", cls);
    
    // 设置isa指向
    object_setClass(person, [NSDictionary class]);
    NSLog(@"%@", [person class]);
    
    // 判断一个OC对象是否为Class
    BOOL isClass1 = object_isClass(person);
    BOOL isClass2 = object_isClass(object_getClass(person));
    BOOL isClass3 = object_isClass(object_getClass(object_getClass(person)));
    NSLog(@"%d--%d--%d", isClass1, isClass2, isClass3);
    
    // 判断一个Class是否是元类
    BOOL isMetaClass = object_isClass(object_getClass(object_getClass(person)));
    NSLog(@"%d", isMetaClass);
    
    // 获取父类
    Class supClass1 = class_getSuperclass([NSMutableArray class]);
    NSLog(@"%@", supClass1);
    
    // 动态创建一个类, 并注册(注册以后这个类的成员变量等就无法再被修改了), 不再使用的时候进行销毁
    Class YAStudent = objc_allocateClassPair([YAPerson class], "YAStudent", 0);
    class_addIvar(YAStudent, "_name", 8, 1, @encode(NSString *));
    class_addIvar(YAStudent, "_age", 4, 1, @encode(int));
    objc_registerClassPair(YAStudent);
    
    id student = [[YAStudent alloc] init];
    [student setValue:@"OneAlon" forKey:@"_name"];
    [student setValue:@20 forKey:@"_age"];
    NSLog(@"%@", [student valueForKey:@"_age"]);
    NSLog(@"%@", [student valueForKey:@"_name"]);
    
//    objc_disposeClassPair(YAStudent); // 销毁
}

void ivarTest(){
    YAPerson *person = [[YAPerson alloc] init];
    
    // 获取一个成员实例变量
    Ivar nameIvar = class_getInstanceVariable([YAPerson class], "_name");
    NSLog(@"%s--%s", ivar_getName(nameIvar), ivar_getTypeEncoding(nameIvar));
    
    // 设置成员变量的值 获取成员变量的值
    object_setIvar(person, nameIvar, @"OneAlon");
    NSLog(@"name: %@", object_getIvar(person, nameIvar));
    
    // 动态添加成员变量(已经注册的类是不能添加成员变量的, 因为成员变量存储在ro, 不能被修改)
    BOOL success = class_addIvar([YAPerson class], "address", 8, 1, @encode(NSString));
    NSLog(@"添加成功%d", success);// 所以这里添加不成功
    
    // 获取成员变量列表
    unsigned int outCount;
    Ivar *ivarList =class_copyIvarList([YAPerson class], &outCount);// 返回的是存储这成员变量的列表
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivarList[i];
        NSLog(@"成员变量名称:%s---成员变量类型:%s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        YAPerson *person = [[YAPerson alloc] init];
        
        // 获取一个属性
        objc_property_t nameProperty = class_getProperty([YAPerson class], "name");
        NSLog(@"属性名称:%s--属性:%s", property_getName(nameProperty), property_getAttributes(nameProperty));

        
    }
    return 0;
}
