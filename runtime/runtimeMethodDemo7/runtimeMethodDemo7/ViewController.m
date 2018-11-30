//
//  ViewController.m
//  runtimeMethodDemo7
//
//  Created by xygj on 2018/7/19.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import "ViewController.h"

/*
 完成几个需求:
 1. 拦截所有按钮的点击
    1.1 找到需要hook的方法 -[UIControl sendAction:to:forEvent:] + 67
 
 
 2. 拦截dict array的添加和获取
    1.1 添加nil到数组中 -[__NSArrayM insertObject:atIndex:] + 1273
 
    2.1 添加Nil到字典中 -[__NSDictionaryM setObject:forKeyedSubscript:] + 1026
 */

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)buttonClick1:(id)sender {
    NSLog(@"%s", __func__);
}
- (IBAction)buttonClick2:(id)sender {
    NSLog(@"%s", __func__);
}
- (IBAction)buttonClick3:(id)sender {
    NSLog(@"%s", __func__);
}
- (IBAction)addNilToArray:(id)sender {
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@"name"];
    [array addObject:nil];
    NSLog(@"%@", array);
}
- (IBAction)getNilFromArray:(id)sender {
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@"name"];
    [array objectAtIndex:5];
    NSLog(@"%@", array);
    
    NSArray *array2 = @[@"1", @"2"];
    NSString *str = [array2 objectAtIndex:5];
    NSLog(@"str--%@", str);
}
- (IBAction)addNilToDict:(id)sender {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"name"] = @"name1";
    dict[nil] = @"name2";
    NSLog(@"%@", dict);
}
- (IBAction)getNilFromDict:(id)sender {
    NSString *str = nil;
    NSDictionary *dict = @{@"name1" : @"name1",
                           @"name2" : @"name2",
                           @"name3" : @"name3",
                           @"name4" : @"name4",
                           @"name6" : str,
                           @"name5" : @"name5"};
//    NSString *value =  dict[str];
    NSLog(@"%@", dict);
}


@end
