//
//  ViewController.m
//  NetworkDemo
//
//  Created by xygj on 2018/8/20.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLSessionDelegate, NSURLSessionDownloadDelegate>

@end

@implementation ViewController

/*
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    NSString *range = [NSString stringWithFormat:@"bytes=%d-", 0];
    [request setValue:range forHTTPHeaderField:@"Range"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request];
    [downloadTask resume];
}


@end
