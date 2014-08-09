//
//  NSObject+Coding.m
//  MyExtension
//
//  Created by CNmoosky on 14-7-14.
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
        NSDictionary *dict = nil;
        if ([self respondsToSelector:@selector(ingnoreKeyFromIvarName)]) {
            dict = [self ingnoreKeyFromIvarName];
        }
        if (ivar.isComeFromFoundation || dict[ivar.ivarName]) return;
        [encoder encodeObject:ivar.ivarValue forKey:ivar.ivarName];
    }];
}

/**
 *  解码（从文件中解析对象）
 */
- (void)decode:(NSCoder *)decoder
{
    [self enumIvarsWithBlock:^(LMQIvar *ivar, BOOL *stop) {
        NSDictionary *dict = nil;
        if ([self respondsToSelector:@selector(ingnoreKeyFromIvarName)]) {
            dict = [self ingnoreKeyFromIvarName];
        }
        if (ivar.isComeFromFoundation || dict[ivar.ivarName]) return;
        ivar.ivarValue = [decoder decodeObjectForKey:ivar.ivarName];
    }];
}
@end
