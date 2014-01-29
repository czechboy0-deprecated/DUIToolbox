//
//  DUIActivityIndicatorItem.m
//  LazyReader
//
//  Created by Honza Dvorsky on 8/14/13.
//  Copyright (c) 2013 Honza Dvorsky. All rights reserved.
//

#import "DUIActivityIndicatorItem.h"

@implementation DUIActivityIndicatorItem
{
    UIActivityIndicatorView *_activityIndicator;
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
