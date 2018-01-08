//
//  ElevenViewController.m
//  CALayerDemo
//
//  Created by FireHsia on 2018/1/6.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

#import "ElevenViewController.h"

#define kContainerViewX _containerView.center.x
#define kContainerViewHeight _containerView.bounds.size.height

@interface ElevenViewController ()

@property (strong, nonatomic) IBOutlet UIView *containerView; // 容器视图

@property (nonatomic, assign) BOOL isAnimate;

@property (nonatomic, strong) UIImageView *ballImage; // 球
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) CFTimeInterval duration;
@property (nonatomic, assign) CFTimeInterval timeoffset;
@property (nonatomic, assign) CFTimeInterval lastStep;
@property (nonatomic, strong) id fromValue;
@property (nonatomic, strong) id toValue;

@end

@implementation ElevenViewController

- (void)viewDidLoad {
    
    // 对于主线程的runloop 需要管的事件执行清单
    // 1. 处理屏幕的触摸
    // 2. 网络请求发送数据
    // 3. 执行使用gcd代码
    // 4. 处理计时器行为
    // 5. 屏幕重绘
    
    // 屏幕重绘 和 定时器动画行为加入到runloop的行为列表清单当中, 直到等一段时间才会执行, 这个时间没有上限, 可能几毫秒, 也可能几分钟, 而且会在上一个列表中执行完才会执行, 这通常会有几毫秒的延迟, 如果这个任务执行了很长时间, 那么会有很久的延迟
    // 屏幕重绘是每秒钟执行60次, 和定时器任务一样, 需要等上个任务完成才会执行, 可能几毫秒, 也可能几分钟, 取决于上个任务执行的时长, 这个延迟通常是随机的, 会造成动画跳动或者动画卡壳
    
    // 解决方法
    // 1. 使用CADisplayLink 严格按照屏幕刷新频率来进行动画
    // 2. 基于真实帧的持续时间而不是假设的更新频率来做动画
    // 3. 修改动画行为的runloop模式, 而不会被其他行为事件所干扰
    
    
    // CADisplayLink 每秒60次的频率也会出现丢帧的情况, 比如后天程序资源紧张, 就会出现丢帧的情况(本来应该1/60执行一次, 突然这个时间点并没有执行该动作, 就会出现丢帧现象, 用户的直观的感觉就是动画卡顿了一下,)
    
    // 不能计算每一帧的真实时间, 需要在每一帧开始的时间用当前时间进行记录, 然后和上一帧进行比较
    // 通过比较这些时间, 会得到真实的每帧运行时间, 然后代替硬编码1/60秒, 减少丢帧 撕裂现象
    
    // 定时器动画的话需要加入到runloop, 如果防止其他动画或者滚动重绘视图的行为影响到定时器动画, 可以同时加入到NSDefaultRunLoopMode UITrackingRunLoopMode
    
    [super viewDidLoad];
    
//    _isAnimate = NO;
    // 添加球
    [self.containerView addSubview:self.ballImage];
    
    // 开始动画
    [self animate];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self animate];
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
    
    
    if (![self isExitSubView:self.ballImage onView:self.containerView]) {
        [self.containerView addSubview:self.ballImage];
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

- (UIImageView *)ballImage
{
    if (!_ballImage) {
        _ballImage = [[UIImageView alloc] init];
        _ballImage.image = [UIImage imageNamed:@"ball"];
        _ballImage.center = CGPointMake(kContainerViewX, 70);
        _ballImage.bounds = CGRectMake(0, 0, 50, 50);
    }
    return _ballImage;
}



@end
