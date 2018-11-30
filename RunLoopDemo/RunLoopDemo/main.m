//
//  main.m
//  RunLoopDemo
//
//  Created by OneAlon on 2018/2/27.
//  Copyright © 2018年 OneAlon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        NSLog(@"程序开始");
        int result = UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        NSLog(@"程序结束");
        return result;
    }
}
