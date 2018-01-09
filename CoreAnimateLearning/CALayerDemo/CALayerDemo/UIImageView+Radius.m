//
//  UIImageView+Radius.m
//  CALayerDemo
//
//  Created by FireHsia on 2018/1/9.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

#import "UIImageView+Radius.h"

@implementation UIImageView (Radius)


#pragma mark --- 高效的设置圆角
- (void)setRadius
{
    // 获取当前Image上下文
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 添加path
    CGContextAddPath(context, [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:20].CGPath);
    CGContextClip(context);
    // 这句还是必须要加上的,
    [self drawRect:self.bounds];
    CGContextDrawPath(UIGraphicsGetCurrentContext(), kCGPathFillStroke);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.image = image;
}

@end
