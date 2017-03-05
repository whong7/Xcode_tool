//
//  UIImage+Additions.h
//  YHTodo
//
//  Created by HaoYoson on 16/2/24.
//  Copyright © 2016年 HaoYoson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Additions)

- (UIImage *)tintImageWithColor:(UIColor *)tintColor;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

@end
