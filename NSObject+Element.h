//
//  NSObject+Element.h
//  MyExtension
//
//  Created by CNmoosky on 14-7-14.
//  Copyright (c) 2014年 CNmoosky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMQIvar.h"



@interface NSObject (Element)

- (void)enumIvarsWithBlock:(void(^)(LMQIvar *ivar,BOOL *stop))block;

- (void)enumMethodsWithBlock:(void(^)(Class c,BOOL *stop))block;

- (void)enumClassesWithBlock:(void(^)(Class c,BOOL *stop))block;

@end
