//
//  LMQType.m
//  MyExtension
//
//  Created by CNmoosky on 14-7-14.
//  Copyright (c) 2014年 CNmoosky. All rights reserved.
//

#import "LMQType.h"

@implementation LMQType

-(instancetype)initWithCode:(NSString *)code
{
    if (self = [super init]) {
        self.code = code;
    }
    return self;
}

-(void)setCode:(NSString *)code
{
    _code = code;
    if (code.length == 0 || [code isEqualToString:@":"] || [code isEqualToString:@"^{objc_ivar=}"] || [code isEqualToString:@"^{objc_method=}"]) {
        _KVCDisabled = YES;
    }else if ([code hasPrefix:@"@"] && code.length > 3){
        _code = [code substringFromIndex:2];
        _code = [_code substringToIndex:_code.length - 1];
        _typeClass = NSClassFromString(_code);
        _fromFoundation = [_code hasPrefix:@"NS"];
    }
}


@end
