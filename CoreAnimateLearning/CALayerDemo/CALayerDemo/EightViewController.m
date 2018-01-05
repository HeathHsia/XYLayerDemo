//
//  EightViewController.m
//  CALayerDemo
//
//  Created by FireHsia on 2018/1/5.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

#import "EightViewController.h"
#import "AppDelegate.h"

@interface EightViewController () <CAAnimationDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) CALayer *snapLayer;

@end

@implementation EightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.imageView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    // 过渡动画只能对一个图层一次使用一次效果
//    // 对于像imageView的iamge属性来说(非动画属性), 只能添加过渡动画
//    CATransition *transitionAnimation = [CATransition animation];
//    transitionAnimation.type = kCATransitionFromLeft;
////    transitionAnimation.subtype = kCATransitionFromLeft;
//    transitionAnimation.duration = 2.0;
//    [self.imageView.layer addAnimation:transitionAnimation forKey:nil];
//    self.imageView.image = [UIImage imageNamed:@"heathledger"];
//
//    // 如果是自己做过渡动画的话需要先进行图层的截图
//
    
    // 获取视图的截图
    
    @autoreleasepool{
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, [UIScreen mainScreen].scale);
        [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *snapImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        _snapLayer = [[CALayer alloc] init];
        _snapLayer.contents = (__bridge id)snapImage.CGImage;
        _snapLayer.frame = self.view.bounds;
        [self.view.layer addSublayer:_snapLayer];
        CABasicAnimation *basic = [CABasicAnimation animation];
        basic.keyPath = @"position";
        basic.toValue = @(CGPointMake(0, 0));
        basic.duration = 3.0;
        basic.delegate = self;
        [_snapLayer addAnimation:basic forKey:nil];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        window.userInteractionEnabled = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            window.userInteractionEnabled = YES;
        });
    }
    
    
    
    
//    UIImageView *currentImage = [[UIImageView alloc] initWithImage:snapImage];
//    currentImage.frame = self.view.bounds;
//    [self.view.layer addSublayer:currentImage.layer];
//    self.imageView.image = [UIImage imageNamed:@"heathledger"];
    
    
//    [UIView animateWithDuration:3.0 animations:^{
//        CGAffineTransform transform = CGAffineTransformMakeScale(0.1, 0.1);
//        transform = CGAffineTransformMakeRotation(M_PI_2 * 3);
//        currentImage.transform = transform;
//        currentImage.alpha = 0;
//    } completion:^(BOOL finished) {
//        [currentImage removeFromSuperview];
//    }];
   
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [_snapLayer removeFromSuperlayer];
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"air"];
        _imageView.frame = CGRectMake(100, 100, 200, 200);
    }
    return _imageView;
}



@end
