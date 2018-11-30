//
//  YAPerson.h
//  BlockDemo
//
//  Created by xygj on 2018/8/20.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YAPerson : NSObject

@property (nonatomic ,copy) void(^printPersonName)(NSString *);

@end
