//
//  main.m
//  ObjcMemoryDemo
//
//  Created by OneAlon on 2018/3/8.
//  Copyright © 2018年 OneAlon. All rights reserved.
//  研究OC中的对象的底层实现

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

struct WYL_NSObject_IMPL {
    Class isa;
};

struct WYL_Person_IMPL {
    Class isa;
    int _no;
    int _age;
};

@interface Person : NSObject{
    @public
    int _no;
    int _age;
}
@end

@implementation Person
@end

struct Student {
    int age;
    NSString *name;
    
};

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        
        id objectClass = [NSObject class];
        NSLog(@"%@", [objectClass superclass]);
        
         NSObject *obj1 = [[NSObject alloc] init];
        NSObject *obj2 = [[NSObject alloc] init];
        NSLog(@"NSObject类对象的内存地址:%p", [NSObject class]);

        Person *p = [[Person alloc] init];
        NSLog(@"%@", p);
        NSLog(@"%@", [Person class]);
        NSLog(@"%s", object_getClassName(p));
        Person *p2 = [[Person alloc] init];
        
        
        
        
        NSLog(@"%p", [Person class]);
        
        struct Student student = {22, @"haha"};
        student.age = 23;
        
        NSLog(@"%@", student.name);
        
        struct Student *studentPointer = &student;
        studentPointer->name = @"1234";
        NSLog(@"%@", studentPointer->name);
    }
    return 0;
}

void test(){
    Person *p = [[Person alloc] init];
    p->_no = 10;
    p->_age = 20;
    NSLog(@"%@", p);
    struct WYL_Person_IMPL *personImp = (__bridge struct WYL_Person_IMPL *)p;
    NSLog(@"no:%zd, age:%zd", personImp->_no, personImp->_age);
    
    
    
    NSObject *obj1 = [[Person alloc] init];
    NSObject *obj2 = [[Person alloc] init];
    
    // 一个类的类对象在内存中只有一份 class返回的一直都是类对象
    Class classObject1 = [obj1 class];
    Class classObject2 = [NSObject class];
    Class classObject3 = object_getClass(obj1);
    NSLog(@"%p--%p--%p", classObject1, classObject2, classObject3);
    
    
    // 元类对象
    Class obj1MetaClass = object_getClass([obj1 class]);
    Class obj2MetaClass = object_getClass([obj2 class]);
    
    NSLog(@"%p", obj1MetaClass);
    NSLog(@"%p", obj2MetaClass);
    
    
    NSLog(@"%@--%@--%@--%@--%@", classObject1, classObject2, classObject3, obj1MetaClass, obj2MetaClass);
}
