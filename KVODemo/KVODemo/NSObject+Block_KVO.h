//
//  NSObject+Block_KVO.h
//  KVODemo
//
//  Created by OneAlon on 2018/5/8.
//  Copyright © 2018年 OneAlon. All rights reserved.
//  使用Block实现KVO

#import <Foundation/Foundation.h>

typedef void(^PGObservingBlock)(id observedObject, NSString *observedKey, id oldValue, id newValue);

@interface NSObject (Block_KVO)

- (void)addObserver:(NSObject *)observer forKey:(NSString *)key withBlock:(PGObservingBlock)finishBlock;

@end
