//
//  YAPerson.m
//  CacheDemo
//
//  Created by xygj on 2018/10/8.
//  Copyright © 2018 xygj. All rights reserved.
//

#import "YAPerson.h"

@implementation YAPerson

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
}

@end
