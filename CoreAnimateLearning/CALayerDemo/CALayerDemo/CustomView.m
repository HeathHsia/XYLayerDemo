//
//  CustomView.m
//  CALayerDemo
//
//  Created by FireHsia on 2018/1/4.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView



- (instancetype)init
{
    if (self = [super init]) {
        self.layer.delegate = self;
    }
    return self;
}

- (id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event
{
    
    
    // 如果在block中修改计算变量的话, 需要用__block进行修饰
    // 在执行动画或者UI相关的操作的时候, 先进行当前线程的判断, 是否是主线程, 如果是主线程的话, 就直接进行动画操作, 如果不是的话, 异步调用主线程执行动画操作
    
    if ([NSThread isMainThread]) {
        // 当前的UI动画
        
        
    }else {
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            // 确保主线程中执行更新UI操作
            
            
        });
        
    }
    
    CATransition *transition = [CATransition animation];
    if ([event isEqualToString:@"backgroundColor"] || [event isEqualToString:@"bounds"]) {
        transition.duration = 0.5;
//        transition.type = kCATransitionFade;
//        transition.subtype = kCATransitionFromLeft;
    }
    return transition;
    
}

@end
