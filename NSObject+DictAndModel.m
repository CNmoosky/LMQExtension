//
//  NSObject+DictAndModel.m
//  MyExtension
//
//  Created by CNmoosky on 14-7-14.
//  Copyright (c) 2014年 CNmoosky. All rights reserved.
//

#import "NSObject+DictAndModel.h"

#import "NSObject+Element.h"

@implementation NSObject (DictAndModel)

#pragma mark - 私有方法

-(NSString *)keyWithIvarName:(NSString *)ivarName
{
    NSString *key = nil;
    if ([self respondsToSelector:@selector(replacedKeyFromIvarName)]) {
        key = self.replacedKeyFromIvarName[ivarName];
    }
    if (!key) key = ivarName;
    
    return key;
}

-(void)setKeyValues:(NSDictionary *)dict
{
    [self enumIvarsWithBlock:^(LMQIvar *ivar, BOOL *stop) {
        if (ivar.isComeFromFoundation) return ;
        NSString *key = [self keyWithIvarName:ivar.ivarName];
        id value = dict[key];
        if (!value) {
            value = dict[ivar.ivarName];
        }
        if ([value isKindOfClass:[NSNull class]]) {
            value = nil;
        }
        
        if (!value) return;
        if (ivar.type.typeClass && !ivar.type.isFromFoundation) {
            value = [ivar.type.typeClass modelWithKeyValues:value];
        }else if ([self respondsToSelector:@selector(objectClassInArray)]){
            Class modelClass = self.objectClassInArray[ivar.ivarName];
            if (modelClass && [value isKindOfClass:[NSString class]]) {
                
            }else if (modelClass){
                value = [modelClass modelArrayWithDictArray:value];
            }
        }
        ivar.ivarValue = value;
        
    }];
}

#pragma mark - DictToModel

+ (instancetype)modelWithKeyValues:(NSDictionary *)dict
{
    if (dict == nil) {
        return nil;
    }
    if (![dict isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    id model = [[self alloc]init];
    [model setKeyValues:dict];
    return model;
}

- (void)modelWithDict:(NSDictionary *)dict
{
    if (dict == nil) {
        return;
    }
    if (![dict isKindOfClass:[NSDictionary class]]) {
        return;
    }
    [self setKeyValues:dict];
}


#pragma mark - ModelToDict

- (NSDictionary *)toDictionary
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [self enumIvarsWithBlock:^(LMQIvar *ivar, BOOL *stop) {
        if (ivar.isComeFromFoundation) return ;
        
        id value = ivar.ivarValue;
        if (!value) return;
        if (ivar.type.typeClass && !ivar.type.isFromFoundation){
            value = [value toDictionary];
        }else if ([self respondsToSelector:@selector(objectClassInArray)]){
            Class modelClass = self.objectClassInArray[ivar.ivarName];
            if (modelClass) {
                value = [modelClass dictArrayWithModelArray:value];
            }
        }
        NSString *key = [self keyWithIvarName:ivar.ivarName];
        
        dict[key] = value;
    }];
    return dict;
}

#pragma mark - ModelArrayToDictArray
+ (NSArray *)dictArrayWithModelArray:(NSArray *)modelArray
{
    if (![modelArray isKindOfClass:[NSArray class]]) {
        return modelArray;
    }
    NSMutableArray *dictArray = [NSMutableArray array];
    
    [modelArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [dictArray addObject:[obj toDictionary]];
        
    }];
    
    return dictArray;
}

#pragma mark - DictArrayToModelArray
+ (NSMutableArray *)modelArrayWithDictArray:(NSArray *)dictArray
{
    
    if (![dictArray isKindOfClass:[NSArray class]]) {
        return (NSMutableArray *)dictArray;
    }
    NSMutableArray *modelArray = [NSMutableArray array];
    
    [dictArray enumerateObjectsUsingBlock:^(NSDictionary *    dict, NSUInteger idx, BOOL *   stop) {
        if ([dict isKindOfClass:[NSDictionary class]]){
            id model = [self modelWithKeyValues:dict];
            [modelArray addObject:model];
        }
    }];
    
    //    for (NSDictionary *dict in dictArray) {
    //        if (![dict isKindOfClass:[NSDictionary class]]) continue;
    //        id model = [self modelWithKeyValues:dict];
    //        [modelArray addObject:model];
    //    }
    
    return modelArray;
}


#pragma mark 复制参数
- (void)setValueWith:(id)object
{
    if (![object isKindOfClass:self.class]) return;
    [self enumIvarsWith:object andBlock:^(LMQIvar *ivar1, LMQIvar *ivar2, BOOL *stop) {
        id value = ivar2.ivarValue;
        
        ivar1.ivarValue = value;
    }];
}


@end
