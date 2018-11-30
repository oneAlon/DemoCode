//
//  NSObject+Block_KVO.m
//  KVODemo
//
//  Created by OneAlon on 2018/5/8.
//  Copyright © 2018年 OneAlon. All rights reserved.
//

#import "NSObject+Block_KVO.h"
#import <objc/runtime.h>
#import <objc/message.h>

#pragma mark - PGObservationInfo
@interface PGObservationInfo : NSObject

@property (nonatomic, weak) NSObject *observer;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) PGObservingBlock block;

@end

@implementation PGObservationInfo

- (instancetype)initWithObserver:(NSObject *)observer Key:(NSString *)key block:(PGObservingBlock)block
{
    self = [super init];
    if (self) {
        _observer = observer;
        _key = key;
        _block = block;
    }
    return self;
}

@end


/*
 1. 查看被观察的类是否实现了setter方法, 如果没有抛出异常
 2. 查看被观察的类的类型是否是以`固定前缀`, 如果不是创建一个中间类
 3. 将传入的block做属性关联
 4. 定义一个kvoSetter方法, 交换中间类的setter方法, 当被观察类的setter方法被调用时, 就会调用kvoSetter方法
 */


/**
 Setter方法
 */
static NSString * getObjectSetterWithName(NSString *name){
    if (name.length <= 0) {
        return nil;
    }
    NSString *firstLetter = [[name substringToIndex:1] uppercaseString];
    NSString *remainingLetters = [name substringFromIndex:1];
    NSString *getter = [NSString stringWithFormat:@"set%@%@:", firstLetter, remainingLetters];
    return getter;
}

static NSString * getObjectGetterWithSetter(NSString *setter){
    if (setter.length <=0 || ![setter hasPrefix:@"set"] || ![setter hasSuffix:@":"]) {
        return nil;
    }
    
    // remove 'set' at the begining and ':' at the end
    NSRange range = NSMakeRange(3, setter.length - 4);
    NSString *key = [setter substringWithRange:range];
    
    // lower case the first letter
    NSString *firstLetter = [[key substringToIndex:1] lowercaseString];
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1)
                                       withString:firstLetter];
    
    return key;
}


/**
 KVO方法
 */
static void kvoSetter(id self, SEL _cmd, id newValue){
    // 获取旧值
    NSString *setter = NSStringFromSelector(_cmd);
    NSString *getter = getObjectGetterWithSetter(setter);
    
    if (!getter) {
        NSString *reason = [NSString stringWithFormat:@"Object %@ does not have setter %@", self, getter];
        @throw [NSException exceptionWithName:NSInvalidArgumentException
                                       reason:reason
                                     userInfo:nil];
        return;
    }
    
    NSString *oldValue = [self valueForKey:getter];
    
    struct objc_super superclazz = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    // cast our pointer so the compiler won't complain
    void (*objc_msgSendSuperCasted)(void *, SEL, id) = (void *)objc_msgSendSuper;
    
    // call super's setter, which is original class's setter method
    objc_msgSendSuperCasted(&superclazz, _cmd, newValue);
    
    NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge const void *)(@"objc_setAssociatedObject"));
    for (PGObservationInfo *info in observers) {
        if ([info.key isEqualToString:getter]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                info.block(self, getter, oldValue, newValue);
            });
        }
    }
}

static Class kvo_class(id self, SEL _cmd)
{
    return class_getSuperclass(object_getClass(self));
}


@implementation NSObject (Block_KVO)
/**
 创建中间类
 */
-(Class)createClassWithOriginalClass:(Class)clazz{
    
    NSString *kvoClazzName = [@"WYLKvoObserver_" stringByAppendingString:NSStringFromClass(clazz)];
    // 如果kvoClassName的类型没有被load的话, 就返回nil
    Class kvoClazz = NSClassFromString(kvoClazzName);
    if (kvoClazz) {
        return kvoClazz;
    }
    // 需要使用运行时创建kvoClazz
    /*
     To create a new class, start by calling objc_allocateClassPair. Then set the class's attributes with functions like class_addMethod and class_addIvar. When you are done building the class, call objc_registerClassPair. The new class is now ready for use.
     */
    Class originalClazz = object_getClass(self);
    kvoClazz = objc_allocateClassPair(originalClazz, kvoClazzName.UTF8String, 0);
    
    // 修改class方法
    Method originalClassMethod = class_getInstanceMethod(originalClazz, NSSelectorFromString(@"class"));
    const char * types = method_getTypeEncoding(originalClassMethod);
    class_addMethod(kvoClazz, NSSelectorFromString(@"class"), (IMP)kvo_class, types);
    
    objc_registerClassPair(kvoClazz);
    
    return kvoClazz;
}


#pragma mark - observer
- (void)addObserver:(NSObject *)observer forKey:(NSString *)key withBlock:(PGObservingBlock)finishBlock{
    
    Class clazz = object_getClass(self);
    
    // 1. 检测被观察类是否实现了setter方法
    SEL keySetter = NSSelectorFromString(getObjectSetterWithName(key));
    Method keySetterMethod = class_getInstanceMethod(clazz, keySetter);
    if (!keySetterMethod) {
        // 如果setter方法不存在, 抛出异常
        @throw [[NSException alloc] initWithName:@"no setter" reason:@"no setter reason" userInfo:nil];
        return;
    }
    
    // 2. 查看当前类是否是kvo的类, 固定前缀, 如果没有就创建中间类, 将当前对象的类型设置为中间类
    NSString *className = NSStringFromClass(clazz);
    if (![className hasPrefix:@"WYLKvoObserver_"]) {
        clazz = [self createClassWithOriginalClass:clazz];
        object_setClass(self, clazz);
    }
    
    // 3. 方法交换
    // 遍历clazz的所有方法, 查看是否已经有setter方法, 如果没有就再添加
    if (![self hasSelector:keySetter]) {
        const char * types = method_getTypeEncoding(keySetterMethod);
        class_addMethod(clazz, keySetter, (IMP)kvoSetter, types);
    }
    
    // 4. 将传入的block做属性关联, 将info对象保存到数组中, 将数组作为属性做关联.
    PGObservationInfo *info = [[PGObservationInfo alloc] initWithObserver:observer Key:key block:finishBlock];
    NSMutableArray *observers = objc_getAssociatedObject(self, (__bridge const void *)(@"objc_setAssociatedObject"));
    if (!observers) {
        observers = [NSMutableArray array];
    }
    [observers addObject:info];
    objc_setAssociatedObject(self, (__bridge const void *)(@"objc_setAssociatedObject"), observers, OBJC_ASSOCIATION_COPY);
}


#pragma mark - 其他
- (BOOL)hasSelector:(SEL)selector
{
    Class clazz = object_getClass(self);
    unsigned int methodCount = 0;
    Method* methodList = class_copyMethodList(clazz, &methodCount);
    for (unsigned int i = 0; i < methodCount; i++) {
        SEL thisSelector = method_getName(methodList[i]);
        if (thisSelector == selector) {
            free(methodList);
            return YES;
        }
    }
    free(methodList);
    return NO;
}
@end
















