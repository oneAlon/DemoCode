//
//  ViewController.m
//  RunLoopDemo
//
//  Created by OneAlon on 2018/2/27.
//  Copyright © 2018年 OneAlon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLConnectionDelegate>

@end

@implementation ViewController

#pragma mark - begin
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRunLoopObserver];
}

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
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer, kCFRunLoopCommonModes);
    //    CFRelease(observer);
}

#pragma mark - GCD
- (IBAction)GCDClick:(id)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"制定了");
    });
}

#pragma mark - 定时器
- (IBAction)timerClick:(id)sender {
    NSTimer *timer = [NSTimer timerWithTimeInterval:3 repeats:NO block:^(NSTimer * _Nonnull timer) {
        NSLog(@"执行了定时器");
    }];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
}

#pragma mark - 线程
- (IBAction)threadDemoClick:(id)sender {
    [self performSelectorInBackground:@selector(multiThread) withObject:nil];
}
- (void)multiThread
{
    if (![NSThread isMainThread]) {
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.baidu.com"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
        [request setHTTPMethod: @"GET"];
        NSURLConnection *connection =[[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:YES];
        [connection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop] run];
        [connection start];
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
}
                        
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    NSLog(@"network callback");
    
}

@end
