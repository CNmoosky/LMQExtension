//
//  NSObject+Coding.m
//  LMQExtension
//
//  Created by mj on 14-1-15.
//  Copyright (c) 2014年 CNmoosky. All rights reserved.
//

#import "NSObject+Coding.h"
#import "NSObject+Element.h"

@implementation NSObject (Coding)
/**
 *  编码（将对象写入文件中）
 */
- (void)encode:(NSCoder *)encoder
{
    [self enumIvarsWithBlock:^(LMQIvar *ivar, BOOL *stop) {
        if (ivar.isComeFromFoundation) return;
        [encoder encodeObject:ivar.ivarValue forKey:ivar.name];
    }];
}

/**
 *  解码（从文件中解析对象）
 */
- (void)decode:(NSCoder *)decoder
{
    [self enumIvarsWithBlock:^(LMQIvar *ivar, BOOL *stop) {
        if (ivar.isComeFromFoundation) return;
        ivar.ivarValue = [decoder decodeObjectForKey:ivar.name];
    }];
}
@end
