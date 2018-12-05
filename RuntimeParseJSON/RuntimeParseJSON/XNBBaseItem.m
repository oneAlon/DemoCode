//
//  XNBBaseItem.m
//  RuntimeParseJSON
//
//  Created by xygj on 2018/12/3.
//  Copyright © 2018 xygj. All rights reserved.
//

#import "XNBBaseItem.h"

@implementation XNBBaseItem

- (void)parseJSONValue:(NSDictionary *)jsonValue {
    if (jsonValue && [jsonValue isKindOfClass:[NSDictionary class]]) {
        [self willAutoParse];
        
        __strong NSDictionary *dictForJsonValue = jsonValue;
        
        Class cls = [self class];
        while (cls != [XNBBaseItem class]) {
            // 获取属性列表
            NSDictionary *propertiesList = [cls propertiesListWithRuntime];
            // 遍历属性列表中的key, 从字典中取数据并且给属性赋值
            for (NSString *key in propertiesList.allKeys) {
                // 获取key类型
                NSString *typeString = [propertiesList objectForKey:key];
                // 使用哪个key从字典中取值
                NSString *jsonKey = key;// 例如id 客户端会修改为其他的contentID
                // 通过key从字典取值
                id jsonKeyValue = [dictForJsonValue objectForKey:jsonKey];
                // 将取到的值设置到属性上
                if (jsonKeyValue && typeString && key) {
                    [self setJsonValue:jsonKeyValue propertyType:typeString propertyName:key];
                }
            }
        }
        
        [self afterAutoParse];
    }else {
        NSLog(@"不能解析字典类型以外的数据");
    }
}


- (void)willAutoParse {
    
}

- (void)afterAutoParse {
    
}

#pragma mark - private


- (void)setJsonValue:(id)jsonValue propertyType:(NSString *)propertyType propertyName:(NSString *)propertyName {
    if (!(jsonValue && propertyType && propertyName)) return;
    
    id value = nil;
    
    Class propertyCls = NSClassFromString(propertyType);
    // 如果里边还是模型
    if ([propertyCls isSubclassOfClass:[XNBBaseItem class]]) {
        if ([jsonValue isKindOfClass:[NSDictionary class]]) {
            XNBBaseItem *baseItem = [[propertyCls alloc] init];
            [baseItem parseJSONValue:jsonValue];
            value = baseItem;
        }
    }
    
    [self setValue:value forKey:propertyName];
}

+ (NSDictionary *)propertiesListWithRuntime{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    return dict;
}

@end
