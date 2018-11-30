//
//  YAGCDTimerViewController.m
//  MemoryDemo
//
//  Created by xygj on 2018/8/13.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import "YAGCDTimerViewController.h"

@interface YAGCDTimerViewController ()

@property (strong, nonatomic) dispatch_source_t timer;

@end

@implementation YAGCDTimerViewController

- (void)dealloc {
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"定时器demo";
    self.view.backgroundColor = [UIColor whiteColor];

}

- (void)test {
    
    //DISPATCH_QUEUE_SERIAL DISPATCH_QUEUE_CONCURRENT
    // 串行队列 FIFO 先进先出 一次执行一个
    // 并发队列 FIFO 先进先出 如果有资源可以同时执行
    // 如果不是在ARC下, 需要执行dispatch_release释放
    // 在queue中执行的任务会对queue强引用, 所以在任务执行完成以后queue才会被释放.
    dispatch_queue_t queue = dispatch_queue_create("queueName", DISPATCH_QUEUE_SERIAL);
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
    uint64_t interval = 1.0 * NSEC_PER_SEC;
    
    dispatch_source_set_timer(timer, start, interval, 0);
    
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"---");
    });
    _timer = timer;
    
    // 启动定时器
    dispatch_resume(timer);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_source_set_timer(timer, start, 3.0 * NSEC_PER_SEC, 0);
    });
}


@end
