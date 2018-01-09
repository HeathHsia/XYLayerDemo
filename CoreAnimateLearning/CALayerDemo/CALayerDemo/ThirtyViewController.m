//
//  ThirtyViewController.m
//  CALayerDemo
//
//  Created by FireHsia on 2018/1/9.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

#import "ThirtyViewController.h"
#import "UIImageView+Radius.h"

@interface ThirtyViewController ()

@end

@implementation ThirtyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    // PNG 图片相对大点, 但是解压算法有优化
    // JPEG 图片相对小点, 解压算法复杂, 比PNG解压更耗时
    // 尽量用[UIImage imageWithNamed] 用图片名进行初始化
    // 当加载图片的时候, iOS通常会延迟解压图片的时间, 直到加载到内存之后,这就会准备绘制图片的时候影响性能, 因为需要在绘制之前进行解压(消耗时间所在)
    
    // CATiledLayer 平铺图层
    // 基于NSCache
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"heathledger"]];
//    imageV.backgroundColor = [UIColor redColor];
    imageV.frame = CGRectMake(50, 50, 300, 300);
    imageV.layer.shouldRasterize = YES;
    [imageV setRadius];
    CGRect shadowRect = CGRectMake(-5, -5, imageV.bounds.size.width + 10, imageV.bounds.size.height + 10);
    imageV.layer.shadowColor = [UIColor whiteColor].CGColor;
    imageV.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:shadowRect cornerRadius:20].CGPath;
    imageV.layer.shadowOffset = CGSizeMake(0, 0);
    imageV.layer.shadowOpacity = 1.0;
    [self.view addSubview:imageV];
    
}



@end
