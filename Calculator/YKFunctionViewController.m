//
//  YKFunctionViewController.m
//  Calculator
//
//  Created by admin on 23.09.14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "YKFunctionViewController.h"

@interface YKFunctionViewController ()

@end

@implementation YKFunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];

    self.formulaLabel.text = [NSString stringWithFormat:@"y=%@", self.formula];
    [self.functionView setExpression:[NSExpression expressionWithFormat:self.formula]];
}

- (void)orientationDidChange
{
    [self.view setNeedsDisplay];
}

- (IBAction)doneAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
