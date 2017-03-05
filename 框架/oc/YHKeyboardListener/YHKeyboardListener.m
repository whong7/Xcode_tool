//
//  YHKeyboardListener.m
//  监听键盘
//
//  Created by HaoYoson on 16/7/2.
//  Copyright © 2016年 HaoYoson. All rights reserved.
//

#import "YHKeyboardListener.h"

@implementation YHKeyboardListener

+ (instancetype)sharedListener
{
    static YHKeyboardListener* sharedListenerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedListenerInstance = [[self alloc] init];
    });
    [sharedListenerInstance setup];
    return sharedListenerInstance;
}

- (void)setup
{
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];

    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    //键盘高度
    CGRect rect = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (self.willShow) {
        self.willShow(rect);
    }
}
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    if (self.willHide) {
        self.willHide();
    }
}

- (void)clear
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
