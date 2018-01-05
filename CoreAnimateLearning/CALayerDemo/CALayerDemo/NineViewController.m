//
//  NineViewController.m
//  CALayerDemo
//
//  Created by FireHsia on 2018/1/5.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

#import "NineViewController.h"

@interface NineViewController ()
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UITextField *repeatCountTextfield;
@property (strong, nonatomic) IBOutlet UITextField *durationTextField;

@end

@implementation NineViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.containerView.layer.contents = (__bridge id)[UIImage imageNamed:@"heathledger"].CGImage;
    // layer图层是否渲染背面
//  self.containerView.layer.doubleSided = NO;
//    self.containerView.layer.cornerRadius = 35;
//    self.containerView.layer.masksToBounds = YES;
    self.containerView.layer.anchorPoint = CGPointMake(0, 0.5);
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1 / 500;
    self.containerView.layer.transform = transform;

    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
}

#pragma mark ---- 添加pan手势
- (void)pan:(UIPanGestureRecognizer *)pan
{
    
}

// 开始动画
- (IBAction)startAnimation:(id)sender {
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    basicAnimation.keyPath = @"transform.rotation.y";
    basicAnimation.byValue = @(M_PI_2);
    basicAnimation.duration = 3; // 单次动画执行时长
    basicAnimation.repeatCount = 1; // 动画重复的次数
//    basicAnimation.timeOffset = 2.0; // 动画从开始时间到几秒开始执行
//    basicAnimation.speed = 2.0; // 动画执行的速度
    basicAnimation.beginTime = 1.0; // 动画开始延迟时间
    // 进行动画回放
    basicAnimation.fillMode = kCAFillModeForwards;
    // fillMode的属性的值
    // kCAFillModeForwards 图层的属性等于动画结束时的属性
    // kCAFillModeBackwards 图层的属性等于在动画之前时的属性
    // 一种的话就是模型图层, 还有一种就是呈现图层
    // 动画过程当中所展现的图层的样式都是呈现的图层的各个属性的变换, 而不是模型图层
    
    // 可以直接根据图层来获取 timeoffset属性
    
    basicAnimation.autoreverses = YES; // 动画是否回放
    [self.containerView.layer addAnimation:basicAnimation forKey:nil];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



@end
