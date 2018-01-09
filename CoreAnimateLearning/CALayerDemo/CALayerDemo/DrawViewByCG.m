//
//  DrawViewByCG.m
//  CALayerDemo
//
//  Created by FireHsia on 2018/1/9.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

#import "DrawViewByCG.h"

#define BRUSH_SIZE 12

@interface DrawViewByCG ()

@property (nonatomic, strong) NSMutableArray *pointsArr;

@end

@implementation DrawViewByCG

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.pointsArr = [NSMutableArray array];
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.pointsArr = [NSMutableArray array];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    [self.pointsArr addObject:@(point)];
    [self setNeedsDisplayInRect:[self setBrushRecWithPoint:point]];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    
    [self.pointsArr addObject:@(point)];
    [self setNeedsDisplayInRect:[self setBrushRecWithPoint:point]];
}

- (CGRect)setBrushRecWithPoint:(CGPoint)point
{
    return CGRectMake(point.x - BRUSH_SIZE / 2, point.y - BRUSH_SIZE / 2, BRUSH_SIZE, BRUSH_SIZE);
}

- (void)drawRect:(CGRect)rect
{
    UIGraphicsGetPDFContextBounds();
    for (NSValue *value in self.pointsArr) {
        CGPoint point = [value CGPointValue];
        CGRect brushrect = [self setBrushRecWithPoint:point];
        [[UIImage imageNamed:@"air"] drawInRect:brushrect];
    }

}


@end
