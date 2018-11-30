//
//  Person.m
//  KVODemo
//
//  Created by OneAlon on 2018/4/12.
//  Copyright © 2018年 OneAlon. All rights reserved.
//

#import "Person.h"

@implementation Person

-(int)age{
    return 12;
}

-(void)willChangeValueForKey:(NSString *)key{
    [super willChangeValueForKey:key];
    NSLog(@"willChangeValueForKey");
}

-(void)didChangeValueForKey:(NSString *)key{
    [super didChangeValueForKey:key];
    NSLog(@"didChangeValueForKey");
}

-(Class)class{
    return NSClassFromString(@"MPerson");
}
@end
