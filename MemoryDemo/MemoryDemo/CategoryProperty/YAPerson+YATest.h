//
//  YAPerson+YATest.h
//  MemoryDemo
//
//  Created by xygj on 2018/8/14.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import "YAPerson.h"

@interface YAPerson (YATest)

@property (nonatomic ,copy) void(^testBlockName)(void);

@end
