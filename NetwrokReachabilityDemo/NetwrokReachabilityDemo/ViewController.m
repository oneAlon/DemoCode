//
//  ViewController.m
//  NetwrokReachabilityDemo
//
//  Created by OneAlon on 2018/1/4.
//  Copyright © 2018年 OneAlon. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    AFNetworkReachabilityManager *m = [AFNetworkReachabilityManager sharedManager];
    [m setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"状态----%@", AFStringFromNetworkReachabilityStatus(status));
    }];
    [m startMonitoring];
}

-(void)startLoadData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 350.0f;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];
    
    NSURLSessionDataTask *dataTask = [manager GET:@"" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@", downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    [dataTask suspend];
}


@end
