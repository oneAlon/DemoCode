//
//  Person+Test.h
//  CategoryDemo
//
//  Created by OneAlon on 2018/5/23.
//  Copyright © 2018年 OneAlon. All rights reserved.
//

#import "Person.h"

@protocol PersonTestProtocol

-(void)protocolTest;

@end

@interface Person (Test)<PersonTestProtocol>

/**
 *  name
 */
@property (nonatomic ,strong) NSString *testName;

-(void)instanceMethod1;
-(void)instanceMethod2;
+(void)classMethod1;

@end
