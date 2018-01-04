//
//  ThirdViewController.m
//  CALayerDemo
//
//  Created by FireHsia on 2018/1/3.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

#import "ThirdViewController.h"
#import <GLKit/GLKit.h>

#define LIGHT_DIRECTION 0, 1, -0.5
#define AMBIENT_LIGHT 0.5

@interface ThirdViewController ()


@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *faces;



@end

@implementation ThirdViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.containerView.backgroundColor = [UIColor clearColor];
    
    // 设置容器子图层的transform 所有子视图的m34值
    CATransform3D perspectice = CATransform3DIdentity;
    perspectice.m34 = -1.0 / 500.0;
    perspectice = CATransform3DRotate(perspectice, -M_PI_4, 1, 0, 0);
    perspectice = CATransform3DRotate(perspectice, -M_PI_4, 0, 1, 0);
    self.containerView.layer.sublayerTransform = perspectice;
    
    // 添加图层1
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 100);
    [self addFaceWithIndex:0 withTransform:transform];
    
    // 添加图层2
    transform = CATransform3DMakeTranslation(100, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
    [self addFaceWithIndex:1 withTransform:transform];
    
    // 添加图层3
    transform = CATransform3DMakeTranslation(0, -100, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFaceWithIndex:2 withTransform:transform];

    // 添加图层4
    transform = CATransform3DMakeTranslation(0, 100, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
    [self addFaceWithIndex:3 withTransform:transform];
    
    // 添加图层5
    transform = CATransform3DMakeTranslation(-100, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
    [self addFaceWithIndex:4 withTransform:transform];
    
    // 添加图层6
    transform = CATransform3DMakeTranslation(0, 0, -100);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
    [self addFaceWithIndex:5 withTransform:transform];
    
    
}

// 给图层面添加灯光效果
- (void)applyLightingToFace:(CALayer *)face
{
    // add lighting layer 添加光照图层
    CALayer *layer = [CALayer layer];
    layer.frame = face.bounds;
    [face addSublayer:layer];
    // convert the face transform to matrix
    CATransform3D transform = face.transform;
    GLKMatrix4 matrix4 = *(GLKMatrix4 *)&transform;
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
    // get face normal
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
    normal = GLKVector3Normalize(normal);
    
    // get dot product with light direction
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION));
    float dotProduct = GLKVector3DotProduct(light, normal);
    // set lighting layer opacity
    CGFloat shadow = 1 + dotProduct - AMBIENT_LIGHT;
    UIColor *color = [UIColor colorWithWhite:0 alpha:shadow];
    layer.backgroundColor = color.CGColor;
}

// 根据index transform 添加face图层面
- (void)addFaceWithIndex:(NSInteger)index withTransform:(CATransform3D)transform
{
    // 获取面视图 添加到容器视图当中
    UIView *face = self.faces[index];
    [self.containerView addSubview:face];
   
    // 设置视图的center都是该视图的center
    CGSize containerSize = self.containerView.bounds.size;
    face.center = CGPointMake(containerSize.width / 2, containerSize.height / 2);
    // 设置显示图层的transform
    face.layer.transform = transform;
    
    [self applyLightingToFace:face.layer];
}


@end
