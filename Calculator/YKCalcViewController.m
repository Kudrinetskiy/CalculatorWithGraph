//
//  PSRViewController.m
//  Calculator
//
//  Created by admin on 13.06.14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "YKCalcViewController.h"
#import "YKFunctionViewController.h"
#import "YKCalcView.h"

@interface YKCalcViewController () {
    BOOL isNewNumber;
    int operationTag;
    double previousResult;
    double result;
    int charLimit;
}
@property (nonatomic) NSString * resultString;
@end

@implementation YKCalcViewController

#pragma mark - View controller

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.calcView resetRightButtonsColor];
    [self.calcView setBufferText:@""];
    
    isNewNumber = YES;
    charLimit = 18;
    result = 0;
    self.resultString = @"0";
}

#pragma mark - Setter

- (void)setResultString:(NSString *)resultString
{
    NSRange minusRange = [self.resultString rangeOfString:@"-"];
    
    if (minusRange.location == NSNotFound && resultString.length > charLimit + 1) {
        resultString = [resultString substringToIndex:charLimit + 1];
    }
    
    if (minusRange.location != NSNotFound && resultString.length > charLimit) {
        resultString = [resultString substringToIndex:charLimit];
    }
    
    [self.calcView setResultText:[resultString stringByReplacingOccurrencesOfString:@"." withString:@","]];
    _resultString = resultString;
}

#pragma mark - Actions

-(IBAction)clearPressed:(id)sender
{
    [self.calcView resetDigitButtonsAlpha];
    [self.calcView resetRemoveButtonColor];
    [self.calcView resetRightButtonsColor];
    [self.calcView setBufferText:@""];
    
    self.resultString = @"0";
    result = 0;
    isNewNumber = YES;
}

-(IBAction)dotPressed:(id)sender
{
    if ([self.resultString rangeOfString:@"."].location != NSNotFound) {
        return;
    }

    self.resultString = [self.resultString stringByAppendingString:@"."];
    isNewNumber = NO;
}

- (IBAction)removePressed:(id)sender
{
    if (self.resultString.length >= charLimit) {
        [self.calcView resetDigitButtonsAlpha];
        [self.calcView resetRemoveButtonColor];
    }
    
    NSRange minusRange = [self.resultString rangeOfString:@"-"];
    
    if ((minusRange.location != NSNotFound && self.resultString.length > 2) ||
        (minusRange.location == NSNotFound && self.resultString.length > 1)) {
        self.resultString = [self.resultString substringToIndex:(self.resultString.length - 1)];
        result = [self.resultString doubleValue];
        
        if ([self.resultString hasSuffix:@"0."]) {
            self.resultString = @"0";
            isNewNumber = YES;
            result = 0;
        }
    }
    else {
        self.resultString = @"0";
        isNewNumber = YES;
        result = 0;
    }
}

- (IBAction)plusMinusPressed:(id)sender
{
    if (result == 0) {
        return;
    }
    
    result = -result;
    
    if (result < 0) {
        NSString * minus = @"-";
        self.resultString = [minus stringByAppendingString:self.resultString];
    }
    else {
        self.resultString = [self.resultString substringFromIndex:1];
    }
}

-(IBAction)digitPressed:(id)sender
{
    if (isNewNumber) {
        if ([sender tag] == 0) {
            self.resultString = @"0";
            result = 0;
            return;
        }
        
        self.resultString = @"";
        isNewNumber = NO;
    }
    
    [self.calcView resetRightButtonsColor];

    if (self.resultString.length >= charLimit) {
        return;
    }
    if (self.resultString.length >= charLimit - 1) {
        [self.calcView fadeDigitButtons];
        [self.calcView highlightRemoveButton];
    }
    
    NSString * tempString = [NSString stringWithFormat:@"%d", (int)[sender tag]];
    self.resultString = [self.resultString stringByAppendingString:tempString];
    result = [self.resultString doubleValue];
}

-(IBAction)signPressed:(id)sender
{
    if (result == 0) {
        [self.calcView setBufferText:@""];
        return;
    }
    
    [self.calcView resetDigitButtonsAlpha];
    [self.calcView resetRemoveButtonColor];
    [self.calcView resetRightButtonsColor];
    [sender setBackgroundColor:[UIColor colorWithRed:1 green:190.0/255 blue:115.0/255 alpha:1]];
    NSString * bufferString = [self.resultString stringByAppendingString:[sender titleLabel].text];
    bufferString = [bufferString stringByReplacingOccurrencesOfString:@"." withString:@","];
    [self.calcView setBufferText:bufferString];

    isNewNumber = YES;
    previousResult = result;
    operationTag = (int)[sender tag];
}

- (IBAction)equalsPressed:(id)sender
{
    [self.calcView resetRightButtonsColor];
    [self.calcView resetDigitButtonsAlpha];
    [self.calcView resetRemoveButtonColor];
    
    double newResult = result;
    
    switch (operationTag) {
        case 1001: // addition "+"
            newResult += previousResult;
            break;
        case 1002: // subtraction "-"
            newResult = previousResult - newResult;
            break;
        case 1003: // multiplication "×"
            newResult *= previousResult;
            break;
        case 1004: // division "÷"
            newResult = previousResult / newResult;
            break;
        default:
            self.resultString = @"0";
            return;
    }
    
    if (newResult == -0) {
        newResult = 0;
    }
    
    operationTag = 0;
    previousResult = newResult;
    result = newResult;
    [self.calcView setBufferText:@""];
    self.resultString = [self doubleToString:result];
}

#pragma mark - Private

- (NSString *)doubleToString:(double)doubleValue
{
    NSString * string;

    if (fmod(doubleValue, 1.0) == 0) {
        string = [NSString stringWithFormat:@"%.0f", doubleValue];
        
        if (string.length > charLimit) {
            [self.calcView setBufferText:@"result is too long!"];
        }
    }
    else {
        string = [NSString stringWithFormat:@"%.15g", doubleValue];
    }
    
    return string;
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString * previousString = [NSString stringWithFormat:@"%.5g", previousResult];
    NSString * formula = [NSString stringWithFormat:@"%@*x/%@*x", previousString, self.resultString];
    [segue.destinationViewController setFormula:formula];
}

@end
