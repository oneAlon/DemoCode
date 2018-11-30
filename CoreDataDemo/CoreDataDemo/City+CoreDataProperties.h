//
//  City+CoreDataProperties.h
//  CoreDataDemo
//
//  Created by xygj on 2018/10/9.
//  Copyright © 2018 xygj. All rights reserved.
//
//

#import "City+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface City (CoreDataProperties)

+ (NSFetchRequest<City *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *cityName;
@property (nullable, nonatomic, copy) NSString *cityId;

@end

NS_ASSUME_NONNULL_END
