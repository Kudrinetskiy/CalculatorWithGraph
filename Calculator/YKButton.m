//
//  PSRButton.m
//  Calculator
//
//  Created by admin on 23.09.14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "YKButton.h"

@implementation YKButton

- (void)drawRect:(CGRect)rect
{
    [self drawGradient:rect];
}

- (void)drawGradient:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceGray();
    CGFloat locations[] = {0, 0.5};
    NSArray * colors = @[(id)[UIColor colorWithWhite:1 alpha:0.4].CGColor,
                         (id)[UIColor colorWithWhite:1 alpha:0.1].CGColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorspace, (CFArrayRef)colors, locations);
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
}

@end
