//
//  TenViewController.m
//  CALayerDemo
//
//  Created by FireHsia on 2018/1/5.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

#import "TenViewController.h"

#define kContainerViewX _ballContainerView.center.x
#define kContainerViewHeight _ballContainerView.bounds.size.height

#define kBallCenterX _ballContainerView.center.x
#define kBallContainerViewHeight _ballContainerView.bounds.size.height

@interface TenViewController ()

@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UIView *ballContainerView;

@property (nonatomic, strong) UIImageView *ballImage; // 球对象
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) CFTimeInterval duration;
@property (nonatomic, assign) CFTimeInterval timeoffset;
@property (nonatomic, assign) CFTimeInterval lastStep;
@property (nonatomic, strong) id fromValue;
@property (nonatomic, strong) id toValue;

@end

@implementation TenViewController

// 弹性动画函数
float interpolate (float from, float to, float time)
{
    return (to - from) * time + from;
}

#pragma mark --- 弹性计算point坐标
//- (id)interpolateFromValue:(id)fromValue toValue:(id)toValue time:(float)time
//{
//    // 先判断是否是NSValue类型
//    if ([fromValue isKindOfClass:[NSValue class]]) {
//        // NSValue objcType 返回value类型字符串指针
//        // 再通过strcmp函数 来判断type类型
//        const char *type = [fromValue objCType];
//        if (strcmp(type, @encode(CGPoint)) == 0) {
//
//            CGPoint fromPoint = [fromValue CGPointValue];
//            CGPoint toPoint = [toValue CGPointValue];
//
//
//            CGPoint result = CGPointMake(interpolate(fromPoint.x, toPoint.x, time), interpolate(fromPoint.y, toPoint.y, time));
//
//
//            return [NSValue valueWithCGPoint:result];
//        }
//    }
//    return (time < 0.5) ? fromValue : toValue;
//}

#pragma mark --- 弹小球动画
- (void)startBall:(UITapGestureRecognizer *)tap
{
    [self animate];
//    if (self.ballContainerView.userInteractionEnabled) self.ballContainerView.userInteractionEnabled = NO;
//
//    [self.ballContainerView.layer addSublayer:self.ballImage.layer];
//
//    CFTimeInterval duration = 1.0;
//    NSValue *fromValue = [NSValue valueWithCGPoint:CGPointMake(kBallCenterX, 70)];
//    NSValue *toValue = [NSValue valueWithCGPoint:CGPointMake(kBallCenterX, kBallContainerViewHeight - 70)];
//
//
//    NSInteger numFrames = duration * 60;
//    NSMutableArray *frames = [NSMutableArray array];
//    for (int i = 0; i < numFrames; i++) {
//
//
//
//        float time = 1 / (float)numFrames * i;
//        [frames addObject:[self interpolateFromValue:fromValue toValue:toValue time:time]];
//    }
//
//    CAKeyframeAnimation *ballAnimation = [CAKeyframeAnimation animation];
//    ballAnimation.keyPath = @"position";
//    ballAnimation.values = frames;
////    ballAnimation.values = @[@(CGPointMake(kBallCenterX, 70)),
////                             @(CGPointMake(kBallCenterX, kBallContainerViewHeight - 70)),
////                             @(CGPointMake(kBallCenterX, kBallContainerViewHeight - 150)),
////                             @(CGPointMake(kBallCenterX, kBallContainerViewHeight - 70))
////                             ];
//////    ballAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
////                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
////                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]
////                                      ];
//    ballAnimation.duration = 1.0;
//    // keyTimes 从0.0到1.0的相加的数组
////    ballAnimation.keyTimes = @[@(0.0), @(0.3), @(0.7), @(1.0)];
////    ballAnimation.removedOnCompletion = NO;
////    ballAnimation.fillMode = kCAFillModeForwards;
//
//    [self.ballImage.layer addAnimation:ballAnimation forKey:@"kBallAnimation"];
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if (!self.ballContainerView.userInteractionEnabled) self.ballContainerView.userInteractionEnabled = YES;
//        [self.ballImage.layer removeFromSuperlayer];
//    });
    
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
    [self.ballContainerView addSubview:self.ballImage];
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

- (UIImageView *)ballImage
{
    if (!_ballImage) {
        _ballImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ball"]];
        _ballImage.center = CGPointMake(kBallCenterX, 70);
        _ballImage.bounds = CGRectMake(0, 0, 50, 50);
    }
    return _ballImage;
}

float interpolateBall(float from, float to, float time)
{
    return (to - from) * time + from;
}

- (id)interpolateFromValue:(id)fromValue toValue:(id)toValue time:(float)time
{
    if ([fromValue isKindOfClass:[NSValue class]]) {
        const char *type = [(NSValue *)fromValue objCType];
        if (strcmp(type, @encode(CGPoint)) == 0) {
            CGPoint from = [fromValue CGPointValue];
            CGPoint to = [toValue CGPointValue];
            CGPoint result = CGPointMake(interpolateBall(from.x, to.x, time), interpolateBall(from.y, to.y, time));
            return [NSValue valueWithCGPoint:result];
        }
    }
    
    return (time < 0.5) ? fromValue : toValue;
}

float quadraticEaseInOut(float t)
{
    return (t < 0.5)? (2 * t * t): (-2 * t * t) + (4 * t) - 1; }


float bounceEaseInOut(float p)
{
    if(p < 4/11.0)
    {
        return (121 * p * p)/16.0;
    }
    else if(p < 8/11.0)
    {
        return (363/40.0 * p * p) - (99/10.0 * p) + 17/5.0;
    }
    else if(p < 9/10.0)
    {
        return (4356/361.0 * p * p) - (35442/1805.0 * p) + 16061/1805.0;
    }
    else
    {
        return (54/5.0 * p * p) - (513/25.0 * p) + 268/25.0;
    }
}

// 计算返回弹性时间
float bounceEaseOut(float p)
{
    
    //    if (t < 4/11.0) {
    //        return (121 * t * t)/16.0;
    //    } else if (t < 8/11.0) {
    //        return (363/40.0 * t * t) - (99/10.0 * t) + 17/5.0;
    //    } else if (t < 9/10.0) {
    //        return (4356/361.0 * t * t) - (35442/1805.0 * t) + 16061/1805.0;
    //    }
    //    return (54/5.0 * t * t) - (513/25.0 * t) + 268/25.0;
    
    if(p < 0.5)
    {
        return 0.5 * bounceEaseInOut(p*2);
    }
    else
    {
        return 0.5 * bounceEaseInOut(p * 2 - 1) + 0.5;
    }
}


#pragma mark ---- animate
- (void)animate
{
    
    
    if (![self isExitSubView:self.ballImage onView:self.ballContainerView]) {
        [self.ballContainerView addSubview:self.ballImage];
    }
    
    
    // 重置球的位置
    self.ballImage.center = CGPointMake(kContainerViewX, 70);
    // 初始化动画参数
    self.duration = 2.0;
    self.timeoffset = 0.0;
    self.fromValue = [NSValue valueWithCGPoint:CGPointMake(kContainerViewX, 70)];
    self.toValue = [NSValue valueWithCGPoint:CGPointMake(kContainerViewX, kContainerViewHeight - 70)];
    
    [_timer invalidate]; // invalidate 使无效
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 / 60.0 target:self selector:@selector(step) userInfo:nil repeats:YES];
    //    if (_isAnimate) {
    
    // 获取开始时间
    self.lastStep = CACurrentMediaTime(); // 时间单位上更精确 mach_absolute_time () 获取机器绝对时间 转换成秒单位的
    
    
    
    
    //        [_displayLink invalidate];
    //        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(step)];
    //        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    //
    //    }else {
    //        [_displayLink invalidate];
    //        [self.ballImage removeFromSuperview];
    //    }
    
    //    _isAnimate = !_isAnimate;
    
    
}

- (BOOL)isExitSubView:(UIView *)subView onView:(UIView *)view
{
    NSArray *subArray = view.subviews;
    for (UIView *view in subArray) {
        if ([view isEqual:subView]) {
            return YES;
        }
    }
    return NO;
}

- (void)step
{
    
    CFTimeInterval thisStep = CACurrentMediaTime();
    CFTimeInterval thisDuration = thisStep - self.lastStep;
    self.lastStep = thisStep;
    
    //    NSLog(@"thisDuration- %f", thisDuration);
    
    // 记录动画已经运行的时间
    self.timeoffset = MIN(self.timeoffset + thisDuration, self.duration);
    //    NSLog(@"timeoffset ---%f", self.timeoffset);
    
    // 获取标准的时间偏移量 (0 - 1)
    float time = self.timeoffset / self.duration;
    //    NSLog(@"time ---------%f", time);
    
    // 过渡性动画时间计算
    time = bounceEaseOut(time);
    
    // 更新球的位置
    id position = [self interpolateFromValue:self.fromValue toValue:self.toValue time:time];
    self.ballImage.center = [position CGPointValue];
    
    // 运行时间等于动画时长 停止动画 关闭定时器
    if (self.timeoffset >= self.duration) {
        //        [self.displayLink invalidate];
        //        self.displayLink = nil;
        [self.ballImage removeFromSuperview];
        self.timeoffset = 0.0;
        [self.timer invalidate];
        self.timer = nil;
    }
}


@end
