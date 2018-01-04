//
//  SixViewController.m
//  CALayerDemo
//
//  Created by FireHsia on 2018/1/4.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

#import "SixViewController.h"

@interface SixViewController ()<CALayerDelegate>
@property (strong, nonatomic) IBOutlet UIView *containerView;

@property (nonatomic, strong) CALayer *colorLayer;

@end

@implementation SixViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _colorLayer = [[CALayer alloc] init];
    _colorLayer.frame = CGRectMake(50, 50, 50, 50);
    _colorLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.containerView.layer addSublayer:_colorLayer];
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    // 给layer的acitons属性赋值(属性对应行为的映射字典)
    _colorLayer.actions = @{@"backgroundColor" : transition};
    
    // 开始UIViewAnimate Block 开始动画块
    [UIView beginAnimations:nil context:nil];
    // 会显示CAAction
    NSLog(@"outside----%@", [self.containerView actionForLayer:self.containerView.layer forKey:@"backgroundColor"]);
    [UIView commitAnimations];
}

- (IBAction)clickColor:(id)sender {

    // 对于隐式动画, 只是改变layer的某个属性, 并没有设置动画时长, 相关的动画属性,
    // 隐式动画时长取决于当前的事务, 动画类型取决于修改图层的行为属性
    // 默认的隐式动画时长为0.25秒
    // 事务的不能创建, 只能压栈入栈, 然后在runloop周期中自动执行事务
    // 和CoreAnimate 中的事务相关的是 Foundation [UIView begin] [UIView commit]两个相对应的方法
    // UIView对于关联图层的隐式动画给禁用掉了
    // 改变layer属性时CALayer自动应用的动画称作行为
    // 属性改变的时候, 会调用actionForKey: 方法, 传递属性的名称,
    // actionForLayer:ForKey属性方法, 如果有的话直接返回, 没有的话直接返回nil, 那么就不会有这个动画的行为, 或者说是隐式动画,(不给与动画开始结束时间, 动画时长等属性).
    
    // 事务设置动画时长 支队CALayer层次上有效, 而对于View层次上是无效的

//   CGRect newBounds = CGRectMake(0, 0, _colorLayer.bounds.size.width,  _colorLayer.bounds.size.height + 120);
//   _colorLayer.bounds = newBounds;
   
    
//    CGRect newBounds = CGRectMake(0, 0, self.containerView.bounds.size.width, self.containerView.bounds.size.height + 100);
//    self.containerView.bounds = newBounds;
//
    // 设置CATransaction 动画事务完成之后的动作
   
    _colorLayer.backgroundColor = [self randColor];
    
}

- (CGColorRef)randColor
{
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    UIColor *randColor = [UIColor colorWithRed:red green:green blue:blue alpha:1
                          ];
    return randColor.CGColor;
}

@end
