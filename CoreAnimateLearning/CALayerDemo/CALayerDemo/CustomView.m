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
    CATransition *transition = [CATransition animation];
    if ([event isEqualToString:@"backgroundColor"] || [event isEqualToString:@"bounds"]) {
        transition.duration = 0.5;
//        transition.type = kCATransitionFade;
//        transition.subtype = kCATransitionFromLeft;
    }
    return transition;
}

@end
