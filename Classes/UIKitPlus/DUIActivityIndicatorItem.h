//
//  DUIActivityIndicatorItem.h
//  DUIToolbox
//
//  Created by Honza Dvorsky on 8/22/13.
//

#import <UIKit/UIKit.h>

@interface DUIActivityIndicatorItem : UIBarButtonItem

+ (instancetype) indicatorItemWithActivityStyle:(UIActivityIndicatorViewStyle)style;

- (instancetype) initWithActivityStyle:(UIActivityIndicatorViewStyle)style;

@property (nonatomic) BOOL animating;

@end
