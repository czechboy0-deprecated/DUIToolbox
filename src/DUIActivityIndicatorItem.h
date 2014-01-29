//
//  DUIActivityIndicatorItem.h
//  LazyReader
//
//  Created by Honza Dvorsky on 8/14/13.
//  Copyright (c) 2013 Honza Dvorsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DUIActivityIndicatorItem : UIBarButtonItem

- (instancetype) initWithActivityStyle:(UIActivityIndicatorViewStyle)style;

@property (nonatomic) BOOL animating;

@end
