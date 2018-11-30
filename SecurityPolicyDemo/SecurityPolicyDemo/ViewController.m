//
//  ViewController.m
//  SecurityPolicyDemo
//
//  Created by OneAlon on 2018/1/26.
//  Copyright © 2018年 OneAlon. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>

/**
 检测证书是否可信
 */
static BOOL checkServerCer(SecTrustRef serverTrust){
    SecTrustResultType result;
    // 使用系统的方法验证正式是否有效
    // 也可以使用自定义的方法验证证书, 比如从serverTrust中取出证书链,  遍历证书链, 看我们包里有没有和证书链中的证书相匹配的证书, 如果有说明证书有效.
    SecTrustEvaluate(serverTrust, &result);
    if (result == kSecTrustResultProceed || result == kSecTrustResultUnspecified) {
        return YES;
    }
    return NO;
}

/**
 获取服务器证书
 */
static NSArray * getServerCers(SecTrustRef serverTrust){
    // 获取serverTrust中的服务器证书个数
    CFIndex count = SecTrustGetCertificateCount(serverTrust);
    NSMutableArray *cerArray = [NSMutableArray arrayWithCapacity:(NSUInteger)count];
    for (CFIndex i = 0; i < count; i++) {
        // 获取到证书
        SecCertificateRef certificate = SecTrustGetCertificateAtIndex(serverTrust, i);
        [cerArray addObject:(__bridge NSData *)SecCertificateCopyData(certificate)];
    }
    return cerArray;
}

static BOOL checkOurServerCer(SecTrustRef serverTrust, NSArray *serverCerArray){
    return YES;
}

@interface ViewController ()<NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate>
/**
 *  是否使用自建证书
 */
@property (nonatomic ,assign) BOOL userSelfCer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)requestButtonClick:(id)sender {
    NSString *url = @"http://testapi.51nbapi.com/mapi/bsappconfig/dict_type/queryListByParam.json?channelCode=CREDIT_BUTLER&instanceCode=USER_BASIC_DATA";
    NSDictionary *dict = @{@"key1" : @"name1", @"key2" : @"name2", @"key3" : @"哈哈"};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:url parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"下载进度--->%@", downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"响应结果--->%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"错误信息--->%@", error);
    }];
}


- (IBAction)buttonClick:(id)sender {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"https://testapi.51nbapi.com/mapi/cspuser/user_rate/detail.json?userId=23" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"下载进度--->%@", downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"响应结果--->%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"错误信息--->%@", error);
    }];
}

- (IBAction)originalButtonClick:(id)sender {
    
    self.userSelfCer = YES;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"https://testapi.51nbapi.com/mapi/cspuser/user_rate/detail.json?userId=23"]];
    [dataTask resume];
}


#pragma mark - 代理方法
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler
{
    NSLog(@"接收到的挑战-->%@", challenge);
    // challenge.protectionSpace 授权保护空间
    // challenge.protectionSpace.serverTrust 信任对象
    NSLog(@"%@", challenge.protectionSpace.realm);
    NSLog(@"%@", challenge.protectionSpace.authenticationMethod);
    NSLog(@"%@", challenge.protectionSpace.serverTrust);
    
    // 获取服务器证书
    NSArray *array = getServerCers(challenge.protectionSpace.serverTrust);
    for (NSData *data in array) {
        NSLog(@"服务器证书:%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }
    
    // 处理方式
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    // 客户端证书
    __block NSURLCredential *credential = nil;
    
    // 个人理解为, protectionSpace就是保存的从服务器得到的各种信息.
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        // 使用自建证书
        if (self.userSelfCer) {
            // 检验服务器证书
            if (checkServerCer(challenge.protectionSpace.serverTrust)) {
                credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
                if (credential) {
                    disposition = NSURLSessionAuthChallengeUseCredential;
                }else{
                    disposition = NSURLSessionAuthChallengePerformDefaultHandling;
                }
            }else{
                // 服务器证书不可信
                disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
            }
        }else{
            // 不使用自建证书
            disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        }
    }else{
        disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
    }
    
    completionHandler(disposition, credential);
}

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    NSError *error;
    id responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    NSLog(@"数据--->%@", responseObject);
}












@end
