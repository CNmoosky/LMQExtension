//
//  LMQType.h
//  MyExtension
//
//  Created by CNmoosky on 14-7-14.
//  Copyright (c) 2014年 CNmoosky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMQType : NSObject

@property(copy, nonatomic)NSString *code;
/** 对象类型（如果是基本数据类型，此值为nil） */
@property (nonatomic, assign, readonly) Class typeClass;

/** 类型是否来自于Foundation框架，比如NSString、NSArray */
@property (nonatomic, readonly, getter = isFromFoundation) BOOL fromFoundation;
/** 类型是否不支持KVC */
@property (nonatomic, readonly, getter = isKVCDisabled) BOOL KVCDisabled;


-(instancetype)initWithCode:(NSString *)code;
@end
