//
//  PSRCalcView.h
//  Calculator
//
//  Created by admin on 21.09.14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YKCalcView : UIView

- (void)setBufferText:(NSString *)text;
- (void)setResultText:(NSString *)text;
- (void)resetRightButtonsColor;
- (void)fadeDigitButtons;
- (void)resetDigitButtonsAlpha;
- (void)resetRemoveButtonColor;
- (void)highlightRemoveButton;

@end
