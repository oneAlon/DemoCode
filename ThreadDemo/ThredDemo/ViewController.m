//
//  ViewController.m
//  ThredDemo
//
//  Created by OneAlon on 2017/12/24.
//  Copyright © 2017年 OneAlon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - touchesBegan

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self operationTest6];
}

#pragma mark - 线程死锁

- (void)interview1 {
    NSLog(@"执行任务1");
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"执行任务2");
    });
    NSLog(@"执行任务3");
}

- (void)interview2 {
    NSLog(@"执行任务1");
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"执行任务2");
    });
    NSLog(@"执行任务3");
}

- (void)interview3
{
    NSLog(@"执行任务1");
    dispatch_queue_t queue = dispatch_queue_create("myqueu", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"执行任务2-%@", [NSThread currentThread]);
        dispatch_sync(queue, ^{
            NSLog(@"执行任务3");
        });
        NSLog(@"执行任务4");
    });
    NSLog(@"执行任务5");
}

- (void)interview4
{
    NSLog(@"执行任务1");
    dispatch_queue_t queue = dispatch_queue_create("myqueu", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2 = dispatch_queue_create("myqueu2", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"执行任务2");
        dispatch_sync(queue2, ^{
            NSLog(@"执行任务3");
        });
        NSLog(@"执行任务4");
    });
    NSLog(@"执行任务5");
}

- (void)interview5
{
    NSLog(@"执行任务1");
    dispatch_queue_t queue = dispatch_queue_create("myqueu", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"执行任务2");
        dispatch_sync(queue, ^{
            NSLog(@"执行任务3");
        });
//        sleep(4);
        NSLog(@"执行任务4");
    });
    NSLog(@"执行任务5");
}

- (void)interview6 {
    NSLog(@"执行任务1");
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_queue_t queue2 = dispatch_get_global_queue(0, 0);
//    dispatch_queue_t queue = dispatch_queue_create("con.yinronghui.queue2", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"执行任务2");
    });
    NSLog(@"执行任务3");
}

#pragma mark - GCD

- (void)gcdTest {
    
    /*
     全局并发队列:
     1. 全局并发队列整个进程共享, 有高 中 低 后台 四个优先级
     2. 手动创建的队列可以取消, 全局队列不能取消(Calls to the dispatch_suspend, dispatch_resume, and dispatch_set_context functions have no effect on the returned queues.)
     3. 全局并发队列按照先进先出的原则执行, 但是它不会等待执行完成的结果(The global concurrent queues invoke blocks in FIFO order but do not wait for their completion, allowing multiple blocks to be invoked concurrently.)
     */
    
    /*
     全局队列和手动创建的队列区别:
     1. 全局并发队列按照先进先出的原则执行, 但是它不会等待执行完成的结果(The global concurrent queues invoke blocks in FIFO order but do not wait for their completion, allowing multiple blocks to be invoked concurrently.)
     2. 手动创建的队列可以取消, 全局队列不能取消(Calls to the dispatch_suspend, dispatch_resume, and dispatch_set_context functions have no effect on the returned queues.)
     3.
     */
}

- (void)gcdTest1 {
    
    // 串行队列
    dispatch_queue_t queue1 = dispatch_queue_create("com.onealon.gcdTest1", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue1, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"同步执行-串行队列-任务1-%@", [NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue1, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"同步执行-串行队列-任务2-%@", [NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue1, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"同步执行-串行队列-任务3-%@", [NSThread currentThread]);
        }
    });
    
}

- (void)gcdTest2 {
    
    // 串行队列
    dispatch_queue_t queue1 = dispatch_queue_create("com.onealon.gcdTest1", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue1, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"同步执行-串行队列-任务1-%@", [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue1, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"同步执行-串行队列-任务2-%@", [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue1, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"同步执行-串行队列-任务3-%@", [NSThread currentThread]);
        }
    });
    
}

- (void)gcdTest3 {
    
    // 并发队列
    dispatch_queue_t queue1 = dispatch_queue_create("com.onealon.gcdTest1", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue1, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"同步执行-串行队列-任务1-%@", [NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue1, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"同步执行-串行队列-任务2-%@", [NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue1, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"同步执行-串行队列-任务3-%@", [NSThread currentThread]);
        }
    });
    
}

- (void)gcdTest4 {
    
    // 并发队列
    dispatch_queue_t queue1 = dispatch_queue_create("com.onealon.gcdTest1", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue1, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"同步执行-串行队列-任务1-%@", [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue1, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"同步执行-串行队列-任务2-%@", [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue1, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"同步执行-串行队列-任务3-%@", [NSThread currentThread]);
        }
    });
    
}

// 一次性函数
- (void)gcdTest5 {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"只执行了一次哦");
    });
}

// 延迟函数
- (void)gcdTest6 {
    /*
     等到指定的时间将任务block异步添加到指定的队列中.
     Enqueue a block for execution at the specified time.
     This function waits until the specified time and then asynchronously adds block to the specified queue.
     Passing DISPATCH_TIME_NOW as the when parameter is supported, but is not as optimal as calling dispatch_async instead. Passing DISPATCH_TIME_FOREVER is undefined.
     */
    NSLog(@"begin---");
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), queue, ^{
        NSLog(@"延迟函数--%@", [NSThread currentThread]);
    });
    NSLog(@"end---");
}

// 栅栏函数
- (void)gcdTest7 {
    
    /*
     Submits a barrier block for asynchronous execution and returns immediately.
     Calls to this function always return immediately after the block has been submitted and never wait for the block to be invoked. When the barrier block reaches the front of a private concurrent queue, it is not executed immediately. Instead, the queue waits until its currently executing blocks finish executing. At that point, the barrier block executes by itself. Any blocks submitted after the barrier block are not executed until the barrier block completes.
     The queue you specify should be a concurrent queue that you create yourself using the dispatch_queue_create function. If the queue you pass to this function is a serial queue or one of the global concurrent queues, this function behaves like the dispatch_async function.
     注意:
        栅栏函数中拦截的任务必须和耗时任务在同一个队列中.
        栅栏函数中的队列必须是使用dispatch_queue_create手动创建的并发队列
        如果是串行队列或者全局并发队列, 那么栅栏函数就相当于dispatch_async函数, 不会起到拦截效果.
     */
    
    NSLog(@"begin---");
    
    // 手动创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("com.onealon.queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"耗时任务1--%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"耗时任务2--%@", [NSThread currentThread]);
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"耗时任务1和任务2执行完成以后--任务3--%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"任务4--%@", [NSThread currentThread]);
    });
    
    NSLog(@"end---");
}

// 队列组
- (void)gcdTest8 {
    
    /*
     Submits a block to a dispatch queue and associates the block with the specified dispatch group.
     Submits a block to a dispatch queue and associates the block object with the given dispatch group. The dispatch group can be used to wait for the completion of the block objects it references.
     */
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("com.onealon.name", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue2 = dispatch_queue_create("com.onealon.name2", DISPATCH_QUEUE_CONCURRENT);
    
    NSLog(@"begin---");
    
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"任务1-%@",[NSThread currentThread]);
        }
    });
    
    /*
     Schedules a block object to be submitted to a queue when a group of previously submitted block objects have completed.
     当group中的任务执行完成以后, 会执行block
     如果group中的任务为空, 任务block会立即执行
     
     This function schedules a notification block to be submitted to the specified queue when all blocks associated with the dispatch group have completed. If the group is empty (no block objects are associated with the dispatch group), the notification block object is submitted immediately.
     When the notification block is submitted, the group is empty. The group can either be released with dispatch_release or be reused for additional block objects. See dispatch_group_async for more information.
     */
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"任务2-%@",[NSThread currentThread]);
        }
    });
    
    dispatch_group_notify(group, queue2, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"任务3-%@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"end---");
}


#pragma mark - NSOperation

- (void)operationTest1 {
    
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"任务1-%@",[NSThread currentThread]);
        }
    }];
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"任务2-%@",[NSThread currentThread]);
        }
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 1;
    [queue addOperation:operation1];
    [queue addOperation:operation2];
}

- (void)operationTest2 {
    
    NSInvocationOperation *operation1 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operation1Selector) object:nil];
    
    
    NSInvocationOperation *operation2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operation2Selector) object:nil];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation1];
    [queue addOperation:operation2];
}

- (void)operation1Selector {
    for (int i = 0; i < 3; i++) {
        NSLog(@"任务1-%@",[NSThread currentThread]);
    }
}

- (void)operation2Selector {
    for (int i = 0; i < 3; i++) {
        NSLog(@"任务2-%@",[NSThread currentThread]);
    }
}

// 匿名操作
- (void)operationTest3 {
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"任务1-%@",[NSThread currentThread]);
        }
    }];
    
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"任务2-%@",[NSThread currentThread]);
        }
    }];

}

// 取消操作
- (void)operationTest5 {
    
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"任务1-%@",[NSThread currentThread]);
        }
    }];
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"任务2-%@",[NSThread currentThread]);
        }
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 取消某一个操作
//    [operation1 cancel];
    
    // 暂停队列
    [queue setSuspended:YES];

    // 取消队列中的操作
//    [queue cancelAllOperations];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [queue setSuspended:NO];
    });
    
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    
}

// 设置依赖
- (void)operationTest4 {
    
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"任务1-%@",[NSThread currentThread]);
        }
    }];
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"任务2-%@",[NSThread currentThread]);
        }
    }];
    
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"任务3-%@",[NSThread currentThread]);
        }
    }];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [operation2 addDependency:operation3];
    
    [queue addOperation:operation1];
    [queue addOperation:operation2];
    [queue addOperation:operation3];
    
}

// 线程间通讯
- (void)operationTest6 {
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [queue addOperationWithBlock:^{
        NSLog(@"在子线程中执行--任务1--%@", [NSThread currentThread]);
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                NSLog(@"在主线程中执行--任务2--%@", [NSThread currentThread]);
        }];
    }];
    
}






@end
