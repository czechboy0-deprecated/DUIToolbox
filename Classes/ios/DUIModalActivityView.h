//
//  DUIModalActivityView.h
//  DUIToolbox
//
//  Created by Honza Dvorsky on 8/22/13.
//

#import <UIKit/UIKit.h>

@interface DUIModalActivityView : UIView

@property (nonatomic, strong, readonly) UIActivityIndicatorView * activityIndicatorView;

//sets hidden to no, also
- (void)startAnimating;

//also hides the view
- (void)stopAnimating;

@end
