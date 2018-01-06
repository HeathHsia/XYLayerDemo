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

@property (nonatomic, strong) UIImageView *ballImage; // 球
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CFTimeInterval duration;
@property (nonatomic, assign) CFTimeInterval timeoffset;
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
    
    [super viewDidLoad];
    
    // 添加球
    [self.containerView addSubview:self.ballImage];
    
    // 开始动画
    [self animate];
    
}



#pragma mark ---- animate
- (void)animate
{
//    _timer = [NSTime]
}

- (void)step
{
    
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
