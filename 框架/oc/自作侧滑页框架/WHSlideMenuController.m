//
//  WHSlideMenuController.m
//  制造框架
//
//  Created by whong7 on 16/7/12.
//  Copyright © 2016年 whong7. All rights reserved.
//

#import "WHSlideMenuController.h"
#import "UIColor+Addition.h"
#import "Masonry.h"

#define kMiddle ((self.leftViewController.view.bounds.size.width-self.offset)*0.5)

@interface WHSlideMenuController ()

@property(nonatomic,strong)UITapGestureRecognizer *tap;

@property(nonatomic,assign)CGFloat  offset;//最右的距离

@property(nonatomic) CGAffineTransform transformLeft;

@end

@implementation WHSlideMenuController

- (instancetype)initWithLeftViewController:(UIViewController *)leftViewController andRootViewController:(UIViewController *)rootViewController
{
    self = [super init];
    if (self) {
        //布局自己的view
        [self setupUI1];
       
        //调整左页面的frame
        CGRect rect = leftViewController.view.frame;
        rect.origin.x -=40;
        leftViewController.view.frame = rect;
        
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
-(void)setupUI1
{
    self.view.backgroundColor = [UIColor colorWithHex:0x12B7F5];
    //添加图片
    UIImage *image = [UIImage imageNamed:@"sidebar_bg"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    [self.view addSubview:imageView];
    
    //进行布局
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(0);
        make.right.offset(20);
        make.height.equalTo(imageView.mas_width).multipliedBy(image.size.height/image.size.width);
    }];

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
         
               if(sender.view.frame.origin.x+p.x <0)
               {
//                   NSLog(@"%f",sender.view.frame.origin.x+p.x);
                    return;
               }
             //右滑禁止
            if(sender.view.frame.origin.x+p.x > kMiddle*2)
            {
                return;
            }

            
            //改变root的transform
            self.rootViewController.view.transform = CGAffineTransformTranslate(self.rootViewController.view.transform, p.x, 0);
            //改变left的transform
            self.leftViewController.view.transform = CGAffineTransformTranslate(self.leftViewController.view.transform, p.x*0.2, 0);
            
            if(self.transformLeft.tx<self.leftViewController.view.transform.tx)
            {
                self.transformLeft = self.leftViewController.view.transform;
            }
            



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
        //改变leftViewController的transform
        self.leftViewController.view.transform = self.transformLeft;
        
    }];

    if(!_tap)//如果有tap手势，就不添加手势了
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
        //调整左页面的frame
        CGRect rect = self.rootViewController.view.frame;
        rect.origin.x -=40;
        self.leftViewController.view.frame = rect;
        
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

//切换动作
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
