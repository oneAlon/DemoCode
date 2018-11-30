//
//  YADisplayLinkManager.m
//  FpsDemo
//
//  Created by xygj on 2018/9/10.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import "YADisplayLinkManager.h"
#import <QuartzCore/CoreAnimation.h>

@interface YADisplayLinkManager()

@property (nonatomic ,assign) CGFloat scheduleTimes;
@property (nonatomic ,assign) CFTimeInterval timestamp;

@end

@implementation YADisplayLinkManager

- (instancetype)init {
    if (self = [super init]) {
        self.scheduleTimes = 0;
        self.timestamp = 0;
        CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLickTest:)];
        [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}



- (void)displayLickTest:(CADisplayLink *)dispalyLink {
    
    // 记录调用次数
    _scheduleTimes++;
    
    // 记录当前时间
    if (_timestamp == 0) {
        _timestamp = dispalyLink.timestamp;
    }
    
    // 记录时间间隔
    CFTimeInterval timePassed = dispalyLink.timestamp - _timestamp;
    
    // 如果时间间隔为1s
    if(timePassed >= 1.f){
        CGFloat fps = _scheduleTimes/timePassed;
        printf("=====fps:%.1f---scheduleTimes:%f\n", fps, _scheduleTimes);
        
        //reset
        _timestamp = dispalyLink.timestamp;
        _scheduleTimes = 0;
    }
}

dispatch_async(monitor_queue(), ^{
    CADisplayLink * displayLink = [CADisplayLink displayLinkWithTarget: self selector: @selector(screenRenderCall)];
    [self.displayLink invalidate];
    self.displayLink = displayLink;
    
    [self.displayLink addToRunLoop: [NSRunLoop currentRunLoop] forMode: NSDefaultRunLoopMode];
    CFRunLoopRunInMode(kCFRunLoopDefaultMode, CGFLOAT_MAX, NO);
});

- (void)screenRenderCall {
    __block BOOL flag = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        flag = NO；
        dispatch_semaphore_signal(self.semphore);
    });
    dispatch_wait(self.semphore, 16.7 * NSEC_PER_MSEC);
    if (flag) {
        if (++self.timeOut < RESPONSE_THRESHOLD) { return; }
        [LXDBacktraceLogger lxd_logMain];
    }
    self.timeOut = 0;
}

@end
