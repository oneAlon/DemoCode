//
//  ViewController.m
//  CacheDemo
//
//  Created by xygj on 2018/10/8.
//  Copyright © 2018 xygj. All rights reserved.
//

#import "ViewController.h"
#import "YAPerson.h"

@interface ViewController ()

@end

@implementation ViewController

// iOS中的缓存
// 1. NSUserDefaults
// 2. plist(属性列表)
// 3. NSKeyedArchiver(归档)
// 4. SQLit3
// 5. CoreData

// 沙盒: iOS程序默认只能访问程序自己的目录, 这个目录就叫做沙盒
/*
     应用程序包: 存放引用程序的源文件, 包括资源文件和可执行文件.
     Documents: iTunes会自动同步此文件中的内容, 适合存储重要的数据.
     Libary
         Cache: iTunes不会同步此文件夹, 适合存储体积比较大的非重要的数据.
         Perferences: iTunes会自动同步此文件中的内容, 通常保存引用的设置信息.
        ...
     tmp: 临时数据, 系统n可能再应用没运行时就删除该目录下的数据.
 */

- (void)viewDidLoad {
    [super viewDidLoad];

//    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//    NSLog(@"documentsPath: %@", documentsPath);
    
//    [self NSUserDefaultsTest];
//    [self plistTest];
//    [self archiverTest];
//    [self cachesTest];
    [self coreDataTest];
}

// 包内容
- (void)bundleTest {
    NSString *bundlePath =  [[NSBundle mainBundle] bundlePath];
    NSLog(@"应用程序目录: %@", bundlePath);
}

//1. NSUserDefaults
- (void)NSUserDefaultsTest {
    
    // 偏好设置, 将所有的数据保存在同一个文件中.
    // 不能存储自定义的对象类型.
    [[NSUserDefaults standardUserDefaults] setObject:@"testValue" forKey:@"testKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

// 2. plist文件
- (void)plistTest {
    /*
    NSArray, NSMutableArray
    NSDictionary, NSMutableDictionary
    NSData, NSMutableData
    NSNumber
    NSDate
     */
    // 只有这几种指定的类型才能存储到plist文件中.
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *plistPath = [path stringByAppendingPathComponent:@"plisttest.plist"];
    
    // 存储
    NSArray *array = @[@"a", @"b", @"c"];
    [array writeToFile:plistPath atomically:YES];
    
    // 读取
    NSArray *result = [NSArray arrayWithContentsOfFile:plistPath];
    NSLog(@"从plist文件中读取到的数据: %@", result);
    
}

// 归档
- (void)archiverTest {
    // 1.遵循NSCoding协议
    // 2. 实现方法
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [path stringByAppendingPathComponent:@"person.data"];
    
    YAPerson *person1 = [[YAPerson alloc] init];
    person1.name = @"OneAlon";
    
    // 存数据
    [NSKeyedArchiver archiveRootObject:person1 toFile:filePath];
    
    // 取数据
    YAPerson *person2 = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"归档读取的数据: %@", person2.name);
}

- (void)cachesTest {
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [path stringByAppendingPathComponent:@"com.51nbapi.cacheTest.plist"];
    
    NSDictionary *dict = @{
                           @"name" : @"OneAlon"
                           };
    [dict writeToFile:filePath atomically:YES];
    
}

// 数据库, FMDB
- (void)sqlitTest {
    
}

// coreData
- (void)coreDataTest {
    
}

@end
