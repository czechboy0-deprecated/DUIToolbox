//
//  DUIActivityIndicatorItem.m
//  DUIToolbox
//
//  Created by Honza Dvorsky on 8/22/13.
//

#import "DUIActivityIndicatorItem.h"

@implementation DUIActivityIndicatorItem
{
    UIActivityIndicatorView *_activityIndicator;
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
+ (instancetype) indicatorItemWithActivityStyle:(UIActivityIndicatorViewStyle)style
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    return [[self alloc] initWithActivityIndicatorStyle:style];
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (instancetype) initWithActivityStyle:(UIActivityIndicatorViewStyle)style
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    UIActivityIndicatorView * activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
    if (self = [super initWithCustomView:activity]) {
        _activityIndicator = activity;
    }
    return self;
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
- (void) setAnimating:(BOOL)animating
//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
{
    if (animating) {
        [_activityIndicator startAnimating];
    } else {
        [_activityIndicator stopAnimating];
    }
    
    _animating = animating;
}

@end
