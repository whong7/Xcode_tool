//
//  UIColor+Addition.h
//
//  Created by HaoYoson on 16/6/23.
//  Copyright © 2016年 HaoYoson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Addition)


+ (instancetype)primaryYellowColor;

/**
 * 将传入的16进制数值，转换成对应的颜色 最大颜色数值 0xFFFFFF F => 1111
 *
 * @param hex hex，例如 0xFF0000 红色
 *
 * @return UIColor
 */
+ (instancetype)colorWithHex:(uint32_t)hex;

+ (instancetype)randomColor;

@end
