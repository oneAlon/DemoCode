//
//  Cat.m
//  runtimeDemo2
//
//  Created by xygj on 2018/7/13.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import "Cat.h"

@implementation Cat
- (void)personInstanceMethod{
    NSLog(@"%s", __func__);
}
- (void)catInstanceMethod{
    NSLog(@"%s", __func__);
}
@end
