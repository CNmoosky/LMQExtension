//
//  LMQIvar.m
//  MyExtension
//
//  Created by CNmoosky on 14-7-14.
//  Copyright (c) 2014年 CNmoosky. All rights reserved.
//

#import "LMQIvar.h"



@implementation LMQIvar

-(instancetype)initWithIvar:(Ivar)ivar andObject:(id)obj
{
    if (self = [super init]) {
        self.srcObject = obj;
        self.ivar = ivar;
    }
    return self;
}

-(void)setSrcclass:(Class)srcclass
{
    _srcclass = srcclass;
    _comeFromFoundation = [NSStringFromClass(srcclass) hasPrefix:@"NS"];
}

-(void)setIvar:(Ivar)ivar
{
    _ivar= ivar;
    _name = [NSString stringWithUTF8String:ivar_getName(ivar)];
    _ivarName = [_name stringByReplacingOccurrencesOfString:@"_" withString:@""];
    NSString *code = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
    _type = [[LMQType alloc]initWithCode:code];
}

-(id)ivarValue
{
    if (_type.KVCDisabled) return [NSNull null];
    return [_srcObject valueForKey:_ivarName];
}



-(void)setIvarValue:(id)ivarValue
{
    if (_type.KVCDisabled) return;
    [_srcObject setValue:ivarValue forKey:_ivarName];
}


@end
