//
//  WHSlideMenuController.m
//  制造框架
//
//  Created by whong7 on 16/7/12.
//  Copyright © 2016年 whong7. All rights reserved.
//

#import "WHSlideMenuController.h"

#define kMiddle ((self.leftViewController.view.bounds.size.width-self.offset)*0.5)

@interface WHSlideMenuController ()

@property(nonatomic,strong)UITapGestureRecognizer *tap;

@property(nonatomic,assign)CGFloat  offset;//最右的距离
@end

@implementation WHSlideMenuController

- (instancetype)initWithLeftViewController:(UIViewController *)leftViewController andRootViewController:(UIViewController *)rootViewController
{
    self = [super init];
    if (self) {
        //把两个控制器 都加到自己身上
        //先添加left
        //控制器的view
        [self.view addSubview:leftViewController.view];
        [self.view addSubview:rootViewController.view];
        
        //建立父子关系
        [self addChildViewController:leftViewController];
        [self addChildViewController:rootViewController];
        
         //告诉系统已经添加完成
         [leftViewController didMoveToParentViewController:self];
         [rootViewController didMoveToParentViewController:self];
        
        //赋值
        self.leftViewController = leftViewController;
        self.rootViewController = rootViewController;
        
        //初始化UI
        [self setupUI];
    }
    return self;
}


-(void)setupUI
{
    self.offset = 64 ;
    //添加拖拽手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGesture:)];
    
    //添加到root上
    [self.rootViewController.view addGestureRecognizer:pan];

}

//拖拽手势实现
-(void)panGesture:(UIPanGestureRecognizer *)sender
{
    //获取偏移量
    CGPoint p = [sender translationInView:self.rootViewController.view];

    //判断松手
 
    switch (sender.state)
    {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
        {
            //左滑禁用
            if(p.x<=0)
            {
               if(sender.view.frame.origin.x == 0||sender.view.frame.origin.x <0)
               {
                    return;
               }
               
            }
            
            //改变root的transform
            self.rootViewController.view.transform = CGAffineTransformTranslate(self.rootViewController.view.transform, p.x, 0);
            
            //恢复到初始状态
            [sender setTranslation:CGPointZero inView:self.rootViewController.view];
        }
            break;


        case UIGestureRecognizerStateEnded://结束的时候
        case UIGestureRecognizerStateCancelled://松手的时候
        case UIGestureRecognizerStateFailed://失败的时候
        {
            
            if (self.rootViewController.view.frame.origin.x > kMiddle) {//滑动到右侧
                [self open];
            }
            else {
                [self close];
            }
        }

            break;
            
    }
    
    
}

//打开侧滑
- (void)open
{
    [UIView animateWithDuration:.2 animations:^{
        //改变root的transform
        self.rootViewController.view.transform = CGAffineTransformMakeTranslation(kMiddle * 2, 0);
    }];

    if(!_tap)
    {
    //添加轻敲手势，点击的时候 close
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    [self.rootViewController.view addGestureRecognizer:tap];
        _tap = tap;
    }
  
    
}

//关闭侧滑
- (void)close
{
    [UIView animateWithDuration:.2 animations:^{
        self.rootViewController.view.transform = CGAffineTransformIdentity;
    }];
    //点击以后，这个手势就已经不用了
    [self.rootViewController.view removeGestureRecognizer:self.tap];
    self.tap = nil;//下次open的时候回添加轻敲手势
}

//点击root关闭
-(void)tapGesture:(UITapGestureRecognizer *)sender
{
    [self close];

}


-(void)closeShake
{
    [UIView animateWithDuration:.2 animations:^{
        self.rootViewController.view.transform = CGAffineTransformMakeTranslation(self.leftViewController.view.bounds.size.width, 0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.2 animations:^{
            [self close];
        }];
    }];
}

@end
