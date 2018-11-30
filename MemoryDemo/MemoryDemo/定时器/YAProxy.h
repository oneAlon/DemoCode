//
//  YAProxy.h
//  MemoryDemo
//
//  Created by xygj on 2018/8/13.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YAProxy : NSProxy

+ (instancetype)proxyWithTarget:(id)target;

@end
