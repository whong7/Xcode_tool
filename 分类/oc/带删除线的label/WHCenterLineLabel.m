//
//  WHCenterLineLabel.m
//  meituanHD
//
//  Created by whong7 on 16/9/20.
//  Copyright © 2016年 whong7. All rights reserved.
//

#import "WHCenterLineLabel.h"

@implementation WHCenterLineLabel

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    //moveToPoint  addLineToPoint 连一条线
    
    //画矩形
    UIRectFill(CGRectMake(0, rect.size.height * 0.5 - 0.5 , rect.size.width, 1));
    
}

@end
