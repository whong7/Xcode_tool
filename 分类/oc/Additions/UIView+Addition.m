//
//  UIView+Addition.m
//  004-小画板
//
//  Created by HaoYoson on 16/7/13.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "UIView+Addition.h"

@implementation UIView (Addition)
- (UIImage *)snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);

    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];

    // 能够关闭之后，取结果！
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    // 一定要先关闭，再返回
    return result;
}
@end
