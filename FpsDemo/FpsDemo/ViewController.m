//
//  ViewController.m
//  FpsDemo
//
//  Created by xygj on 2018/9/10.
//  Copyright © 2018年 xygj. All rights reserved.
//

#import "ViewController.h"
#import "YADisplayLinkManager.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YADisplayLinkManager *manager = [[YADisplayLinkManager alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [cell.contentView addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"ic_funline_more"];
    imageView.backgroundColor = [UIColor redColor];
    imageView.frame = CGRectMake(10, 10, 30, 30);
    imageView.layer.cornerRadius = 15.f;
    imageView.clipsToBounds = YES;
    
    UIImageView *imageView1 = [[UIImageView alloc] init];
    [cell.contentView addSubview:imageView1];
    imageView1.image = [UIImage imageNamed:@"ic_funline_more"];
    imageView1.backgroundColor = [UIColor redColor];
    imageView1.frame = CGRectMake(50, 10, 30, 30);
    imageView1.layer.cornerRadius = 15.f;
    imageView1.clipsToBounds = YES;
    
    UIImageView *imageView2 = [[UIImageView alloc] init];
    [cell.contentView addSubview:imageView2];
    imageView2.image = [UIImage imageNamed:@"ic_funline_more"];
    imageView2.backgroundColor = [UIColor redColor];
    imageView2.frame = CGRectMake(90, 10, 30, 30);
    imageView2.layer.cornerRadius = 15.f;
    imageView2.clipsToBounds = YES;
    
    UIImageView *imageView3 = [[UIImageView alloc] init];
    [cell.contentView addSubview:imageView3];
    imageView3.image = [UIImage imageNamed:@"ic_funline_more"];
    imageView3.backgroundColor = [UIColor redColor];
    imageView3.frame = CGRectMake(130, 10, 30, 30);
    imageView3.layer.cornerRadius = 15.f;
    imageView3.clipsToBounds = YES;
    return cell;
}


@end
