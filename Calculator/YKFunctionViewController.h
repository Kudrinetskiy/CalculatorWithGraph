//
//  YKFunctionViewController.h
//  Calculator
//
//  Created by admin on 23.09.14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKFunctionView.h"

@interface YKFunctionViewController : UIViewController

@property (weak, nonatomic) NSString * formula;
@property (weak, nonatomic) IBOutlet YKFunctionView *functionView;
@property (weak, nonatomic) IBOutlet UILabel *formulaLabel;

@end
