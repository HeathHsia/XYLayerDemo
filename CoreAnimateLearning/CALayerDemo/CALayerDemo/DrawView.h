//
//  DrawView.h
//  CALayerDemo
//
//  Created by FireHsia on 2018/1/8.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    DrawPaint, // 画笔模式
    DrawEraser, // 橡皮擦模式
} DrawStatus;

@interface DrawView : UIView

@property (nonatomic, assign) DrawStatus drawStatus; // 绘画模式

/**
   清除画板
 */
- (void)clear;

/**
    撤回上一步操作
 */
- (void)recall;

/**
    下一步
 */
- (void)nextStep;

@end
