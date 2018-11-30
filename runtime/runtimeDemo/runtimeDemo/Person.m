//
//  Person.m
//  runtimeDemo
//
//  Created by xygj on 2018/7/6.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import "Person.h"

#define  tallMask (1)
#define  richMask (1 << 1)
#define  handsomeMask (1 << 7)

@implementation Person{
    union {
        char bits;
        // 结构体无实质作用, 只是为了代码的可读性
        struct{
            char tall : 1;
            char rich : 1;
            char handsome : 1;
        };
    }_tallRichHandsome;
}

- (void)setTall:(BOOL)tall{
    if (tall) {
        // 如果需要将值置为1, 使用按位或(任何数与1或, 都是1)
        _tallRichHandsome.bits |= tallMask;
    }else{
        // 如果需要将值置为0, 将tallMask按位取反(0b1111 1110), 再按位与(任何数与0与, 都是0)
        _tallRichHandsome.bits &= ~tallMask;
    }
}

- (BOOL)tall{
    // _tallRichHandsome.bits & tallMask的值为0b0000 0001, 也就是1, 使用!!将值改为bool类型.
    // 比如如果_tallRichHandsome.bits & richMask的值为0b0000 0010, 也就是2, 对!2 = 0, !0 = 1, 即转为了bool类型
    return !!(_tallRichHandsome.bits & tallMask);
}

- (void)setRich:(BOOL)rich{
    if (rich) {
        _tallRichHandsome.bits |= richMask;
    }else{
        _tallRichHandsome.bits &= ~richMask;
    }
}

- (BOOL)rich{
    return (_tallRichHandsome.bits & richMask);
}

- (void)setHandsome:(BOOL)handsome{
    if (handsome) {
        _tallRichHandsome.bits |= handsomeMask;
    }else{
        _tallRichHandsome.bits &= ~handsomeMask;
    }
}

- (BOOL)handsome{
    return (_tallRichHandsome.bits & handsomeMask);
}

- (void)test{
    NSLog(@"%s", __func__);
}
@end
