//
//  DUITestbedViewController.m
//  Testbed
//
//  Created by Honza Dvorsky on 02/02/14.
//  Copyright (c) 2014 Honza Dvorsky. All rights reserved.
//

#import "DUITestbedViewController.h"
#import "DUIBlockButton.h"
#import "DUIConstraintFactory.h"
#import "DUIBlockDispatcher.h"

@interface DUITestbedViewController ()

@property (nonatomic, strong) DUIBlockButton * blockButton;

@end

@implementation DUITestbedViewController

#pragma mark - UIViewController
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (void) viewDidLoad
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    [super viewDidLoad];
    
    self.blockButton = [DUIBlockButton buttonWithFrame:CGRectZero
                                          clickedBlock:^(DUIBlockButton *button){
                                              NSLog(@"Yay!");
                                          }
                                      forControlEvents:UIControlEventTouchUpInside];
    [self.blockButton setTitle:@"Hello world" forState:UIControlStateNormal];
    self.blockButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.blockButton];
    {
        UIButton *button = self.blockButton;
        
        NSArray * center = [DUIConstraintFactory constraintsForCenterOfItem:button beingSameAsCenterOfItem:button.superview];
        NSArray * size = [DUIConstraintFactory constraintsForCGSize:CGSizeMake(100, 50) ofItem:button];
        
        [button addConstraints:size];
        [button.superview addConstraints:center];
    }
    
    
    
    DUIBlockDispatcher * dispatcher = [DUIBlockDispatcher blockDispatcher];
    
    [dispatcher dispatchBlock:^{
        NSLog(@"Hello block");
    } afterDelay:2.0 onQueue:[NSOperationQueue mainQueue]];
    
    
    
}


@end
