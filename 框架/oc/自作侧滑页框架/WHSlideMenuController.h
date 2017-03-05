//
//  WHSlideMenuController.h
//  制造框架
//
//  Created by whong7 on 16/7/12.
//  Copyright © 2016年 whong7. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WHSlideMenuController : UIViewController

@property(nonatomic,strong)UIViewController *leftViewController;
@property(nonatomic,strong) UIViewController *rootViewController;
- (instancetype)initWithLeftViewController:(UIViewController *)leftViewController andRootViewController:(UIViewController *)rootViewController;

-(void)closeShake;

@end
