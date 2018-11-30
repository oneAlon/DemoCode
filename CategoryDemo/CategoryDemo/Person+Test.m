//
//  Person+Test.m
//  CategoryDemo
//
//  Created by OneAlon on 2018/5/23.
//  Copyright © 2018年 OneAlon. All rights reserved.
//

#import "Person+Test.h"

@implementation Person (Test)

-(void)instanceMethod1{
    NSLog(@"Person (Test)---instanceMethod1");
}

-(void)instanceMethod2{
    NSLog(@"Person (Test)---instanceMethod2");
}

+(void)classMethod1{
    NSLog(@"Person (Test)---classMethod1");
}

-(void)run{
    NSLog(@"Person (Test)---run");
}
@end
