//
//  YATimerViewController.m
//  MemoryDemo
//
//  Created by xygj on 2018/8/9.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import "YATimerViewController.h"
#import "YAProxy.h"

@interface YATimerViewController ()

@property (nonatomic ,weak) NSTimer *timer1;

@end

@implementation YATimerViewController

- (void)dealloc {
    NSLog(@"%s", __func__);
    
    [_timer1 invalidate];
    _timer1 = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"定时器demo";
    self.view.backgroundColor = [UIColor whiteColor];
    
//    NSTimer
    
    _timer1 = [NSTimer scheduledTimerWithTimeInterval:1.0f target:[YAProxy proxyWithTarget:self] selector:@selector(timer1Test:) userInfo:nil repeats:YES];
    
//    NSTimer *timer2 = [NSTimer timerWithTimeInterval:1.0f target:[YAProxy proxyWithTarget:self] selector:@selector(timer2Test) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:timer2 forMode:NSDefaultRunLoopMode];

    
    
//    CADisplayLink *dispalyLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkTest)];
//    [dispalyLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
}


- (void)displayLinkTest {
    NSLog(@"%s", __func__);
}

- (void)timer1Test:(NSTimer *)timer {
    NSLog(@"%s", __func__);
}

- (void)timer2Test {
    NSLog(@"%s", __func__);
}

- (void)timer3Test {
    NSLog(@"%s", __func__);
}



@end
