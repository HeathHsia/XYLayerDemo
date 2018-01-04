//
//  SevenViewController.m
//  CALayerDemo
//
//  Created by FireHsia on 2018/1/4.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

#import "SevenViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CustomView.h"

@interface SevenViewController ()

@property (nonatomic, strong) UIView *label;


@end

@implementation SevenViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.label];
    
}

- (void)randColor
{

}

- (UIView *)label
{
    if (!_label) {
        
        _label = [[UIView alloc] init];
        _label.frame = CGRectMake(100, 100, 200, 200);
        _label.layer.backgroundColor = [UIColor redColor].CGColor;
        _label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(randColor)];
        [_label addGestureRecognizer:tap];
        
    }
    return _label;
}



@end
