//
//  FiveViewController.m
//  CALayerDemo
//
//  Created by FireHsia on 2018/1/4.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

#import "FiveViewController.h"
#import "CustomView.h"
#import <AVFoundation/AVFoundation.h>


@interface FiveViewController ()

@property (nonatomic, strong) CustomView *containerView;

@end

@implementation FiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.containerView];
    
    // 渐变色layer 图层
    // startPoint endPoint colors locations 渐变决定性4个属性
//    CAGradientLayer *layer = [[CAGradientLayer alloc] init];
//    layer.startPoint = CGPointMake(0, 1);
//    layer.endPoint = CGPointMake(1, 1);
//    layer.locations = @[@(0.2), @(0.5), @(0.8)];
//    layer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor blueColor].CGColor, (__bridge id)[UIColor greenColor].CGColor];
//    layer.frame = CGRectMake(100, 100, 200, 200);
//    [self.view.layer addSublayer:layer];
    
    // CAReplcatorLayer 重复图层
//    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
//    replicatorLayer.frame = CGRectMake(100, 100, 50, 50);
//    replicatorLayer.instanceCount = 2;
//    replicatorLayer.instanceColor = [UIColor purpleColor].CGColor;
////    replicatorLayer.instanceBlueOffset = -0.1;
//    replicatorLayer.instanceDelay = 6.0;
//    replicatorLayer.backgroundColor = [UIColor purpleColor].CGColor;
//
//    CATransform3D ct = CATransform3DIdentity;
//    ct = CATransform3DTranslate(ct, 0, 200, 0);
//    ct = CATransform3DRotate(ct, M_PI / 5, 0, 0, 1);
//    ct = CATransform3DTranslate(ct, 0, -200, 0);
//    replicatorLayer.instanceTransform = ct;
//
//    [self.view.layer addSublayer:replicatorLayer];
    
//    CALayer *layer = [CALayer layer];
//    layer.frame = CGRectMake(100, 100, 100, 100);
//    layer.backgroundColor = [UIColor whiteColor].CGColor;
//    [replicatorLayer addSublayer:layer];
    
    // AVPlayerLayer 显示视频图像图层
    // 设置AVPlayer视频图层, 添加到一个视图的容器里面, 如果旋转设备的话就不用进行图层的frame重新置换
    AVPlayer *player = [AVPlayer playerWithURL:[[NSBundle mainBundle] URLForResource:@"test" withExtension:@"mp4"]];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:playerLayer];
    [player play];
    
    
}

- (CustomView *)containerView
{
    if (!_containerView) {
        _containerView = [[CustomView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
        _containerView.backgroundColor = [UIColor whiteColor];
    }
    return _containerView;
}

@end
