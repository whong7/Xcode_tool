//
//  WHCycleFlowLayout.m
//  图片轮播器
//
//  Created by whong7 on 16/7/4.
//  Copyright © 2016年 whong7. All rights reserved.
//

#import "WHCycleFlowLayout.h"

@implementation WHCycleFlowLayout

-(void)prepareLayout
{
    [super prepareLayout];
    self.itemSize = self.collectionView.bounds.size;
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    
    //滚动方法
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}
@end
