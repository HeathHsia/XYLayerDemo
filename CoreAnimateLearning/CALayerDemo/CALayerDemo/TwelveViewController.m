//
//  TwelveViewController.m
//  CALayerDemo
//
//  Created by FireHsia on 2018/1/6.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

#import "TwelveViewController.h"
#import "DrawView.h"
#import "DrawViewByCG.h"

@interface TwelveViewController ()
@property (strong, nonatomic) IBOutlet DrawViewByCG *drawView;

@end

@implementation TwelveViewController

#pragma mark --- 橡皮
- (IBAction)eraser:(id)sender {
    
}

#pragma mark --- 画笔
- (IBAction)paint:(id)sender {
    
}

#pragma mark --- 清除
- (IBAction)clear:(id)sender {
}

#pragma mark --- 上一步
- (IBAction)recall:(id)sender {
}

#pragma mark --- 下一步
- (IBAction)nextStep:(id)sender {
}
- (void)viewDidLoad {
    
    // 性能优化 CPU GPU
    
    // 关于CPU GPU
    // GPU使用图像对高度进行浮点运算进行优化, 尽可能的把图像的处理交给GPU硬件进行处理, 但是GPU资源有限, 资源用尽性能就会下降, 同样体验也不是很好
    
    // 什么方式是使用CPU 什么方式是使用GPU呢,  怎么综合使用呢?
    
    // 动画和屏幕组合的图层是被一个BackBoard单独进程管理(渲染服务)
    // 运行一段动画  分为四个步骤:  (这是CPU执行的阶段)
    // 1. 布局 准备你要显示的视图/图层的层级关系以及设置图层属性的数据
    // 2. 显示 图层的寄宿图片绘制的阶段 设计到drawRect方法
    // 3. 准备 CoreAnimation 准备发送动画数据到渲染服务的阶段, 同时还要进行解码动画过程中显示的图片的时间点
    // 4. 提交 CoreAnimation 打包所有的图层和动画的属性, 发送到IPC(内部处理通信)送到渲染服务进行显示
    
    // 当渲染服务拿到打包的图层和动画的属性数据, 被反序列化成渲染树, 使用这个树结构, 渲染服务对每一帧的动画做如下操作
    // 1. 对所有的图层属性计算中间值, 设置OpenGL几何形状(纹理化的三角形)来执行渲染
    // 2. 在屏幕上渲染可见的三角形 (这是由GPU执行的阶段)
    // 动画过程是后面两个步骤不停的重复 前五个是在软件层面上(CPU处理)最后一个被GPU执行
    
    // 只能控制前两个阶段(布局, 显示)
    
    // GPU的操作, 大多数的CALayer的属性都是由GPU进行绘制的
    // 下面的一些现象会限制GPU的速度
    // 1. 太多的几何结构 2. 重绘制 3. 离屏渲染(多个不同透明度的图层混合) 4.过大的图片
    
    // CPU的操作, 软件层次上的计算, 他虽然不会影响帧率, 但是会延迟动画的开始时间, 视觉上会感觉比较迟钝
    // 1. 布局计算 (视图层级过于复杂, 视图的呈现, 修改 布局的刷新)
    // 2. 视图懒加载 (显示视图的时候 才会初始化视图, 大量的视图初始化, 计算布局会消耗CPU的资源), 显示之前还要做这些工作.
    // 3. CoreGraphics 通过drawRect方法进行渲染寄宿图的话, 就会创建该视图同样大小的内存的视图, 绘制结束后, 将图片数据通过IPC上传到渲染服务器
    
    // 图层层级结构越复杂, 需要CPU计算的越多, 消耗CPU资源比较多
    
    // 通过定时器 能保证动画不掉帧
    
    // 关于软件绘图,
    // 如果实现了CALayerDelegate中的-drawLayer:(CALayer)layer context,或者视图的-drawLayer方法(对前者方法的包装), 那么每次重绘都会销毁寄宿图大小的内存, 然后重新分配创建该大小的内存
    
    [super viewDidLoad];
    
    
    
}




@end
