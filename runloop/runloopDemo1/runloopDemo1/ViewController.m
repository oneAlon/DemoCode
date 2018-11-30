//
//  ViewController.m
//  runloopDemo1
//
//  Created by xygj on 2018/7/27.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import "ViewController.h"
#import "YAThread.h"

@interface ViewController ()
@property (nonatomic ,strong) YAThread *thread;
@end

@implementation ViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _thread = [[YAThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    _thread = [[YAThread alloc] initWithBlock:^{
        [self run];
    }];
    [_thread start];
    
//    NSTimer *timer1 = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"%@", timer);
//    }];
//    [timer1 fire];
    
    [self runTimerOnSubThread];
}

#pragma mark - 应用测试
- (void)run {
    [[NSRunLoop currentRunLoop] addPort:[NSPort new] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    [self addRunLoopObserver];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self performSelector:@selector(test) onThread:_thread withObject:nil waitUntilDone:NO];
//    [self performSelector:@selector(test) withObject:nil afterDelay:0.5];
    
}

- (void)test{
    
}

- (void)runTimerOnSubThread{
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.f repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"%@", timer);
    }];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [timer fire];
}


#pragma mark - 线程不死

- (void)threadLive{
    YAThread *thread = [[YAThread alloc] initWithBlock:^{
        NSLog(@"%@", [NSThread currentThread]);
        // runloop必须有一个 timer source observer 才保证不退出
        [[NSRunLoop currentRunLoop] addPort:[NSPort new] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];

    }];

    [thread start];
}

#pragma mark  监听
// 添加一个监听者
- (void)addRunLoopObserver {
    
    // 1. 创建监听者
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"进入RunLoop");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"即将处理Timer事件");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"即将处理Source事件");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"即将休眠");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"被唤醒");
                break;
            case kCFRunLoopExit:
                NSLog(@"退出RunLoop");
                break;
            default:
                break;
        }
    });
    
    // 2. 添加监听者
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopCommonModes);
    //    CFRelease(observer);
}


@end
