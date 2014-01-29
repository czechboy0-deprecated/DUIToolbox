//
//  DUIModalActivityView.h
//  LazyReader
//
//  Created by Honza Dvorsky on 8/22/13.
//  Copyright (c) 2013 Honza Dvorsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DUIModalActivityView : UIView

@property (nonatomic, strong, readonly) UIActivityIndicatorView * activityIndicatorView;

//sets hidden to no, also
- (void)startAnimating;

//also hides the view
- (void)stopAnimating;

@end
