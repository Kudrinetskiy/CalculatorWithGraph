//
//  PSRFunctionView.m
//  Calculator
//
//  Created by admin on 23.09.14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "YKFunctionView.h"

@implementation YKFunctionView

- (void)drawRect:(CGRect)rect
{
    [self drawGrid:rect];
    [self drawAxes:rect];
    [self drawFunction:rect];
}

- (void)drawFunction:(CGRect)rect
{
    UIBezierPath * function = [UIBezierPath bezierPath];
    function.LineCapStyle = kCGLineCapRound;
    function.lineJoinStyle = kCGLineJoinRound;
    function.lineWidth = 4;
    CGSize viewSize = rect.size;
    [[UIColor blueColor] setStroke];

    double x, y;
    double pixelsInUnit = 40;
    int drawStep = 2;
    BOOL isFirstPoint = YES;
    
    for (int i = 0; i <= viewSize.width - 40; i += drawStep) {
        // calculate in graph grid units
        x = i / pixelsInUnit;
        NSDictionary * argument = @{ @"x" : [NSNumber numberWithFloat:x] };
        y = [[self.expression expressionValueWithObject:argument context:nil] doubleValue];
        // back to pixel points
        x = 20 + x * pixelsInUnit;
        y = viewSize.height - 60 - y * pixelsInUnit;
        
        if (y < 30 || y > viewSize.height - 60) {
            isFirstPoint = YES;
            continue;
        }
        
        if (isFirstPoint) {
            [function moveToPoint:CGPointMake(x, y)];
            isFirstPoint = NO;
        }
        else {
            [function addLineToPoint:CGPointMake(x, y)];
        }
    }
    
    [function stroke];
}

- (void)drawAxes:(CGRect)rect
{
    UIBezierPath * axis = [UIBezierPath bezierPath];
    axis.lineCapStyle = kCGLineCapRound;
    axis.lineJoinStyle = kCGLineJoinRound;
    axis.lineWidth = 2;
    CGSize viewSize = rect.size;
    [[UIColor blackColor] setStroke];
    
    // X axis
    [axis moveToPoint:CGPointMake(10, viewSize.height - 60)];
    [axis addLineToPoint:CGPointMake(viewSize.width - 20, viewSize.height - 60)];
    [axis stroke];
    
    // Y axis
    [axis moveToPoint:CGPointMake(20, 30)];
    [axis addLineToPoint:CGPointMake(20, viewSize.height - 50)];
    [axis stroke];
}

- (void)drawGrid:(CGRect)rect
{
    UIBezierPath * line = [UIBezierPath bezierPath];
    line.lineWidth = 1;
    CGSize viewSize = rect.size;
    [[UIColor lightGrayColor] setStroke];
    
    // horizontal lines
    for (int i = viewSize.height - 60; i >= 30; i -= 40) {
        [line moveToPoint:CGPointMake(20, i)];
        [line addLineToPoint:CGPointMake(viewSize.width - 20, i)];
        [line stroke];
    }
    
    // vertical lines
    for (int i = 60; i <= viewSize.width - 20; i += 40) {
        [line moveToPoint:CGPointMake(i, 30)];
        [line addLineToPoint:CGPointMake(i, viewSize.height - 60)];
        [line stroke];
    }
}

@end
