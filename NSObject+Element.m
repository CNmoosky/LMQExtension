//
//  NSObject+Element.m
//  MyExtension
//
//  Created by CNmoosky on 14-7-14.
//  Copyright (c) 2014年 CNmoosky. All rights reserved.
//

#import "NSObject+Element.h"



@implementation NSObject (Element)


-(void)enumIvarsWithBlock:(void (^)(LMQIvar *ivar, BOOL * stop))block
{
    [self enumClassesWithBlock:^(__unsafe_unretained Class c, BOOL *stop) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList(c, &count);
        for (int i = 0; i < count; i ++) {
            LMQIvar *ivar = [[LMQIvar alloc]initWithIvar:ivars[i] andObject:self];
            ivar.srcclass = c;
            block(ivar,stop);
        }
        free(ivars);
        
    }];
}

-(void)enumMethodsWithBlock:(void (^)(__unsafe_unretained Class c, BOOL *stop))block
{
    
}

-(void)enumClassesWithBlock:(void (^)(__unsafe_unretained Class c, BOOL *stop))block
{
    if (block == nil) return;
    
    BOOL stop = NO;
    
    Class c = [self class];
    
    while (c && !stop) {
        block(c,&stop);
        c = class_getSuperclass(c);
    }
}

@end
