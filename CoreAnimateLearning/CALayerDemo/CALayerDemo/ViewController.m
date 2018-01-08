//
//  ViewController.m
//  CALayerDemo
//
//  Created by FireHsia on 2017/12/28.
//  Copyright © 2017年 FireHsia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <CALayerDelegate>

@property (nonatomic, strong) CALayer *layer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addCustomLayer];
}

#pragma mark --- 添加一个图层
- (void)addCustomLayer
{    
    UIView   *blueLayer = [[UIView alloc] init];
    blueLayer.backgroundColor = [UIColor orangeColor];
    blueLayer.frame = CGRectMake(50, 50, 50, 50);
    [self.layer addSublayer:blueLayer.layer];

    // 一般情况下处理视图都会比直接处理图层要方便的多
    [self.view.layer addSublayer:self.layer];
    
}

#pragma mark --- 懒加载初始化
- (CALayer *)layer
{
    /*
     CALayer不用处理用户响应的交互, 即使提供是否点击在当前的图层上
     视图层级 图层树 呈现树 渲染树
     UIView相关的API是对CALayer的方法的高级的封装
     但是同时还有一些是UIView没有暴露出来CALayer的功能: 阴影, 圆角, 带颜色的边框, 3D变换, 非矩形范围, 透明遮罩, 多级非线性动画. 但是大部分都已经可以从UIView相关的API进行设置
     */
    
    if (!_layer) {
        _layer = [[CALayer alloc] init];
        _layer.frame = CGRectMake(100, 200, 200, 200);
        _layer.backgroundColor = [UIColor orangeColor].CGColor;
        // CGImage 需要进行桥接转换成id类型
        _layer.opacity = 0.5;
        // 阴影设置
        // 因为阴影显示的话是在图层之外, 所以maskToBounds属性是不显示图层之外的, 就会默认将阴影裁剪
//        _layer.shadowOpacity = 3.0; // 设置阴影设置的参数 0.0 - 1.0浮点数
//        _layer.shadowRadius = 10;
//        _layer.shadowOffset = CGSizeMake(5, 5);
//        _layer.shadowColor = [UIColor blackColor].CGColor;
        
        // 减少阴影区域计算时间, 添加一个CGPathRef路径上下文属性, 如果更复杂的图层形状的话需要用到UIBezierPath
        
        // 拉伸过滤
        
        
        /*
        // 寄宿图, 就是图层所包含的内容contents, contents类型是id类型, 任意指针类型, 当然只有是CGImage类型的时候才会显示图片, 否则就是一个空白的显示
        // 设置寄宿图以及寄宿图在视图中显示的相关设置,
            contentGravity显示的模式,
         maskToBounds是否显示超过视图边框的图层,
         contentScale 定义寄宿图像素尺寸和视图大小的比例, 一般都是默认
         contentRect 寄宿图显示的子域 默认的(0, 0, 1, 1)
         */
        
//        _layer.contents = (__bridge id)[UIImage imageNamed:@"heathledger"].CGImage;
//        _layer.contentsGravity = kCAGravityResizeAspectFill;
        _layer.contentsRect = CGRectMake(0, 0, 1, 1);
        _layer.contentsCenter = CGRectMake(0, 0, 1, 1);
//         _layer.anchorPointZ = 0.8;
//        _layer.anchorPoint = CGPointMake(0, 0);
//        _layer.masksToBounds = YES; // UIView.clipsToBounds 是否显示超出视图范围的图层
        _layer.delegate = self;
       
        /*
         Custom Drawwing 自定义绘制
         可以给图层直接设置contents寄宿图, 也可以继承UIView 重写drawrect方法进行绘制
         如果drawRect创建了的话, 系统会默认创建视图大小*scale像素大小的内存空间来表示空的寄宿图
         当视图显示在屏幕上的时候, 系统就会自动调用drawRect, 当调用setNeedDisplay的时候会重新执行drawRect方法进行重绘, drawRect底层也是layer的实现
         
         */
        
        // CALayer 有一个optional delegate方法
         [_layer display]; // 调用该方法的时候,会重绘视图, 才会执行代理方法, 重绘的方式交给了开发者
    
        /*
         UIView frame bounds center
         CALayer frame bounds position
         frame: 图形旋转之后轴对齐的举行区域  的值主要是由 bounds center/postion transform三个要素来决定的, 如果有某个值改变了, 那么frame相应的会做出改变
         
         关于锚点的相关的设置, 如果改变锚点的话只是改变frame, 但是并不会修改position的属性, 这个值还是固定不变的
         UIView.center 和 CALayer.position两个属性都是根据锚点
         如果锚点不在0.5, 0.5范围之内的话, 图层显示的话还是会存在寄宿图之外的
         
         关于ZanchoriPoint 锚点Z坐标的值 用来3D旋转transform3D图层
         
         */
        
    
    }
    return _layer;
}

#pragma mark --- CALayer Delegate
- (void)displayLayer:(CALayer *)layer
{
    
    // Layer层代理方法
//    CALayer *yellowLayer = [[CALayer alloc] init];
//    yellowLayer.backgroundColor = [UIColor yellowColor].CGColor;
//    yellowLayer.frame = CGRectMake(50, 50, 50, 50);
//    [layer addSublayer:yellowLayer];

//    // 获取当前上下文
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(ctx, 5);
//    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
//    CGContextStrokeEllipseInRect(ctx, layer.bounds);
    
    
    
}


- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
//    CGContextSetLineWidth(ctx, 5);
//    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
//    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}

@end
