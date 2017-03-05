//
//  NSString+HMCategory.m
//  HMMeiTuanHD19
//
//  Created by heima on 16/9/19.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "NSString+HMCategory.h"

@implementation NSString (HMCategory)

- (instancetype)dealPreceString
{
    /**
     小数点位数超长
     1. 很多0 :  9.900000000001  --> 9.9
     2. 很多9 :  9.989999999999  --> 9.99
     */
    
    /**         长度   -  小数点位置 > 3 就代表超长了
     9.99       4           1
     9.999      5           1
     */
    NSString *currentStr = self;
    
    //4.1 查找小数点位置
    NSInteger currenPriceLocation = [currentStr rangeOfString:@"."].location;
    
    //4.2 判断找到了小数点
    if (currenPriceLocation != NSNotFound) {
        
        //4.3 判断小数点超长 --> 如果找不到会返回NSInter的最大值
        if (currentStr.length - currenPriceLocation > 3) {
            
            //4.4 先截取到后2位  8.80000001 --> 8.80
            currentStr = [currentStr substringToIndex:currenPriceLocation + 3];
            
            //4.5 判断是0还是8
            //如果是0, 就把末尾的0去掉
            if ([currentStr hasSuffix:@"0"]) {
                currentStr = [currentStr substringToIndex:currentStr.length - 1];
                
            }
            
            //如果是8, 就把8替换成9
            // 9.98 --> 9.99
            if ([currentStr hasSuffix:@"8"]) {
                currentStr = [currentStr stringByReplacingCharactersInRange:NSMakeRange(currentStr.length - 1, 1) withString:@"9"];
            }
            
            NSLog(@"price: %@", currentStr);
            
        }
    }
    return currentStr;
}

@end
