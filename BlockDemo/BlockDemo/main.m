//
//  main.m
//  BlockDemo
//
//  Created by xygj on 2018/8/20.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        // 没有捕获变量, global
        __block int age = 10;
        void (^blockName)(void) = ^(){
            NSLog(@"hello world!---%d", age);
        };
        blockName();
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
