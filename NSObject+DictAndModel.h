//
//  NSObject+DictAndModel.h
//  MyExtension
//
//  Created by CNmoosky on 14-7-14.
//  Copyright (c) 2014年 CNmoosky. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DictAndModel <NSObject>
@optional
/**
 *  将属性名换为其他key去字典中取值
 *  @return 字典中的key是属性名，value是从字典中取值用的key
 */
- (NSDictionary *)replacedKeyFromIvarName;

/**
 *  数组中需要转换的模型类
 *  @return 字典中的key是数组属性名，value是数组中存放模型的Class
 */
- (NSDictionary *)objectClassInArray;
@end

@interface NSObject (DictAndModel)<DictAndModel>

/*模型数组转字典数组*/
+ (NSArray *)dictArrayWithModelArray:(NSArray *)modelArray;

/*字典数组转模型数组*/
+ (NSArray *)modelArrayWithDictArray:(NSArray *)dictArray;

/*模型转字典*/
- (NSDictionary *)toDictionary;

/*字典转模型*/
+ (instancetype)modelWithKeyValues:(NSDictionary *)dict;




@end
