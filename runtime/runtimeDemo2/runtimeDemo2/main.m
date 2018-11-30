//
//  main.m
//  runtimeDemo2
//
//  Created by xygj on 2018/7/12.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Person *p = [[Person alloc] init];
        [p personInstanceMethod];
    }
    return 0;
}
