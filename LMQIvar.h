//
//  LMQIvar.h
//  MyExtension
//
//  Created by CNmoosky on 14-7-14.
//  Copyright (c) 2014年 CNmoosky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "LMQType.h"


@class LMQType;

@interface LMQIvar : NSObject

@property(assign, nonatomic)Class srcclass;
@property(weak, nonatomic)id srcObject;
@property(copy, nonatomic, readonly)NSString *name; 
@property(assign, nonatomic, getter = isComeFromFoundation)BOOL comeFromFoundation
;
@property(nonatomic)id ivarValue;
@property(copy, nonatomic, readonly)NSString *ivarName;
@property(assign, nonatomic)Ivar ivar;



/*成员变量类型*/
@property(strong, nonatomic,readonly)LMQType *type;

- (instancetype)initWithIvar:(Ivar)ivar andObject:(id)obj;

@end
