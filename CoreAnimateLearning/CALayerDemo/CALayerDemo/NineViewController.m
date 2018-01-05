//
//  NineViewController.m
//  CALayerDemo
//
//  Created by FireHsia on 2018/1/5.
//  Copyright © 2018年 FireHsia. All rights reserved.
//

#import "NineViewController.h"

@interface NineViewController ()
@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UITextField *repeatCountTextfield;
@property (strong, nonatomic) IBOutlet UITextField *durationTextField;

@end

@implementation NineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.containerView.layer.contents = (__bridge id)[UIImage imageNamed:@"heathledger"].CGImage;
    
}
- (IBAction)startAnimation:(id)sender {
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    basicAnimation.keyPath = @"transform.rotation";
    basicAnimation.toValue = @(M_PI * 2);
    basicAnimation.duration = [self.durationTextField.text floatValue];
    basicAnimation.repeatCount = [self.repeatCountTextfield.text floatValue];
    
    [self.containerView.layer addAnimation:basicAnimation forKey:nil];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



@end
