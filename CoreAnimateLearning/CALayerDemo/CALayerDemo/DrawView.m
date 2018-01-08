//
//  DrawView.m
//  CALayerDemo
//
//  Created by FireHsia on 2018/1/8.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

#import "DrawView.h"

@interface DrawView()

@property (nonatomic, strong) UIBezierPath *bezierPath; // 绘画轨迹

@property (nonatomic, strong) NSMutableArray *pathArr;
@property (nonatomic, strong) NSMutableArray *delPathArr;
// 每步path
@property (nonatomic, strong) UIBezierPath *stepBezierPath;
// 当前显示path
@property (nonatomic, strong) UIBezierPath *tmpBezierPath;

@property (nonatomic, assign) CGPoint endPoint;

@property (nonatomic, strong) CAShapeLayer *eraserLayer;
@property (nonatomic, strong) UIBezierPath *eraserPath;

@end


@implementation DrawView

#pragma mark --- 将self.layer强制转换成 CAShapeLayer
+ (Class)layerClass
{
    return [CAShapeLayer class];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.bezierPath = [UIBezierPath bezierPath];
    self.eraserPath = [UIBezierPath bezierPath];
    self.layer.masksToBounds = YES;
    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5.0;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    self.pathArr = [NSMutableArray array];
    self.delPathArr = [NSMutableArray array];
    self.drawStatus = DrawPaint;
    [shapeLayer addSublayer:self.eraserLayer];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.layer.masksToBounds = YES;
        self.bezierPath = [UIBezierPath bezierPath];
        self.eraserPath = [UIBezierPath bezierPath];
        CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
        shapeLayer.fillColor = [UIColor clearColor].CGColor;
        shapeLayer.lineWidth = 5.0;
        shapeLayer.strokeColor = [UIColor redColor].CGColor;
        self.pathArr = [NSMutableArray array];
        self.delPathArr = [NSMutableArray array];
        self.drawStatus = DrawPaint;
        [shapeLayer addSublayer:self.eraserLayer];
    }
    return self;
}

#pragma mark --- Touchu
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    if (self.drawStatus == DrawPaint) {
        self.stepBezierPath  = [UIBezierPath new];
        self.tmpBezierPath = [UIBezierPath bezierPathWithCGPath:self.bezierPath.CGPath];
        [self.stepBezierPath moveToPoint:point];
        [self.tmpBezierPath moveToPoint:point];
        self.endPoint = point;
    }else if (self.drawStatus == DrawEraser) {
        [self.eraserPath moveToPoint:point];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    if (self.drawStatus == DrawPaint) {
        [self.stepBezierPath addLineToPoint:point];
        [self.tmpBezierPath addLineToPoint:point];
        [self updateLayerWithPath:self.tmpBezierPath.CGPath];
    }else if (self.drawStatus == DrawEraser) {
        [self.eraserPath addLineToPoint:point];
        [self updateEraserLayerWithPath:self.eraserPath.CGPath];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.drawStatus == DrawPaint) {
        self.endPoint = [[touches anyObject] locationInView:self];
        [self.pathArr addObject:self.stepBezierPath];
        [self.bezierPath appendPath:self.stepBezierPath];
        [self updateLayerWithPath:self.bezierPath.CGPath];
    }else if (self.drawStatus == DrawEraser) {
        
    }
}

#pragma mark ---- 清除操作
- (void)clear
{
    [self.bezierPath removeAllPoints];
    [self.pathArr removeAllObjects];
    [self.delPathArr removeAllObjects];
    [self updateLayerWithPath:self.bezierPath.CGPath];
}

#pragma mark ---- 上一步操作
- (void)recall
{
    if (self.pathArr.count == 0) return;
    [self.delPathArr addObject:[self.pathArr lastObject]];
    [self.pathArr removeLastObject];
    self.bezierPath = [UIBezierPath bezierPath];
    for (UIBezierPath *path in self.pathArr) {
        [self.bezierPath appendPath:path];
    }
    [self updateLayerWithPath:self.bezierPath.CGPath];
}

#pragma mark ---- 下一步操作
- (void)nextStep
{
    if (self.delPathArr.count == 0) return;
    UIBezierPath *path = [self.delPathArr lastObject];
    [self.pathArr addObject:[self.delPathArr lastObject]];
    [self.delPathArr removeLastObject];
    [self.bezierPath appendPath:path];
    [self updateLayerWithPath:self.bezierPath.CGPath];
}

#pragma mark --- 更新layer.path
- (void)updateLayerWithPath:(CGPathRef)path
{
    CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
    shapeLayer.path = path;
}

- (void)updateEraserLayerWithPath:(CGPathRef)path
{
    self.eraserLayer.path = path;
}

#pragma mark --- LazyLoad
- (CAShapeLayer *)eraserLayer
{
    if (!_eraserLayer) {
        _eraserLayer = [CAShapeLayer layer];
        _eraserLayer.fillColor = [UIColor clearColor].CGColor;
        _eraserLayer.lineWidth = 5.0;
        _eraserLayer.strokeColor = self.layer.backgroundColor;
    }
    return _eraserLayer;
}

@end