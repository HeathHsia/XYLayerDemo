//
//  TenViewController.m
//  CALayerDemo
//
//  Created by FireHsia on 2018/1/5.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

#import "TenViewController.h"

@interface TenViewController ()

@property (strong, nonatomic) IBOutlet UIView *containerView;

@end

@implementation TenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(20, 150)];
    [bezierPath addCurveToPoint:CGPointMake(340, 150) controlPoint1:CGPointMake(130, 20) controlPoint2:CGPointMake(230, 300)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.lineWidth = 5.0;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    [self.containerView.layer addSublayer:shapeLayer];
    
    
    CALayer *layer = [CALayer layer];
    layer.contents = (__bridge id)[UIImage imageNamed:@"air"].CGImage;
    layer.bounds = CGRectMake(0, 0, 30, 30);
    layer.position = CGPointMake(20, 150);
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, M_PI, 0, 0, 1);
    layer.transform = transform;
    [self.containerView.layer addSublayer:layer];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.path = bezierPath.CGPath;
    animation.duration = 3.0;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = INT_MAX;
    animation.rotationMode = kCAAnimationRotateAuto;
    animation.autoreverses = YES;
    [layer addAnimation:animation forKey:nil];
    
}



@end
