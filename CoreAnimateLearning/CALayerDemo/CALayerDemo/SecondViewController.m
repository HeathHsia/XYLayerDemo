//
//  SecondViewController.m
//  CALayerDemo
//
//  Created by FireHsia on 2018/1/3.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
    CALayer *layer = [[CALayer alloc] init];
    layer.frame = CGRectMake(100, 100, 200, 200);
    layer.backgroundColor = [UIColor yellowColor].CGColor;
    layer.contents = (__bridge id)[UIImage imageNamed:@"heathledger"].CGImage;

    CATransform3D transform = CATransform3DIdentity;
    // M34 这个值会增加透视效果 -1.0 / d   d这个值域200 - 1000 不等 具体需要进行调试
    transform.m34 = -1.0 / 500.0; // d值 调成400 刚好
    transform = CATransform3DRotate(transform, M_PI_4 , 0, 1, 0);
    
    layer.transform = transform;
    layer.doubleSided = NO; // 是否绘制背面视图
    [self.view.layer addSublayer:layer];
    
}


@end
