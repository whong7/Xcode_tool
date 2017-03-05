//
//  NSArray+decription.m
//  meituanHD
//
//  Created by whong7 on 16/9/17.
//  Copyright © 2016年 whong7. All rights reserved.
//

#import "NSArray+decription.h"

@implementation NSArray (decription)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString stringWithFormat:@"%lu (\n", (unsigned long)self.count];
    
    for (id obj in self) {
        [str appendFormat:@"\t%@, \n", obj];
    }
    
    [str appendString:@")"];
    
    return str;
}

@end
