//
//  Person.h
//  runtimeDemo
//
//  Created by xygj on 2018/7/6.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic ,copy) NSString *name;

- (void)setTall:(BOOL)tall;
- (BOOL)tall;

- (void)setRich:(BOOL)rich;
- (BOOL)rich;

- (void)setHandsome:(BOOL)handsome;
- (BOOL)handsome;

- (void)test;

@end
