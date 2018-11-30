//
//  City+CoreDataProperties.m
//  CoreDataDemo
//
//  Created by xygj on 2018/10/9.
//  Copyright © 2018 xygj. All rights reserved.
//
//

#import "City+CoreDataProperties.h"

@implementation City (CoreDataProperties)

+ (NSFetchRequest<City *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"City"];
}

@dynamic cityName;
@dynamic cityId;

@end
