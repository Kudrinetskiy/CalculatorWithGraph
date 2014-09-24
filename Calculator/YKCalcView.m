//
//  PSRCalcView.m
//  Calculator
//
//  Created by admin on 21.09.14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "YKCalcView.h"

@interface YKCalcView ()
@property (weak, nonatomic) IBOutlet UILabel * bufferLabel;
@property (weak, nonatomic) IBOutlet UILabel * resultLabel;

@property (weak, nonatomic) IBOutlet UIButton * button_0;
@property (weak, nonatomic) IBOutlet UIButton * button_1;
@property (weak, nonatomic) IBOutlet UIButton * button_2;
@property (weak, nonatomic) IBOutlet UIButton * button_3;
@property (weak, nonatomic) IBOutlet UIButton * button_4;
@property (weak, nonatomic) IBOutlet UIButton * button_5;
@property (weak, nonatomic) IBOutlet UIButton * button_6;
@property (weak, nonatomic) IBOutlet UIButton * button_7;
@property (weak, nonatomic) IBOutlet UIButton * button_8;
@property (weak, nonatomic) IBOutlet UIButton * button_9;
@property (weak, nonatomic) IBOutlet UIButton * button_dot;
@property (weak, nonatomic) IBOutlet UIButton * button_remove;

@property (weak, nonatomic) IBOutlet UIButton * button_divide;
@property (weak, nonatomic) IBOutlet UIButton * button_multiply;
@property (weak, nonatomic) IBOutlet UIButton * button_subtract;
@property (weak, nonatomic) IBOutlet UIButton * button_add;

@property (weak, nonatomic) IBOutlet UIButton * button_equals;
@end

@implementation YKCalcView

- (void)setBufferText:(NSString *)text
{
    self.bufferLabel.text = text;
}

- (void)setResultText:(NSString *)text
{
    self.resultLabel.text = text;
}

- (void)resetRightButtonsColor
{
    UIColor * color = [UIColor colorWithRed:1 green:144.0/255 blue:46.0/255 alpha:1];
    [self.button_add setBackgroundColor:color];
    [self.button_subtract setBackgroundColor:color];
    [self.button_multiply setBackgroundColor:color];
    [self.button_divide setBackgroundColor:color];
    [self.button_equals setBackgroundColor:color];
}

- (void)fadeDigitButtons
{
    self.button_0.alpha = 0.3;
    self.button_1.alpha = 0.3;
    self.button_2.alpha = 0.3;
    self.button_3.alpha = 0.3;
    self.button_4.alpha = 0.3;
    self.button_5.alpha = 0.3;
    self.button_6.alpha = 0.3;
    self.button_7.alpha = 0.3;
    self.button_8.alpha = 0.3;
    self.button_9.alpha = 0.3;
    self.button_dot.alpha = 0.3;
}

- (void)resetDigitButtonsAlpha
{
    self.button_0.alpha = 1;
    self.button_1.alpha = 1;
    self.button_2.alpha = 1;
    self.button_3.alpha = 1;
    self.button_4.alpha = 1;
    self.button_5.alpha = 1;
    self.button_6.alpha = 1;
    self.button_7.alpha = 1;
    self.button_8.alpha = 1;
    self.button_9.alpha = 1;
    self.button_dot.alpha = 1;
}

- (void)resetRemoveButtonColor
{
    [self.button_remove setBackgroundColor:[UIColor colorWithRed:137.0/255 green:141.0/255 blue:148.0/255 alpha:1]];
}

- (void)highlightRemoveButton
{
    [self.button_remove setBackgroundColor:[UIColor colorWithRed:2.0/3 green:2.0/3 blue:2.0/3 alpha:1]];
}

@end
