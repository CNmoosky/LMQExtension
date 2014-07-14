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
        
        if (!value) return;
        if (ivar.type.typeClass && !ivar.type.isFromFoundation) {
            value = [ivar.type.typeClass modelWithKeyValues:value];
        }else if ([self respondsToSelector:@selector(objectClassInArray)]){
            Class modelClass = self.objectClassInArray[ivar.ivarName];
            if (modelClass) {
                value = [modelClass modelArrayWithDictArray:value];
            }
        }
        ivar.ivarValue = value;
        
    }];
}

#pragma mark - DictToModel

+ (instancetype)modelWithKeyValues:(NSDictionary *)dict
{
    if (![dict isKindOfClass:[NSDictionary class]]) {
        [NSException raise:@"The keyvalues is not a NSDictionary" format:nil];
    }
    id model = [[self alloc]init];
    [model setKeyValues:dict];
    return model;
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
        [NSException raise:@"The object is not a NSArray" format:nil];
        return modelArray;
    }
    NSMutableArray *dictArray = [NSMutableArray array];
    for (id model in modelArray) {
        [dictArray addObject:[model toDictionary]];
    }
    
    return dictArray;
}

#pragma mark - DictArrayToModelArray
+ (NSArray *)modelArrayWithDictArray:(NSArray *)dictArray
{
    
    if (![dictArray isKindOfClass:[NSArray class]]) {
        [NSException raise:@"The object is not a NSArray" format:nil];
        return dictArray;
    }
    NSMutableArray *modelArray = [NSMutableArray array];
    for (NSDictionary *dict in dictArray) {
        if (![dict isKindOfClass:[NSDictionary class]]) continue;
        id model = [self modelWithKeyValues:dict];
        [modelArray addObject:model];
    }
    
    return modelArray;
}

@end
