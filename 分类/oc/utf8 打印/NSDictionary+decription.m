//
//  NSDictionary+decription.m
//  meituanHD
//
//  Created by whong7 on 16/9/17.
//  Copyright © 2016年 whong7. All rights reserved.
//

#import "NSDictionary+decription.h"

@implementation NSDictionary (decription)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSArray *allKeys = [self allKeys];
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"{\t\n "];
    for (NSString *key in allKeys) {
        id value= self[key];
        [str appendFormat:@"\t \"%@\" = %@,\n",key, value];
    }
    [str appendString:@"}"];
    
    return str;
}

@end
