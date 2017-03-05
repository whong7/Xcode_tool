//
//  WHCycleCell.m
//  图片轮播器
//
//  Created by whong7 on 16/7/4.
//  Copyright © 2016年 whong7. All rights reserved.
//

#import "WHCycleCell.h"
#import "Masonry.h"

@interface WHCycleCell ()

@property(nonatomic,weak)UIImageView *imageView;


@end

@implementation WHCycleCell

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
    // 创建imageView显示图片
    UIImageView* imageView = [[UIImageView alloc] init];
    // 填充模式
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    // 把多余的部分剪切掉
    imageView.clipsToBounds = YES;
    [self.contentView addSubview:imageView];
    
    //自动布局
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    self.imageView = imageView;
}

-(void)setImageUrl:(NSURL *)imageUrl
{
    _imageUrl = imageUrl;

    // --------把url转成iamge
    // url ->  data
    NSData* data = [NSData dataWithContentsOfURL:imageUrl];
    // data -> image
    UIImage* image = [UIImage imageWithData:data];
    // --------把url转成iamge
    
    // 把数据放在空间上
    self.imageView.image = image;

}




































@end
