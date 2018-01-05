//
//  SevenViewController.m
//  CALayerDemo
//
//  Created by FireHsia on 2018/1/4.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

#import "SevenViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CustomView.h"

@interface SevenViewController () <CAAnimationDelegate>

@property (nonatomic, strong) UIView *label;



@end

@implementation SevenViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(20, 150)];
    [bezierPath addCurveToPoint:CGPointMake(320, 150) controlPoint1:CGPointMake(75, 75) controlPoint2:CGPointMake(200, 225)];
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.lineWidth = 5.0;
    [self.view.layer addSublayer:shapeLayer];
    
    CALayer *layer = [CALayer layer];
    layer.position = CGPointMake(20, 150);
    layer.bounds = CGRectMake(0, 0, 50, 50);
    layer.backgroundColor = [UIColor greenColor].CGColor;
    [self.view.layer addSublayer:layer];
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    basicAnimation.keyPath = @"backgroundColor";
    basicAnimation.toValue = (__bridge id)[UIColor redColor].CGColor;
    
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animation];
    keyFrameAnimation.keyPath = @"position";
    keyFrameAnimation.path = bezierPath.CGPath;
    keyFrameAnimation.rotationMode = kCAAnimationRotateAuto;
    
    CAAnimationGroup *animationGroup = [[CAAnimationGroup alloc] init];
    animationGroup.animations = @[basicAnimation, keyFrameAnimation];
    animationGroup.duration = 4.0;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    [layer addAnimation:animationGroup forKey:nil];
    
    
}










@end
