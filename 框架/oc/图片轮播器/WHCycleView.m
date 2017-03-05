//
//  WHCycleView.m
//  图片轮播器
//
//  Created by whong7 on 16/7/4.
//  Copyright © 2016年 whong7. All rights reserved.
//

#import "WHCycleView.h"
#import "WHCycleFlowLayout.h"
#import "Masonry.h"
#import "WHCycleCell.h"
#import "UIColor+Addition.h"

#define kSeed 2
//collectionView：id
static NSString *cellid = @"Cycle-cell";

@interface WHCycleView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,weak)UICollectionView *collectionView;
@property(nonatomic,weak)UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer* timer;
@end


@implementation WHCycleView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self setupUI];
    }
    return self;
}


-(void)awakeFromNib
{
    [self setupUI];
}

-(void)setupUI
{
    //子控件
    
    WHCycleFlowLayout *layout = [[WHCycleFlowLayout alloc]init];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    
    // 设置数据源和代理
    collectionView.dataSource = self;
    collectionView.delegate = self;
    //注册单元格
    [collectionView registerClass:[WHCycleCell class] forCellWithReuseIdentifier:cellid];
    //设置分页
    collectionView.pagingEnabled = YES;
    //取消弹性效果
    collectionView.bounces = NO;
    //取消指示器
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    
    
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    
    UIPageControl *pageControl = [[UIPageControl alloc]init];

    pageControl.pageIndicatorTintColor = [UIColor yellowColor];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.userInteractionEnabled = NO;
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    
    //自动布局
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.offset(0);
    }];
    
}

//有多少块
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageURLs.count * 2 * kSeed;
}
//cell的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WHCycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    
    // 把需要让cell显示的url传递过去
    cell.imageUrl = self.imageURLs[indexPath.item%self.imageURLs.count];//循环取图
//    cell.backgroundColor = [UIColor randomColor];
    
    return cell;
}



-(void)setImageURLs:(NSArray *)imageURLs
{
    _imageURLs = imageURLs;
    //刷新数据（重新加载数据源）
    [self.collectionView reloadData];
    
    [self.collectionView layoutIfNeeded];//必须写，要不下面不能用collectionview的bounds
    //移动指针
    //方法1 offset
//    self.collectionView.contentOffset = CGPointMake(self.collectionView.bounds.size.width*kSeed, 0);
    //方法2 移动到指定位置
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:imageURLs.count*kSeed inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    //设置pagecontrol的总页数
       self.pageControl.numberOfPages =imageURLs.count;
    
    
    //设置一个时钟装置 创建一个计时器对象 把这个计时器添加到运行循环当中
//    [NSTimer  scheduledTimerWithTimeInterval:2 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];

    
    // 仅仅是创建了一个计时器对象
    NSTimer* timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    self.timer = timer;
    
    // 运行循环
    // 运行循环
    // 1. 默认模式 -  NSDefaultRunLoopMode
    // 在触摸其他控件的时候,计时器会停止(苹果为了流畅,所以才这么设计)
    // 2. 滚动模式+默认模式 -  NSRunLoopCommonModes
    // 不管在触摸其他任何控件时,计时器都会一直走

}

/**
 *  - 拖拽广告的时候应该计时器应该停止
 
 - 监听开始拖拽的方法(代理)
 - 在开始拖拽的时候,让计时器'暂停',把触发的时间改成'未来'
 - 在结束拖拽的时候,让计时器'开始',把触发的时间改成'现在+2s'
 */
// 开始拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView*)scrollView
{
    // 当拖拽的时候 设置下次触发的时间 为 4001年!!!
    self.timer.fireDate = [NSDate distantFuture];
}

// 结束拖拽
- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate
{
    self.timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:2];
}



-(void)updateTimer
{
    // 获取当前的位置
    // 这个方法 表示 获取当前collectionView多有可见的cell的位置(indexPath)
    // 因为就我们这个轮播器而言,当前可见的cell只有一个,所以可以根据last 或者 first 或者 [0] 来获取
    NSIndexPath* indexPath = [self.collectionView indexPathsForVisibleItems].lastObject;
    
    //    indexPath.item = indexPath.item + 1;
    
    // 根据当前页 创建下一页的位置
    NSIndexPath* nextPath = [NSIndexPath indexPathForItem:indexPath.item + 1 inSection:indexPath.section];
    
    [self.collectionView scrollToItemAtIndexPath:nextPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    //手动调用减速完成的方法不好用 ！动画还没有完成 0.2
//    [self scrollViewDidEndDecelerating:self.collectionView];

}

/**
 *  销毁timer，不销毁的话view也不会被销毁
 *- removeFromSuper 并不是view销毁的标识
 - 这个方法仅仅是从视图的层次结构中移除,但view对象没有被销毁
 - dealloc 才是一个对象销毁的标识
 - 当有timer在使用的时候,dealloc根本不会调用
 - 解决办法:removeFromSuper 会先调用, 然后直接销毁timer, 这个view就会成功的被 dealloc
 - 如何销毁timer?
 - [self.timer invalidate];
 */
- (void)removeFromSuperview
{
    [super removeFromSuperview];
    NSLog(@"%s", __func__);
    [self.timer invalidate];
}

// 如果计时器在运行循环中 根本不会调用dealloc方法
- (void)dealloc
{
    NSLog(@"%s", __func__);
}



//动画完成之后调用！！！！
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //手动调用减速完成的方法好用
    [self scrollViewDidEndDecelerating:self.collectionView];
}


//监听手动减速完成（停止滚动）
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // x 偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    // 计算页数
    NSInteger page = offsetX / self.bounds.size.width;
    
    NSLog(@"第 %zd 页", page);
    
    // 获取某一组有多少行
    NSInteger itemsCount = [self.collectionView numberOfItemsInSection:0];
    
    if (page == 0) { // 第一页
        self.collectionView.contentOffset = CGPointMake(offsetX + self.imageURLs.count * self.bounds.size.width*kSeed, 0);
    }
    else if (page == itemsCount - 1) { // 最后一页
        self.collectionView.contentOffset = CGPointMake(offsetX - self.imageURLs.count * self.bounds.size.width*kSeed, 0);
    }
    
}

//正在滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // x 偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    // 计算页数
    CGFloat page = offsetX / self.bounds.size.width+0.5;
    //强转成整数，进行计算
    page = (NSInteger)page%self.imageURLs.count;
    
    self.pageControl.currentPage = page;
//    NSLog(@"%f",page);
}

@end
