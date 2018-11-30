//
//  ViewController.m
//  ResponseChainDemo
//
//  Created by xygj on 2018/10/11.
//  Copyright © 2018 xygj. All rights reserved.
//

#import "ViewController.h"
#import "AView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AView *view = [[AView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGes)];
    [view addGestureRecognizer:ges];
}

- (void)tapGes {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}


@end
