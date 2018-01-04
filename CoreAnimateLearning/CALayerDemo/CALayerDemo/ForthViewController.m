//
//  ForthViewController.m
//  CALayerDemo
//
//  Created by FireHsia on 2018/1/3.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

#import "ForthViewController.h"

@interface ForthViewController ()

@property (nonatomic, strong) UIView *containerView; // 创建容器视图

@end

@implementation ForthViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    // CAShaper CGPath
    // 创建一个路径 关于CGPath 和 CAShapeLayer 两个结合使用
//    CGRect rect = CGRectMake(50, 50, 100, 100);
//    CGSize rad = CGSizeMake(20, 20);
//    UIRectCorner corners = UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight;
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:rad];
//
//    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
//    shapeLayer.strokeColor = [UIColor redColor].CGColor;
//    shapeLayer.fillColor = [UIColor clearColor].CGColor;
//    shapeLayer.lineWidth = 5;
//    shapeLayer.lineJoin = kCALineJoinRound;
//    shapeLayer.lineCap = kCALineCapRound;
//    shapeLayer.path = path.CGPath;
//    [self.view.layer addSublayer:shapeLayer];

    //    UIView *labelView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    //    labelView.backgroundColor = [UIColor whiteColor];
    //    [self.view addSubview:labelView];
    
    // CATextLayer
//    CATextLayer *catextLayer = [[CATextLayer alloc] init];
//    catextLayer.string = @" CFStringRef fontName = (__bridge CFStringRef)font.fontName;CGFontRef fontRef = CGFontCreateWithFontName(fontName);textLayer.font = fontRef;textLayer.fontSize = font.pointSize; CGFontRelease(fontRef);";
//    catextLayer.frame = labelView.bounds;
//    [labelView.layer addSublayer:catextLayer];
//
//    // set text attributes
//    catextLayer.foregroundColor = [UIColor blackColor].CGColor;
//    catextLayer.alignmentMode = kCAAlignmentJustified;
//    catextLayer.wrapped = YES;
//
//    // set text font
//    UIFont *font = [UIFont systemFontOfSize:15];
//    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
//    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
//    catextLayer.font = fontRef;
//    catextLayer.fontSize = font.pointSize;
//    catextLayer.contentsScale = [UIScreen mainScreen].scale;
//    CGFontRelease(fontRef);

    //映射图层
    // CATransformLayer 并不是显示平面化的图层, 存在一个作用域子图层的变换才会真正的存在
    // CATransformLayer 装配一个3D图层体系
    // 添加容器视图
    [self.view addSubview:self.containerView];
    CATransform3D pt = CATransform3DIdentity;
    pt.m34 = -1.0 / 500.0;
    self.containerView.layer.sublayerTransform = pt;
    
    CATransform3D ct = CATransform3DIdentity;
    ct = CATransform3DTranslate(ct, 100, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_4, 1, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_4, 0, 1, 0);
    CALayer *cube = [self cubeWithTransform:ct];
    [self.containerView.layer addSublayer:cube];
    
}

- (UIView *)containerView
{
    
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.frame = CGRectMake(100, 100, 200, 200);
        _containerView.backgroundColor = [UIColor purpleColor];
    }
    return _containerView;
    
}

// 根据transform3D 创建一个图层
- (CALayer *)faceWithTransform:(CATransform3D)transform
{
    // 创建图层
    CALayer *face = [CALayer layer];
    // 设置frame
    face.frame = CGRectMake(-50, -50, 100, 100);
    // 设置随机背景颜色
    CGFloat red = (rand() / (double)INT_MAX);
    CGFloat green = (rand() / (double)INT_MAX);
    CGFloat blue = (rand() / (double)INT_MAX);
    face.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1].CGColor;
    // 设置transform3D属性
    face.transform = transform;
    return face;
}

- (CALayer *)cubeWithTransform:(CATransform3D)transform
{
    // create CATransformLayer
    CATransformLayer *cube = [CATransformLayer layer];
    
    // add cube layer1
    CATransform3D ct = CATransform3DMakeTranslation(0, 0, 50);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    // add cube layer2
    ct = CATransform3DMakeTranslation(50, 0, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    // add cube layer3
    ct = CATransform3DMakeTranslation(0, -50, 0);
    ct = CATransform3DRotate(ct, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    // add cube layer4
    ct = CATransform3DMakeTranslation(0, 50, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    // add cube layer5
    ct = CATransform3DMakeTranslation(-50, 0, 0);
    ct = CATransform3DRotate(ct, -M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    // add cube layer6
    ct = CATransform3DMakeTranslation(0, 0, -50);
    ct = CATransform3DRotate(ct, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:ct]];
    
    // 设置图层中心为containerView 容器视图的中心
    CGSize containerSize = self.containerView.bounds.size;
    cube.position = CGPointMake(containerSize.width / 2, containerSize.height / 2);
    cube.transform = transform;
    
    return cube;
    
}



@end
