//
//  DUIModalActivityView.m
//  DUIToolbox
//
//  Created by Honza Dvorsky on 8/22/13.
//

#import "DUIModalActivityView.h"
#import <QuartzCore/QuartzCore.h>
#import "DUIConstraintFactory.h"

@implementation DUIModalActivityView

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (instancetype) modalActivityView
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    return [[self alloc] init];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (instancetype)init
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    self = [super init];
    if (self) {
        // Initialization code
        
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addSubview:_activityIndicatorView];

        [self addConstraints:[DUIConstraintFactory constraintsForCenterOfItem:_activityIndicatorView
                                                      beingSameAsCenterOfItem:self]];
        
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.7;
        
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
    }
    return self;
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (void) startAnimating
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    self.hidden = NO;
    [self.superview bringSubviewToFront:self];
    [self.activityIndicatorView startAnimating];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (void) stopAnimating
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    [self.activityIndicatorView stopAnimating];
    self.hidden = YES;
}

@end
