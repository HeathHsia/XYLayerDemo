//
//  TenViewController.m
//  CALayerDemo
//
//  Created by FireHsia on 2018/1/5.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

#import "TenViewController.h"

#define kBallCenterX _ballContainerView.center.x
#define kBallContainerViewHeight _ballContainerView.bounds.size.height

@interface TenViewController () <CAAnimationDelegate>

@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UIView *ballContainerView;


@property (nonatomic, strong) UIImageView *ballImage; // 球对象

@end

@implementation TenViewController

// 弹性动画函数
float interpolate (float from, float to, float time)
{
    return (to - from) * time + from;
}

- (id)interpolateFromValue:(id)fromValue toValue:(id)toValue time:(float)time
{
    // 先判断是否是NSValue类型
    if ([fromValue isKindOfClass:[NSValue class]]) {
        // NSValue objcType 返回value类型字符串指针
        // 再通过strcmp C函数来判断type类型
        const char *type = [fromValue objCType];
        // 如果是0 代表类型相等
        if (strcmp(type, @encode(CGPoint)) == 0) {
            
        }
//        strcmp(type, @encode(CGPoint)) == 0
    }
    
    return (time < 0.5) ? fromValue : toValue;
}

#pragma mark --- 弹小球动画
- (void)startBall:(UITapGestureRecognizer *)tap
{
    if (self.ballContainerView.userInteractionEnabled) self.ballContainerView.userInteractionEnabled = NO;
    
    [self.ballContainerView.layer addSublayer:self.ballImage.layer];
    
    CAKeyframeAnimation *ballAnimation = [CAKeyframeAnimation animation];
    ballAnimation.keyPath = @"position";
    ballAnimation.values = @[@(CGPointMake(kBallCenterX, 70)),
                             @(CGPointMake(kBallCenterX, kBallContainerViewHeight - 70)),
                             @(CGPointMake(kBallCenterX, kBallContainerViewHeight - 150)),
                             @(CGPointMake(kBallCenterX, kBallContainerViewHeight - 70))
                             ];
    ballAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]
                                      ];
    ballAnimation.duration = 6.0;
    // keyTimes 从0.0到1.0的相加的数组
    ballAnimation.keyTimes = @[@(0.0), @(0.3), @(0.7), @(1.0)];
    //    ballAnimation.repeatCount = INT_MAX;
    ballAnimation.removedOnCompletion = NO;
    ballAnimation.fillMode = kCAFillModeForwards;
    [self.ballImage.layer addAnimation:ballAnimation forKey:@"kBallAnimation"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (!self.ballContainerView.userInteractionEnabled) self.ballContainerView.userInteractionEnabled = YES;
        [self.ballImage.layer removeFromSuperlayer];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    [bezierPath moveToPoint:CGPointMake(-20, 150)];
    [bezierPath addCurveToPoint:CGPointMake(self.containerView.bounds.size.width + 20, 150) controlPoint1:CGPointMake(130, 20) controlPoint2:CGPointMake(250, 300)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.lineWidth = 5.0;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    
    self.containerView.layer.masksToBounds = YES;
    [self.containerView.layer addSublayer:shapeLayer];
    
    self.ballContainerView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startBall:)];
    [self.ballContainerView addGestureRecognizer:tap];
    
    
    CALayer *layer = [CALayer layer];
    layer.contents = (__bridge id)[UIImage imageNamed:@"air"].CGImage;
    layer.bounds = CGRectMake(0, 0, 30, 30);
    layer.position = CGPointMake(20, 150);
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, M_PI, 0, 0, 1);
    layer.transform = transform;
    [self.containerView.layer addSublayer:layer];
    
    // 小飞机轨迹动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    animation.path = bezierPath.CGPath;
    animation.duration = 5.0;
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = INT_MAX;
    animation.rotationMode = kCAAnimationRotateAuto;
    //    animation.autoreverses = YES;
    [layer addAnimation:animation forKey:nil];
    
}

#pragma mark --- CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([anim isEqual:[self.ballImage.layer animationForKey:@"kBallAnimation"]]) {
        
        [self.ballImage.layer removeFromSuperlayer];
        
    }
}

- (UIImageView *)ballImage
{
    if (!_ballImage) {
        _ballImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ball"]];
        _ballImage.center = CGPointMake(kBallCenterX, 70);
        _ballImage.bounds = CGRectMake(0, 0, 50, 50);
    }
    return _ballImage;
}



@end
