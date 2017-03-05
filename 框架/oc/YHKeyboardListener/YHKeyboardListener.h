//
//  YHKeyboardListener.h
//  监听键盘
//
//  Created by HaoYoson on 16/7/2.
//  Copyright © 2016年 HaoYoson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  使用方法
 *  单例对象通过block监听
 *  在控制器销毁的时候调用单例对象的clear
 */

@interface YHKeyboardListener : NSObject

@property (copy, nonatomic) void (^willShow)(CGRect);
@property (copy, nonatomic) void (^willHide)();

+ (instancetype)sharedListener;

- (void)clear;

@end
