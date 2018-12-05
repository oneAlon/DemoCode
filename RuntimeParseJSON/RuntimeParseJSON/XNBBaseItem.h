//
//  XNBBaseItem.h
//  RuntimeParseJSON
//
//  Created by xygj on 2018/12/3.
//  Copyright © 2018 xygj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XNBBaseItem : NSObject

// 字典转模型
- (void)parseJSONValue:(NSDictionary *)jsonValue;

// 字典转模型之前和之后的操作
- (void)willAutoParse;
- (void)afterAutoParse;

@end

NS_ASSUME_NONNULL_END
