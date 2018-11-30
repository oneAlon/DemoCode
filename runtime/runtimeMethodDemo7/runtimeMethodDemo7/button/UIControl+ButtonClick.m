//
//  UIControl+ButtonClick.m
//  runtimeMethodDemo7
//
//  Created by xygj on 2018/7/19.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import "UIControl+ButtonClick.h"
#import <objc/runtime.h>

@implementation UIControl (ButtonClick)

+ (void)load{
    Method originMethod = class_getInstanceMethod([self class], @selector(sendAction:to:forEvent:));
    Method exchangeMethod = class_getInstanceMethod([self class], @selector(ya_sendAction:to:forEvent:));
    method_exchangeImplementations(originMethod, exchangeMethod);
}


- (void)ya_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    // 在这里实现自己的代码
    NSLog(@"%@--%@", NSStringFromSelector(action), target);
    
    // 表面看起来是死循环, 但是方法的实现已经交换了, 所以不会造成死循环.
    [self ya_sendAction:action to:target forEvent:event];
}

@end
